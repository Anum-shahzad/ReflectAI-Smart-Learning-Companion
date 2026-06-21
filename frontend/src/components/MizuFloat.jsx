import { useState, useEffect, useRef, useCallback } from 'react'
import MizuCharacter from './MizuCharacter'
import { useMizuListener, mizuReact } from '../hooks/useMizu'

const MIZU_SIZE = 80

// ── Purposeful wander zones ───────────────────────────────────────────────────
// All zones are on the RIGHT side of the screen (x > 60%) so Mizu never
// overlaps the sidebar (which is ~240px / ~17% on a 1440px screen).
// Y values are chosen to look natural: just below nav, mid-screen, above bottom.
// Each zone has a descriptive name so you know why it's there.
const ZONES = [
  { x: 88, y: 78, name: 'bottom-right corner'     },  // home base
  { x: 88, y: 10, name: 'top-right corner'         },  // just below nav
  { x: 88, y: 44, name: 'right edge mid'           },  // right side center
  { x: 68, y: 78, name: 'bottom right of content'  },  // bottom, not too far right
  { x: 68, y: 10, name: 'top of content area'      },  // top, clear of nav
  { x: 76, y: 58, name: 'lower right content'      },  // natural reading area bottom
  { x: 76, y: 26, name: 'upper right content'      },  // natural reading area top
]

// Trim Mizu's speech to max ~12 words so it's always readable before dismiss
function trimLine(line) {
  if (!line) return line
  const words = line.trim().split(' ')
  if (words.length <= 14) return line
  return words.slice(0, 13).join(' ') + '…'
}

export default function MizuFloat({ activeTab = 'default' }) {
  const [visible,  setVisible]  = useState(false)
  const [pos,      setPos]      = useState({ x: 88, y: 78 })
  const [speech,   setSpeech]   = useState(null)   // stays until user clicks Mizu
  const [mood,     setMood]     = useState('idle')
  const [facing,   setFacing]   = useState(1)
  const [isMoving, setIsMoving] = useState(false)

  const posRef          = useRef({ x: 88, y: 78 })
  const activeTabRef    = useRef(activeTab)
  const prevTabRef      = useRef(activeTab)
  const speechTimerRef  = useRef(null)   // only used for auto-dismiss after very long wait
  const idleTimerRef    = useRef(null)
  const wanderTimerRef  = useRef(null)
  const typingTimerRef  = useRef(null)
  const lastActivityRef = useRef(Date.now())
  const isTypingRef     = useRef(false)
  const topicRef        = useRef('')
  const charCountRef    = useRef(0)
  const speechKeyRef    = useRef(0)
  const rafRef          = useRef(null)
  const movingRef       = useRef(false)

  // ── Speak: show bubble, stays until Mizu is clicked ──────────────────────
  const speak = useCallback((text, newMood = 'idle') => {
    if (!text) return
    const trimmed = trimLine(text)
    // Clear any previous auto-dismiss timer
    if (speechTimerRef.current) clearTimeout(speechTimerRef.current)
    speechKeyRef.current += 1
    setSpeech({ text: trimmed, key: speechKeyRef.current })
    if (newMood) setMood(newMood)
    // Fallback auto-dismiss after 18 seconds in case user never clicks
    speechTimerRef.current = setTimeout(() => {
      setSpeech(null)
      setMood('idle')
    }, 18000)
  }, [])

  const dismissSpeech = useCallback(() => {
    if (speechTimerRef.current) clearTimeout(speechTimerRef.current)
    setSpeech(null)
    setMood('idle')
  }, [])

  // ── Listen to mizuReact events from anywhere in the app ──────────────────
  useMizuListener(useCallback(({ line, mood: m }) => {
    speak(line, m || 'idle')
  }, [speak]))

  // ── Move to viewport % position ──────────────────────────────────────────
  const moveTo = useCallback((xPct, yPct) => {
    if (movingRef.current) return
    movingRef.current = true
    setIsMoving(true)

    const startX = posRef.current.x
    const startY = posRef.current.y
    setFacing(xPct > startX ? 1 : -1)

    const dx = xPct - startX
    const dy = yPct - startY
    const dist = Math.sqrt(dx * dx + dy * dy)
    const duration = Math.max(900, dist * 28)
    const startTime = performance.now()

    if (rafRef.current) cancelAnimationFrame(rafRef.current)

    const step = (now) => {
      const t = Math.min((now - startTime) / duration, 1)
      const e = t < 0.5 ? 4*t*t*t : 1 - Math.pow(-2*t+2, 3)/2
      const cx = startX + dx * e
      const cy = startY + dy * e
      posRef.current = { x: cx, y: cy }
      setPos({ x: cx, y: cy })
      if (t < 1) {
        rafRef.current = requestAnimationFrame(step)
      } else {
        posRef.current = { x: xPct, y: yPct }
        setPos({ x: xPct, y: yPct })
        setIsMoving(false)
        setFacing(1)
        movingRef.current = false
      }
    }
    rafRef.current = requestAnimationFrame(step)
  }, [])

  // ── Wander to a purposeful zone ───────────────────────────────────────────
  const wander = useCallback(() => {
    const cur = posRef.current
    // Pick a zone meaningfully different from current position
    const others = ZONES.filter(z =>
      Math.abs(z.x - cur.x) > 8 || Math.abs(z.y - cur.y) > 8
    )
    const zone = others[Math.floor(Math.random() * others.length)]
    moveTo(zone.x, zone.y)
  }, [moveTo])

  // ── Schedule recurring wander ─────────────────────────────────────────────
  const scheduleWander = useCallback(() => {
    if (wanderTimerRef.current) clearTimeout(wanderTimerRef.current)
    // Wander every 25-50 seconds — not too frequent, feels intentional
    const delay = 25000 + Math.random() * 25000
    wanderTimerRef.current = setTimeout(() => {
      wander()
      scheduleWander()
    }, delay)
  }, [wander])

  // ── Idle detection ────────────────────────────────────────────────────────
  const scheduleIdleCheck = useCallback(() => {
    if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
    idleTimerRef.current = setTimeout(async () => {
      const idle = Date.now() - lastActivityRef.current
      const tab  = activeTabRef.current
      if (idle >= 30000) {
        await mizuReact('idle_long',  { tab, seconds: Math.round(idle / 1000) })
        wander()
      } else if (idle >= 13000) {
        await mizuReact('idle_short', { tab, seconds: Math.round(idle / 1000) })
        scheduleIdleCheck()
      }
    }, 13000)
  }, [wander])

  // ── Tab change ────────────────────────────────────────────────────────────
  useEffect(() => {
    activeTabRef.current = activeTab
    if (!visible) return
    if (activeTab === prevTabRef.current) return
    prevTabRef.current = activeTab

    const t = setTimeout(async () => {
      await mizuReact('tab_switch', { tab: activeTab })
      if (Math.random() < 0.4) setTimeout(wander, 1400)
    }, 700)
    return () => clearTimeout(t)
  }, [activeTab, visible, wander])

  // ── Activity + typing tracking ────────────────────────────────────────────
  useEffect(() => {
    const onActivity = () => {
      lastActivityRef.current = Date.now()
      if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
      scheduleIdleCheck()
    }
    const onKeydown = () => {
      lastActivityRef.current = Date.now()
      const topicEl   = document.getElementById('mizuTopicInput')
      const explainEl = document.getElementById('mizuExplainInput')
      if (topicEl)   topicRef.current    = topicEl.value
      if (explainEl) charCountRef.current = explainEl.value.length

      if (!isTypingRef.current) {
        isTypingRef.current = true
        if (typingTimerRef.current) clearTimeout(typingTimerRef.current)
        typingTimerRef.current = setTimeout(async () => {
          if (isTypingRef.current && activeTabRef.current === 'evaluate') {
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
          if (activeTabRef.current === 'evaluate' && Math.random() < 0.45) {
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

  // ── Mount ─────────────────────────────────────────────────────────────────
  useEffect(() => {
    const t = setTimeout(() => {
      setVisible(true)
      setTimeout(async () => {
        await mizuReact('tab_switch', { tab: activeTabRef.current })
        scheduleWander()
        scheduleIdleCheck()
      }, 800)
    }, 1800)
    return () => {
      clearTimeout(t)
      ;[speechTimerRef, idleTimerRef, wanderTimerRef, typingTimerRef].forEach(r => {
        if (r.current) clearTimeout(r.current)
      })
      if (rafRef.current) cancelAnimationFrame(rafRef.current)
    }
  }, [scheduleWander, scheduleIdleCheck])

  if (!visible) return null

  const vw   = window.innerWidth
  const vh   = window.innerHeight
  const pxX  = Math.min((pos.x / 100) * vw, vw - MIZU_SIZE - 8)
  const pxY  = Math.min((pos.y / 100) * vh, vh - MIZU_SIZE * (320/280) - 8)
  const bubbleLeft = pos.x > 60   // bubble goes left when Mizu is in right half

  return (
    <div style={{
      position: 'fixed',
      left: pxX,
      top:  pxY,
      zIndex: 9999,
      display: 'flex',
      flexDirection: 'column',
      alignItems: bubbleLeft ? 'flex-end' : 'flex-start',
      gap: 8,
      pointerEvents: 'none',
    }}>

      {/* Speech bubble — stays until Mizu is clicked */}
      {speech && (
        <div
          key={speech.key}
          className="animate-fadeup"
          style={{
            maxWidth: 210,
            borderRadius: 14,
            padding: '9px 13px',
            fontSize: 12.5,
            color: '#f0f0f0',
            lineHeight: 1.5,
            background: 'linear-gradient(135deg, #1c0018, #0a000a)',
            border: '1px solid rgba(255,45,120,0.3)',
            boxShadow: '0 4px 24px rgba(255,45,120,0.18)',
            pointerEvents: 'none',
          }}
        >
          <div style={{
            fontSize: 9,
            fontFamily: 'DM Mono, monospace',
            color: '#ff6eb0',
            textTransform: 'uppercase',
            letterSpacing: '0.1em',
            marginBottom: 4,
          }}>
            Mizu
          </div>
          {speech.text}
          <div style={{ fontSize: 9, color: 'rgba(255,255,255,0.2)', marginTop: 5 }}>
            click mizu to dismiss
          </div>
        </div>
      )}

      {/* Mizu — click to dismiss speech */}
      <div
        style={{
          pointerEvents: 'auto',
          cursor: speech ? 'pointer' : 'default',
          transform: `scaleX(${facing})`,
          transformOrigin: 'center center',
          filter: isMoving ? 'brightness(1.2)' : 'none',
          transition: 'filter 0.3s',
          position: 'relative',
        }}
        onClick={dismissSpeech}
        title={speech ? 'Click to dismiss' : ''}
      >
        <div style={{
          position: 'absolute',
          bottom: 0,
          left: '50%',
          transform: 'translateX(-50%)',
          width: 52,
          height: 12,
          background: 'radial-gradient(ellipse, rgba(255,45,120,0.4), transparent 70%)',
          filter: 'blur(5px)',
          pointerEvents: 'none',
        }} />
        <MizuCharacter mood={mood} size={MIZU_SIZE} />
      </div>
    </div>
  )
}
