import { useEffect, useRef, useState } from 'react'
import MizuCharacter from '../MizuCharacter'

// Lines Mizu says as each section scrolls into view.
// Mirrors the tone of the real reaction prompts in backend/routes/mizu.js.
const SECTION_LINES = {
  hero: 'Explain something. I dare you.',
  how: 'Three steps. Even you can follow that.',
  features: "Yes, I do all of this. You're welcome.",
  showcase: 'These are real screenshots. I checked.',
  mizu: 'Finally, a section about me.',
  philosophy: 'Deep thoughts. How unusual for you.',
  cta: 'Just make the account already.',
}

const CLICK_LINES = [
  "Rude. After everything I've done.",
  "So you don't love me.",
  'Wow. Fine. Whatever.',
  "I'm not crying. You are.",
]

export default function LandingMizu() {
  const [line, setLine] = useState('')
  const [show, setShow] = useState(false)
  const currentKey = useRef(null)
  const hideTimer = useRef(null)

  useEffect(() => {
    const sections = Array.from(document.querySelectorAll('[data-mizu-section]'))
    if (!sections.length) return

    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting && entry.intersectionRatio > 0.4) {
            const key = entry.target.dataset.mizuSection
            if (!key || key === currentKey.current) return
            currentKey.current = key
            say(SECTION_LINES[key])
          }
        })
      },
      { threshold: [0.4] }
    )
    sections.forEach((s) => io.observe(s))
    return () => io.disconnect()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  function say(text) {
    if (!text) return
    setLine(text)
    setShow(true)
    clearTimeout(hideTimer.current)
    hideTimer.current = setTimeout(() => setShow(false), 3800)
  }

  return (
    <div className="hidden sm:block">
      {/* speech bubble */}
      <div
        onClick={() => setShow(false)}
        className="fixed z-[200] right-[104px] bottom-[42px] max-w-[220px] cursor-pointer
                   bg-card border border-accent/35 rounded-xl px-4 py-3
                   font-mono text-xs text-white shadow-[0_14px_34px_rgba(0,0,0,0.55)]
                   transition-all duration-300"
        style={{
          opacity: show ? 1 : 0,
          transform: show ? 'translateY(0) scale(1)' : 'translateY(6px) scale(.97)',
          pointerEvents: show ? 'auto' : 'none',
        }}
      >
        {line}
        <span className="block mt-1.5 text-[10px] text-muted2">click to dismiss</span>
      </div>

      {/* floating character */}
      <button
        onClick={() => say(CLICK_LINES[Math.floor(Math.random() * CLICK_LINES.length)])}
        aria-label="Mizu"
        className="fixed z-[200] right-[26px] bottom-[26px] cursor-pointer animate-mizu-float"
      >
        <MizuCharacter mood="sarcastic" size={62} />
      </button>
    </div>
  )
}
