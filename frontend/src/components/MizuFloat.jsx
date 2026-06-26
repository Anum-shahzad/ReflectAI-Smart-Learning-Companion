import { useState, useEffect, useRef, useCallback } from 'react'
import MizuCharacter from './MizuCharacter'
import { useMizuListener, mizuReact } from '../hooks/useMizu'

const MIZU_SIZE  = 64
const MIZU_H     = Math.round(MIZU_SIZE * (320 / 280))  // ~73px
const RIGHT_INSET = 80   // px from right viewport edge — increase to move Mizu more left

// For each tab, list the perch IDs in order top-to-bottom.
// Mizu sits on whichever one is closest to the top of the visible viewport.
// useCardX: true  → X comes from card's own right edge (narrow/centered cards like Settings)
// useCardX: false → X is fixed: viewport width − MIZU_SIZE − RIGHT_INSET
// fixedY: number  → skip card lookup, use this Y directly (Learn has no right-edge card)
const PERCH_MAP = {
  evaluate: [
    { id: 'evaluate-main'    },
    { id: 'evaluate-results' },
  ],
  history:  [{ id: 'history-main'  }],
  notes:    [
    { id: 'notes-main'    },
    { id: 'notes-content' },
  ],
  analytics: [
    { id: 'analytics-stats-row'  },
    { id: 'analytics-scoretrend' },
    { id: 'analytics-weekly'     },
  ],
  settings: [{ id: 'settings-profile-card', useCardX: true }],
  learn:    [{ fixedY: 125 }],   // no card — fixed position on right wall
}

function trimLine(line) {
  if (!line) return line
  const words = line.trim().split(' ')
  return words.length <= 8 ? line : words.slice(0, 7).join(' ') + '.'
}

// ─── Core position calculator ────────────────────────────────────────────────
// Called any time we need to know where Mizu should be.
// Returns { x, y } in fixed px, or null if nothing to sit on.
function calcCoords(tab, perchIndex) {
  const vw     = window.innerWidth
  const fixedX = vw - MIZU_SIZE - RIGHT_INSET

  const perches = PERCH_MAP[tab]
  if (!perches || !perches.length) return { x: fixedX, y: 200 }

  const perch = perches[perchIndex] ?? perches[0]

  // Fixed-Y mode (Learn language list)
  if (perch.fixedY !== undefined) return { x: fixedX, y: perch.fixedY }

  const el = perch.id
    ? document.querySelector(`[data-mizu-perch="${perch.id}"]`)
    : null

  if (!el) return null

  const rect = el.getBoundingClientRect()
  if (rect.width === 0 && rect.height === 0) return null   // not rendered yet
  if (rect.bottom < 0 || rect.top > window.innerHeight) return null

  // X: card's own right edge (narrow card) OR fixed viewport inset (full-width card)
  const x = perch.useCardX
    ? Math.round(rect.right) - MIZU_SIZE - 8
    : fixedX

  // Y: Mizu's feet touch the card's top border line.
  // 75% of his body is above the line, 25% hangs below — wall-sitting illusion.
  const y = Math.round(rect.top) - Math.round(MIZU_H * 0.75)

  return { x, y }
}

// ─── Pick which perch index is most appropriate given current scroll ─────────
// Returns the index of the perch whose top border is closest to 180px from the
// top of the viewport (a good "just entered view" threshold).
function bestPerchIndex(tab) {
  const perches = PERCH_MAP[tab]
  if (!perches || perches.length <= 1) return 0

  let best = 0
  let bestDist = Infinity

  perches.forEach((p, i) => {
    if (!p.id) return
    const el = document.querySelector(`[data-mizu-perch="${p.id}"]`)
    if (!el) return
    const rect = el.getBoundingClientRect()
    if (rect.bottom < 0 || rect.top > window.innerHeight) return
    const dist = Math.abs(rect.top - 180)
    if (dist < bestDist) { bestDist = dist; best = i }
  })

  return best
}

// ─────────────────────────────────────────────────────────────────────────────
export default function MizuFloat({ activeTab = 'default' }) {
  const [visible, setVisible] = useState(false)
  const [coords,  setCoords]  = useState(null)
  const [speech,  setSpeech]  = useState(null)
  const [mood,    setMood]    = useState('idle')

  const tabRef          = useRef(activeTab)
  const prevTabRef      = useRef(activeTab)
  const perchIndexRef   = useRef(0)
  const speechTimerRef  = useRef(null)
  const idleTimerRef    = useRef(null)
  const typingTimerRef  = useRef(null)
  const lastActivityRef = useRef(Date.now())
  const isTypingRef     = useRef(false)
  const topicRef        = useRef('')
  const charCountRef    = useRef(0)
  const speechKeyRef    = useRef(0)
  const observerRef     = useRef(null)   // ResizeObserver
  const visibleRef      = useRef(false)

  // ── speak ───────────────────────────────────────────────────────────────
  const speak = useCallback((text, newMood = 'idle') => {
    if (!text) return
    if (speechTimerRef.current) clearTimeout(speechTimerRef.current)
    speechKeyRef.current += 1
    setSpeech({ text: trimLine(text), key: speechKeyRef.current })
    setMood(newMood)
    speechTimerRef.current = setTimeout(() => { setSpeech(null); setMood('idle') }, 14000)
  }, [])

  const dismiss = useCallback(() => {
    if (speechTimerRef.current) clearTimeout(speechTimerRef.current)
    setSpeech(null); setMood('idle')
  }, [])

  useMizuListener(useCallback(({ line, mood: m }) => speak(line, m || 'idle'), [speak]))

  // ── reposition ──────────────────────────────────────────────────────────
  // This is the single source of truth for Mizu's position.
  // It is called by: ResizeObserver, scroll, resize, tab change.
  const reposition = useCallback(() => {
    if (!visibleRef.current) return
    const idx = bestPerchIndex(tabRef.current)
    perchIndexRef.current = idx
    const c = calcCoords(tabRef.current, idx)
    setCoords(c)
  }, [])

  // ── ResizeObserver: watch ALL perch elements for the current tab ─────────
  // This fires whenever a perch card appears, disappears, or changes size.
  // It is far more reliable than setTimeout-based polling.
  const setupObserver = useCallback(() => {
    if (observerRef.current) observerRef.current.disconnect()

    const perches = PERCH_MAP[tabRef.current]
    if (!perches) return

    const observer = new ResizeObserver(() => reposition())
    observerRef.current = observer

    // Observe existing elements immediately
    perches.forEach(p => {
      if (!p.id) return
      const el = document.querySelector(`[data-mizu-perch="${p.id}"]`)
      if (el) observer.observe(el)
    })

    // Also use MutationObserver to catch elements that render after mount
    const mutObs = new MutationObserver(() => {
      perches.forEach(p => {
        if (!p.id) return
        const el = document.querySelector(`[data-mizu-perch="${p.id}"]`)
        if (el && !el.__mizuObserved) {
          el.__mizuObserved = true
          observer.observe(el)
          reposition()
        }
      })
    })
    mutObs.observe(document.body, { childList: true, subtree: true })

    return () => { observer.disconnect(); mutObs.disconnect() }
  }, [reposition])

  // ── scroll + resize: always reposition ──────────────────────────────────
  useEffect(() => {
    const onScroll = () => reposition()
    const onResize = () => reposition()
    const scrollEl = document.querySelector('main') || window
    scrollEl.addEventListener('scroll', onScroll, { passive: true })
    window.addEventListener('resize', onResize)
    return () => {
      scrollEl.removeEventListener('scroll', onScroll)
      window.removeEventListener('resize', onResize)
    }
  }, [reposition])

  // ── tab change ───────────────────────────────────────────────────────────
  useEffect(() => {
    tabRef.current        = activeTab
    perchIndexRef.current = 0
    if (!visibleRef.current) return

    // Clear old observer, set up new one for this tab's elements
    const cleanup = setupObserver()

    // Immediate attempt, then retry after React renders the new tab's DOM
    reposition()
    const t1 = setTimeout(reposition, 100)
    const t2 = setTimeout(reposition, 400)

    if (activeTab !== prevTabRef.current) {
      prevTabRef.current = activeTab
      setTimeout(() => mizuReact('tab_switch', { tab: activeTab }), 500)
    }

    return () => { clearTimeout(t1); clearTimeout(t2); cleanup?.() }
  }, [activeTab, setupObserver, reposition])

  // ── idle detection ───────────────────────────────────────────────────────
  const scheduleIdleCheck = useCallback(() => {
    if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
    idleTimerRef.current = setTimeout(async () => {
      const idle = Date.now() - lastActivityRef.current
      const tab  = tabRef.current
      if (idle >= 30000) {
        await mizuReact('idle_long',  { tab, seconds: Math.round(idle / 1000) })
      } else if (idle >= 13000) {
        await mizuReact('idle_short', { tab, seconds: Math.round(idle / 1000) })
        scheduleIdleCheck()
      }
    }, 13000)
  }, [])

  // ── activity + typing ────────────────────────────────────────────────────
  useEffect(() => {
    const onActivity = () => {
      lastActivityRef.current = Date.now()
      if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
      scheduleIdleCheck()
    }
    const onKeydown = () => {
      lastActivityRef.current = Date.now()
      const t = document.getElementById('mizuTopicInput')
      const e = document.getElementById('mizuExplainInput')
      if (t) topicRef.current    = t.value
      if (e) charCountRef.current = e.value.length
      if (!isTypingRef.current) {
        isTypingRef.current = true
        if (typingTimerRef.current) clearTimeout(typingTimerRef.current)
        typingTimerRef.current = setTimeout(async () => {
          if (isTypingRef.current && tabRef.current === 'evaluate') {
            await mizuReact('typing_active', {
              topic: topicRef.current || 'the concept',
              charCount: charCountRef.current,
            })
          }
        }, 4000)
      }
    }
    const onKeyup = () => {
      if (typingTimerRef.current) clearTimeout(typingTimerRef.current)
      typingTimerRef.current = setTimeout(async () => {
        if (isTypingRef.current && charCountRef.current > 30) {
          isTypingRef.current = false
          if (tabRef.current === 'evaluate' && Math.random() < 0.45) {
            await mizuReact('typing_stopped', {
              topic: topicRef.current || 'the concept',
              charCount: charCountRef.current,
            })
          }
        }
      }, 5000)
    }
    window.addEventListener('mousemove', onActivity, { passive: true })
    window.addEventListener('click',     onActivity)
    window.addEventListener('keydown',   onKeydown)
    window.addEventListener('keyup',     onKeyup)
    return () => {
      window.removeEventListener('mousemove', onActivity)
      window.removeEventListener('click',     onActivity)
      window.removeEventListener('keydown',   onKeydown)
      window.removeEventListener('keyup',     onKeyup)
    }
  }, [scheduleIdleCheck])

  // ── mount ────────────────────────────────────────────────────────────────
  useEffect(() => {
    const t = setTimeout(() => {
      visibleRef.current = true
      setVisible(true)
      const cleanup = setupObserver()
      reposition()
      setTimeout(reposition, 300)
      mizuReact('tab_switch', { tab: tabRef.current })
      scheduleIdleCheck()
      return cleanup
    }, 1200)
    return () => {
      clearTimeout(t)
      observerRef.current?.disconnect()
      ;[speechTimerRef, idleTimerRef, typingTimerRef].forEach(r => {
        if (r.current) clearTimeout(r.current)
      })
    }
  }, [setupObserver, reposition, scheduleIdleCheck])

  if (!visible || !coords) return null

  return (
    <div style={{
      position:      'fixed',
      left:          coords.x,
      top:           coords.y,
      zIndex:        9999,
      pointerEvents: 'none',
      transition:    'top 0.45s cubic-bezier(0.4,0,0.2,1), left 0.45s cubic-bezier(0.4,0,0.2,1)',
    }}>
      {/* Speech bubble — opens upward and to the left */}
      {speech && (
        <div
          key={speech.key}
          onClick={dismiss}
          style={{
            position:      'absolute',
            bottom:        MIZU_H - 4,
            right:         MIZU_SIZE + 10,
            width:         154,
            borderRadius:  10,
            padding:       '7px 10px',
            fontSize:      12,
            fontWeight:    500,
            color:         '#f5f5f5',
            lineHeight:    1.45,
            background:    'linear-gradient(135deg, #1c0018, #0a000a)',
            border:        '1px solid rgba(255,45,120,0.35)',
            boxShadow:     '0 4px 20px rgba(255,45,120,0.2)',
            pointerEvents: 'auto',
            cursor:        'pointer',
            userSelect:    'none',
            whiteSpace:    'normal',
          }}
        >
          {speech.text}
          <div style={{ fontSize: 9, color: 'rgba(255,255,255,0.22)', marginTop: 4 }}>
            click to dismiss
          </div>
        </div>
      )}

      {/* Mizu */}
      <div
        onClick={dismiss}
        style={{ pointerEvents: 'auto', cursor: 'pointer', position: 'relative' }}
      >
        {/* Glow at the card border line — at 75% down his body */}
        <div style={{
          position:      'absolute',
          top:           Math.round(MIZU_H * 0.75),
          left:          '50%',
          transform:     'translateX(-50%)',
          width:         50,
          height:        5,
          background:    'radial-gradient(ellipse, rgba(209,58,151,0.55), transparent 70%)',
          filter:        'blur(4px)',
          pointerEvents: 'none',
        }} />
        <MizuCharacter mood={mood} size={MIZU_SIZE} />
      </div>
    </div>
  )
}
