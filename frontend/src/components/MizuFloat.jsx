import { useState, useEffect, useRef, useCallback } from 'react'
import MizuCharacter from './MizuCharacter'
import { useMizuListener, mizuReact } from '../hooks/useMizu'

const MIZU_SIZE  = 64
const MIZU_H     = MIZU_SIZE * (320 / 280)

// Increase this number = Mizu moves further LEFT from the right edge
const RIGHT_INSET = 72

const PERCH_MAP = {
  evaluate:  [{ id: 'evaluate-main'        }],
  history:   [{ id: 'history-main'         }],
  notes:     [{ id: 'notes-main'           }],
  learn:     [{ id: 'learn-main'           }],
  // Settings: use the Profile card's top border for Y, but still fixed X on right wall
  settings:  [{ id: 'settings-profile-card' }],
  analytics: [
    { id: 'analytics-stats-row'  },
    { id: 'analytics-scoretrend' },
    { id: 'analytics-weekly'     },
  ],
}

function trimLine(line) {
  if (!line) return line
  const words = line.trim().split(' ')
  if (words.length <= 8) return line
  return words.slice(0, 7).join(' ') + '.'
}

export default function MizuFloat({ activeTab = 'default' }) {
  const [visible,  setVisible]  = useState(false)
  const [coords,   setCoords]   = useState(null)
  const [speech,   setSpeech]   = useState(null)
  const [mood,     setMood]     = useState('idle')

  const activeTabRef    = useRef(activeTab)
  const prevTabRef      = useRef(activeTab)
  const speechTimerRef  = useRef(null)
  const idleTimerRef    = useRef(null)
  const typingTimerRef  = useRef(null)
  const lastActivityRef = useRef(Date.now())
  const isTypingRef     = useRef(false)
  const topicRef        = useRef('')
  const charCountRef    = useRef(0)
  const speechKeyRef    = useRef(0)
  const perchIndexRef   = useRef(0)

  const speak = useCallback((text, newMood = 'idle') => {
    if (!text) return
    const trimmed = trimLine(text)
    if (speechTimerRef.current) clearTimeout(speechTimerRef.current)
    speechKeyRef.current += 1
    setSpeech({ text: trimmed, key: speechKeyRef.current })
    if (newMood) setMood(newMood)
    speechTimerRef.current = setTimeout(() => {
      setSpeech(null)
      setMood('idle')
    }, 14000)
  }, [])

  const dismissSpeech = useCallback(() => {
    if (speechTimerRef.current) clearTimeout(speechTimerRef.current)
    setSpeech(null)
    setMood('idle')
  }, [])

  useMizuListener(useCallback(({ line, mood: m }) => {
    speak(line, m || 'idle')
  }, [speak]))

  const updatePosition = useCallback(() => {
    const tab = activeTabRef.current
    const vw  = window.innerWidth

    // X: always fixed from the right — never clips, never varies per page
    const x = vw - MIZU_SIZE - RIGHT_INSET

    const perches = PERCH_MAP[tab]
    if (!perches) { setCoords({ x, y: 200 }); return }

    const perch = perches[perchIndexRef.current] || perches[0]
    if (!perch)  { setCoords({ x, y: 200 }); return }

    const el = document.querySelector(`[data-mizu-perch="${perch.id}"]`)
    if (!el)     { setCoords({ x, y: 200 }); return }

    const rect = el.getBoundingClientRect()

    if (rect.bottom < 0 || rect.top > window.innerHeight) {
      setCoords(null)
      return
    }

    // Y: feet at the top border line
    // rect.top - MIZU_H * 0.75 means:
    //   top 75% of Mizu body is ABOVE the line (sitting)
    //   bottom 25% hangs BELOW the line (legs dangling)
    const y = rect.top - MIZU_H * 0.75

    setCoords({ x, y })
  }, [])

  useEffect(() => {
    const onScroll = () => {
      const perches = PERCH_MAP[activeTabRef.current]
      if (perches && perches.length > 1) {
        let bestIdx  = 0
        let bestDist = Infinity
        perches.forEach((p, i) => {
          const el = document.querySelector(`[data-mizu-perch="${p.id}"]`)
          if (!el) return
          const rect   = el.getBoundingClientRect()
          const dist   = Math.abs((rect.top + rect.height / 2) - window.innerHeight / 2)
          if (rect.bottom > 0 && rect.top < window.innerHeight && dist < bestDist) {
            bestDist = dist
            bestIdx  = i
          }
        })
        if (bestIdx !== perchIndexRef.current) {
          perchIndexRef.current = bestIdx
        }
      }
      updatePosition()
    }
    const scrollEl = document.querySelector('main') || window
    scrollEl.addEventListener('scroll', onScroll, { passive: true })
    window.addEventListener('resize', onScroll)
    return () => {
      scrollEl.removeEventListener('scroll', onScroll)
      window.removeEventListener('resize', onScroll)
    }
  }, [updatePosition])

  useEffect(() => {
    activeTabRef.current  = activeTab
    perchIndexRef.current = 0
    if (!visible) return
    const t = setTimeout(() => {
      updatePosition()
      if (activeTab !== prevTabRef.current) {
        prevTabRef.current = activeTab
        mizuReact('tab_switch', { tab: activeTab })
      }
    }, 350)
    return () => clearTimeout(t)
  }, [activeTab, visible, updatePosition])

  const scheduleIdleCheck = useCallback(() => {
    if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
    idleTimerRef.current = setTimeout(async () => {
      const idle = Date.now() - lastActivityRef.current
      const tab  = activeTabRef.current
      if (idle >= 30000) {
        await mizuReact('idle_long',  { tab, seconds: Math.round(idle / 1000) })
      } else if (idle >= 13000) {
        await mizuReact('idle_short', { tab, seconds: Math.round(idle / 1000) })
        scheduleIdleCheck()
      }
    }, 13000)
  }, [])

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
      if (topicEl)   topicRef.current     = topicEl.value
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

  useEffect(() => {
    const t = setTimeout(() => {
      setVisible(true)
      setTimeout(() => {
        updatePosition()
        mizuReact('tab_switch', { tab: activeTabRef.current })
        scheduleIdleCheck()
      }, 500)
    }, 1200)
    return () => {
      clearTimeout(t)
      ;[speechTimerRef, idleTimerRef, typingTimerRef].forEach(r => {
        if (r.current) clearTimeout(r.current)
      })
    }
  }, [updatePosition, scheduleIdleCheck])

  if (!visible || !coords) return null

  return (
    <div style={{
      position:      'fixed',
      left:          coords.x,
      top:           coords.y,
      zIndex:        9999,
      pointerEvents: 'none',
      transition:    'top 0.4s cubic-bezier(0.4,0,0.2,1)',
    }}>
      {speech && (
        <div
          key={speech.key}
          onClick={dismissSpeech}
          style={{
            position:      'absolute',
            bottom:        MIZU_H - 8,
            right:         MIZU_SIZE + 8,
            width:         158,
            borderRadius:  10,
            padding:       '7px 10px',
            fontSize:      12,
            fontWeight:    500,
            color:         '#f5f5f5',
            lineHeight:    1.4,
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
          <div style={{ fontSize: 9, color: 'rgba(255,255,255,0.25)', marginTop: 4 }}>
            click to dismiss
          </div>
        </div>
      )}
      <div
        style={{ pointerEvents: 'auto', cursor: 'pointer', position: 'relative' }}
        onClick={dismissSpeech}
      >
        <div style={{
          position:      'absolute',
          top:           MIZU_H * 0.75,
          left:          '50%',
          transform:     'translateX(-50%)',
          width:         52,
          height:        5,
          background:    'radial-gradient(ellipse, rgba(209,58,151,0.6), transparent 70%)',
          filter:        'blur(4px)',
          pointerEvents: 'none',
        }} />
        <MizuCharacter mood={mood} size={MIZU_SIZE} />
      </div>
    </div>
  )
}
