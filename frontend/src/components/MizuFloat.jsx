import { useState, useEffect, useRef, useCallback } from 'react'
import MizuCharacter from './MizuCharacter'
import { useMizuListener, mizuReact } from '../hooks/useMizu'

const MIZU_SIZE = 80

const ZONES = [
  { x: 88, y: 82 },
  { x:  4, y: 82 },
  { x:  4, y:  4 },
  { x: 88, y:  4 },
  { x: 44, y: 82 },
  { x:  4, y: 44 },
  { x: 88, y: 44 },
]

export default function MizuFloat({ activeTab = 'default' }) {
  const [visible,  setVisible]  = useState(false)
  const [pos,      setPos]      = useState({ x: 88, y: 82 })
  const [speech,   setSpeech]   = useState(null)
  const [mood,     setMood]     = useState('idle')
  const [facing,   setFacing]   = useState(1)
  const [isMoving, setIsMoving] = useState(false)

  const posRef          = useRef({ x: 88, y: 82 })
  const activeTabRef    = useRef(activeTab)
  const prevTabRef      = useRef(activeTab)
  const speechTimerRef  = useRef(null)
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

  // ── Display a line from Mizu ───────────────────────────────────────────
  const speak = useCallback((text, newMood = 'idle', durationMs = 5500) => {
    if (speechTimerRef.current) clearTimeout(speechTimerRef.current)
    speechKeyRef.current += 1
    setSpeech({ text, key: speechKeyRef.current })
    setMood(newMood)
    speechTimerRef.current = setTimeout(() => {
      setSpeech(null)
      setMood('idle')
    }, durationMs)
  }, [])

  // ── Listen to mizuReact events from anywhere in the app ───────────────
  useMizuListener(useCallback(({ line, mood: m }) => {
    speak(line, m || 'idle')
  }, [speak]))

  // ── Move to viewport % position with rAF easing ───────────────────────
  const moveTo = useCallback((xPct, yPct, onArrival = null) => {
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
      const e = t < 0.5 ? 4*t*t*t : 1 - Math.pow(-2*t+2,3)/2
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
        if (onArrival) onArrival()
      }
    }
    rafRef.current = requestAnimationFrame(step)
  }, [])

  // ── Wander to a random zone ────────────────────────────────────────────
  const wander = useCallback(() => {
    const cur = posRef.current
    const others = ZONES.filter(z =>
      Math.abs(z.x - cur.x) > 10 || Math.abs(z.y - cur.y) > 10
    )
    const zone = others[Math.floor(Math.random() * others.length)]
    moveTo(zone.x, zone.y)
  }, [moveTo])

  // ── Schedule recurring wander ──────────────────────────────────────────
  const scheduleWander = useCallback(() => {
    if (wanderTimerRef.current) clearTimeout(wanderTimerRef.current)
    const delay = 22000 + Math.random() * 28000
    wanderTimerRef.current = setTimeout(() => {
      wander()
      scheduleWander()
    }, delay)
  }, [wander])

  // ── Idle detection — fires API call, not a preset string ──────────────
  const scheduleIdleCheck = useCallback(() => {
    if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
    idleTimerRef.current = setTimeout(async () => {
      const idle = Date.now() - lastActivityRef.current
      const tab  = activeTabRef.current
      if (idle >= 30000) {
        await mizuReact('idle_long',  { tab, seconds: Math.round(idle/1000) })
        wander()
      } else if (idle >= 13000) {
        await mizuReact('idle_short', { tab, seconds: Math.round(idle/1000) })
        scheduleIdleCheck()
      }
    }, 13000)
  }, [wander])

  // ── Tab change — fires API call ────────────────────────────────────────
  useEffect(() => {
    activeTabRef.current = activeTab
    if (!visible) return
    if (activeTab === prevTabRef.current) return
    prevTabRef.current = activeTab

    // Slight delay so user is settled in the new tab
    const t = setTimeout(async () => {
      await mizuReact('tab_switch', { tab: activeTab })
      if (Math.random() < 0.35) setTimeout(wander, 1200)
    }, 700)
    return () => clearTimeout(t)
  }, [activeTab, visible, wander])

  // ── Track activity + typing ────────────────────────────────────────────
  useEffect(() => {
    const onActivity = () => {
      lastActivityRef.current = Date.now()
      if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
      scheduleIdleCheck()
    }

    const onKeydown = (e) => {
      lastActivityRef.current = Date.now()
      // Try to read topic input value — it has id "topicInput" in Evaluate.jsx
      const topicEl = document.getElementById('mizuTopicInput')
      if (topicEl) topicRef.current = topicEl.value

      const explainEl = document.getElementById('mizuExplainInput')
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
    window.addEventListener('click', onActivity)
    window.addEventListener('keydown', onKeydown)
    window.addEventListener('keyup', onKeyup)
    return () => {
      window.removeEventListener('mousemove', onActivity)
      window.removeEventListener('click', onActivity)
      window.removeEventListener('keydown', onKeydown)
      window.removeEventListener('keyup', onKeyup)
    }
  }, [scheduleIdleCheck])

  // ── Mount ──────────────────────────────────────────────────────────────
  useEffect(() => {
    const t = setTimeout(() => {
      setVisible(true)
      // First greeting is also AI-generated
      setTimeout(async () => {
        await mizuReact('tab_switch', { tab: activeTabRef.current })
        scheduleWander()
        scheduleIdleCheck()
      }, 600)
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

  const vw = window.innerWidth
  const vh = window.innerHeight
  const pxX = Math.min((pos.x / 100) * vw, vw - MIZU_SIZE - 8)
  const pxY = Math.min((pos.y / 100) * vh, vh - MIZU_SIZE * (320/280) - 8)
  const bubbleLeft = pos.x > 50

  return (
    <div style={{
      position: 'fixed',
      left: pxX,
      top: pxY,
      zIndex: 9999,
      display: 'flex',
      flexDirection: 'column',
      alignItems: bubbleLeft ? 'flex-end' : 'flex-start',
      gap: 8,
      pointerEvents: 'none',
    }}>

      {/* Speech bubble */}
      {speech && (
        <div
          key={speech.key}
          className="animate-fadeup"
          style={{
            maxWidth: 230,
            borderRadius: 16,
            padding: '10px 14px',
            fontSize: 13,
            color: '#f0f0f0',
            lineHeight: 1.55,
            background: 'linear-gradient(135deg, #1c0018, #0a000a)',
            border: '1px solid rgba(255,45,120,0.3)',
            boxShadow: '0 4px 28px rgba(255,45,120,0.2)',
            pointerEvents: 'auto',
            userSelect: 'none',
          }}
        >
          <div style={{
            fontSize: 9, fontFamily: 'DM Mono, monospace',
            color: '#ff6eb0', textTransform: 'uppercase',
            letterSpacing: '0.1em', marginBottom: 5,
          }}>
            Mizu
          </div>
          {speech.text}
        </div>
      )}

      {/* Mizu body */}
      <div
        style={{
          pointerEvents: 'auto',
          cursor: 'default',
          transform: `scaleX(${facing})`,
          transformOrigin: 'center center',
          filter: isMoving ? 'brightness(1.2)' : 'none',
          transition: 'filter 0.3s',
          position: 'relative',
        }}
      >
        <div style={{
          position: 'absolute',
          bottom: 0, left: '50%',
          transform: 'translateX(-50%)',
          width: 56, height: 14,
          background: 'radial-gradient(ellipse, rgba(255,45,120,0.45), transparent 70%)',
          filter: 'blur(5px)',
          pointerEvents: 'none',
        }} />
        <MizuCharacter mood={mood} size={MIZU_SIZE} />
      </div>
    </div>
  )
}
