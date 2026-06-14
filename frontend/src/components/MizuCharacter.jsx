import { useEffect, useRef, useState } from 'react'

const MOODS = {
  idle: {
    body: "M140,52 C195,42 244,76 248,134 C252,188 220,238 178,258 C156,270 120,272 96,262 C52,242 30,190 34,136 C38,82 85,62 140,52Z",
    shim: "M140,64 C188,56 228,86 230,136 C232,180 204,222 170,240 C152,250 124,250 104,240 C68,224 52,182 56,136 C60,90 92,72 140,64Z",
    pupilLX:116, pupilLY:132, pupilRX:164, pupilRY:132,
    irisLX:116, irisLY:132, irisRX:164, irisRY:132,
    eyeWLRX:11, eyeWLRY:12, eyeWRRX:11, eyeWRRY:12,
    browL:"M105,112 Q116,108 126,112", browR:"M154,112 Q164,108 175,112",
    lids:0, lidL:"M105,126 Q116,120 127,126", lidR:"M153,126 Q164,120 175,126",
    mouth:"M122,170 Q140,184 158,170",
    blush:0, sweat:0, sparkles:0, tongue:0, splats:0, coreOpacity:0.85,
  },
  impressed: {
    body: "M140,44 C202,34 258,72 260,136 C262,196 226,250 180,268 C156,280 120,280 96,268 C48,248 24,192 28,136 C32,76 78,54 140,44Z",
    shim: "M140,56 C194,48 234,82 236,136 C238,186 208,228 172,246 C154,256 122,256 104,246 C66,228 48,186 52,136 C56,86 86,64 140,56Z",
    pupilLX:116, pupilLY:132, pupilRX:164, pupilRY:132,
    irisLX:116, irisLY:132, irisRX:164, irisRY:132,
    eyeWLRX:13, eyeWLRY:15, eyeWRRX:13, eyeWRRY:15,
    browL:"M103,106 Q116,100 129,106", browR:"M151,106 Q164,100 177,106",
    lids:0, lidL:"M105,126 Q116,120 127,126", lidR:"M153,126 Q164,120 175,126",
    mouth:"M114,172 Q140,196 166,172",
    blush:0.9, sweat:0, sparkles:0.9, tongue:0, splats:0, coreOpacity:1,
  },
  sarcastic: {
    body: "M140,58 C190,44 240,78 244,136 C248,190 218,240 174,260 C152,270 116,272 90,260 C46,240 32,186 38,134 C44,82 90,72 140,58Z",
    shim: "M140,70 C184,58 222,88 226,136 C230,182 204,228 168,246 C150,256 118,256 96,246 C60,228 46,184 52,136 C58,90 96,82 140,70Z",
    pupilLX:110, pupilLY:122, pupilRX:158, pupilRY:124,
    irisLX:111, irisLY:124, irisRX:159, irisRY:126,
    eyeWLRX:11, eyeWLRY:12, eyeWRRX:11, eyeWRRY:12,
    browL:"M105,118 Q116,124 127,120", browR:"M153,120 Q164,124 175,118",
    lids:1, lidL:"M103,124 Q116,116 129,124", lidR:"M151,124 Q164,116 177,124",
    mouth:"M122,168 Q132,164 145,168 Q138,175 128,175Z",
    blush:0, sweat:0, sparkles:0, tongue:0, splats:0, coreOpacity:0.65,
  },
  judgy: {
    body: "M140,56 C196,46 246,80 248,140 C250,196 218,244 176,262 C154,274 118,272 92,260 C48,238 36,184 44,134 C52,80 84,66 140,56Z",
    shim: "M140,68 C190,60 230,88 232,140 C234,186 206,228 172,246 C154,256 120,256 98,246 C62,228 50,182 58,134 C66,88 90,76 140,68Z",
    pupilLX:116, pupilLY:134, pupilRX:164, pupilRY:136,
    irisLX:116, irisLY:134, irisRX:164, irisRY:136,
    eyeWLRX:12, eyeWLRY:13, eyeWRRX:10, eyeWRRY:8,
    browL:"M103,104 Q116,96 129,104", browR:"M153,126 Q164,120 175,126",
    lids:1, lidL:"M105,130 Q116,138 127,130", lidR:"M151,132 Q164,126 177,132",
    mouth:"M124,170 Q132,168 140,172 Q148,176 158,170",
    blush:0, sweat:0, sparkles:0, tongue:0, splats:0, coreOpacity:0.7,
  },
  concerned: {
    body: "M140,54 C194,44 244,78 248,136 C252,190 220,240 176,260 C154,270 118,272 94,260 C50,240 30,188 34,136 C38,82 86,64 140,54Z",
    shim: "M140,66 C188,58 228,88 230,136 C232,180 206,222 170,240 C152,250 122,250 100,240 C64,222 50,180 54,136 C58,90 92,74 140,66Z",
    pupilLX:116, pupilLY:132, pupilRX:164, pupilRY:132,
    irisLX:116, irisLY:132, irisRX:164, irisRY:132,
    eyeWLRX:10, eyeWLRY:11, eyeWRRX:10, eyeWRRY:11,
    browL:"M106,114 Q116,118 126,114", browR:"M154,114 Q164,118 174,114",
    lids:0, lidL:"M105,126 Q116,120 127,126", lidR:"M153,126 Q164,120 175,126",
    mouth:"M122,172 Q140,166 158,172",
    blush:0, sweat:0.9, sparkles:0, tongue:0, splats:0, coreOpacity:0.72,
  },
  encouraging: {
    body: "M140,42 C205,30 262,70 264,138 C266,202 228,256 180,272 C156,284 120,284 96,272 C44,254 20,196 24,138 C28,74 75,54 140,42Z",
    shim: "M140,54 C196,44 238,80 240,138 C242,190 210,236 174,252 C156,262 120,262 100,252 C58,236 38,190 42,138 C46,84 84,64 140,54Z",
    pupilLX:116, pupilLY:130, pupilRX:164, pupilRY:130,
    irisLX:116, irisLY:130, irisRX:164, irisRY:130,
    eyeWLRX:14, eyeWLRY:16, eyeWRRX:14, eyeWRRY:16,
    browL:"M103,104 Q116,98 129,104", browR:"M151,104 Q164,98 177,104",
    lids:0, lidL:"M105,126 Q116,120 127,126", lidR:"M153,126 Q164,120 175,126",
    mouth:"M110,172 Q140,200 170,172",
    blush:1, sweat:0, sparkles:1, tongue:0, splats:0, coreOpacity:1,
  },
  chaos: {
    body: "M140,46 C202,28 258,68 262,136 C266,198 224,252 172,268 C140,280 100,278 72,262 C26,238 14,178 26,126 C40,68 78,64 140,46Z",
    shim: "M140,60 C196,44 246,80 248,136 C250,190 214,236 170,252 C142,262 106,260 82,248 C44,228 32,178 44,128 C58,76 84,76 140,60Z",
    pupilLX:108, pupilLY:128, pupilRX:168, pupilRY:136,
    irisLX:109, irisLY:130, irisRX:168, irisRY:136,
    eyeWLRX:15, eyeWLRY:17, eyeWRRX:12, eyeWRRY:13,
    browL:"M100,106 Q113,98 128,106", browR:"M154,108 Q167,102 178,110",
    lids:0, lidL:"M105,126 Q116,120 127,126", lidR:"M153,126 Q164,120 175,126",
    mouth:"M116,166 Q126,182 142,170 Q156,182 162,168",
    blush:0, sweat:0, sparkles:0, tongue:1, splats:1, coreOpacity:1,
  },
}

export function getMoodFromScore(score) {
  if (score >= 85) return 'impressed'
  if (score >= 70) return 'encouraging'
  if (score >= 50) return 'concerned'
  if (score >= 30) return 'judgy'
  return 'chaos'
}

// Eye base positions in SVG coordinate space (viewBox 0 0 280 320)
const EYE_L_BASE = { x: 116, y: 132 }
const EYE_R_BASE = { x: 164, y: 132 }
const EYE_MAX_TRAVEL = 4  // max pixels pupils can move in SVG units

export default function MizuCharacter({ mood = 'idle', size = 160 }) {
  const svgRef    = useRef(null)
  const wrapRef   = useRef(null)
  const phaseRef  = useRef(0)
  const bRef      = useRef(0)
  const rafRef    = useRef(null)
  const mouseRef  = useRef({ x: null, y: null })  // current mouse in page coords
  const [currentMood, setCurrentMood] = useState(mood)

  useEffect(() => { setCurrentMood(mood) }, [mood])

  // Apply mood attributes to SVG
  useEffect(() => {
    const svg = svgRef.current
    if (!svg) return
    const m = MOODS[currentMood] || MOODS.idle

    const set = (id, attr, val) => {
      const el = svg.getElementById(id)
      if (el) el.setAttribute(attr, val)
    }
    const setStyle = (id, prop, val) => {
      const el = svg.getElementById(id)
      if (el) el.style[prop] = val
    }

    set('bodyBlob', 'd', m.body)
    set('shimBlob', 'd', m.shim)
    setStyle('coreGlow', 'opacity', m.coreOpacity)

    // Store base pupil positions from mood (eye tracking will offset from these)
    set('eyeWhiteL', 'rx', m.eyeWLRX); set('eyeWhiteL', 'ry', m.eyeWLRY)
    set('eyeWhiteR', 'rx', m.eyeWRRX); set('eyeWhiteR', 'ry', m.eyeWRRY)

    set('browL', 'd', m.browL); set('browR', 'd', m.browR)
    setStyle('lids', 'opacity', m.lids)
    set('lidL', 'd', m.lidL); set('lidR', 'd', m.lidR)
    set('mouth', 'd', m.mouth)

    setStyle('blushL',    'opacity', m.blush)
    setStyle('blushR',    'opacity', m.blush)
    setStyle('sweat',     'opacity', m.sweat)
    setStyle('sparkles',  'opacity', m.sparkles)
    setStyle('tongue',    'opacity', m.tongue)
    setStyle('splatGroup','opacity', m.splats)
  }, [currentMood])

  // Global mouse tracking — listens on the window so it always works
  useEffect(() => {
    const onMove = (e) => {
      mouseRef.current = { x: e.clientX, y: e.clientY }
    }
    window.addEventListener('mousemove', onMove)
    return () => window.removeEventListener('mousemove', onMove)
  }, [])

  // Animation loop: float body + eye tracking
  useEffect(() => {
    const svg = svgRef.current
    if (!svg) return

    const bodyIds = ['bodyBlob','shimBlob','bodyGlow','coreGlow','eyes','brows','lids',
                     'mouth','drip1','drip2','drip3','fDrop1','fDrop2','fDrop3','fDrop4',
                     'blushL','blushR','sweat','sparkles','tongue','splatGroup','hlStreak']

    const tick = () => {
      phaseRef.current += 0.016
      bRef.current     += 0.007
      const fy = Math.sin(phaseRef.current) * 7
      const sx = 1 + Math.sin(bRef.current) * 0.025
      const sy = 1 + Math.sin(bRef.current * 0.8) * 0.018
      const sk = Math.sin(bRef.current * 1.4) * 1.5

      bodyIds.forEach(id => {
        const el = svg.getElementById(id)
        if (el) {
          el.style.transform = `translateY(${fy}px) scaleX(${sx}) scaleY(${sy}) skewX(${sk}deg)`
          el.style.transformOrigin = '140px 160px'
        }
      })

      // Random blink
      if (Math.random() < 0.0012) {
        const wL = svg.getElementById('eyeWhiteL')
        const wR = svg.getElementById('eyeWhiteR')
        if (wL && wR) {
          const ryL = wL.getAttribute('ry')
          const ryR = wR.getAttribute('ry')
          wL.setAttribute('ry', '1'); wR.setAttribute('ry', '1')
          setTimeout(() => { wL.setAttribute('ry', ryL); wR.setAttribute('ry', ryR) }, 90)
        }
      }

      // ── Eye tracking ──────────────────────────────────────────────────────
      const mouse = mouseRef.current
      if (mouse.x !== null && wrapRef.current) {
        // Get the SVG element's bounding rect in page space
        const rect = svg.getBoundingClientRect()

        // SVG viewBox is 0 0 280 320, rendered at rect.width x rect.height
        // Convert mouse page coords to SVG coordinate space
        const scaleX = 280 / rect.width
        const scaleY = 320 / rect.height
        const mouseInSvgX = (mouse.x - rect.left) * scaleX
        const mouseInSvgY = (mouse.y - rect.top)  * scaleY

        // Calculate direction vector from each eye base to the mouse in SVG space
        const computeOffset = (baseX, baseY) => {
          const dx = mouseInSvgX - baseX
          const dy = mouseInSvgY - baseY
          const dist = Math.sqrt(dx * dx + dy * dy)
          if (dist === 0) return { ox: 0, oy: 0 }
          // Clamp travel to EYE_MAX_TRAVEL
          const factor = Math.min(dist, 60) / 60  // 60 SVG units = "far enough"
          return {
            ox: (dx / dist) * EYE_MAX_TRAVEL * factor,
            oy: (dy / dist) * EYE_MAX_TRAVEL * factor,
          }
        }

        const { ox: lx, oy: ly } = computeOffset(EYE_L_BASE.x, EYE_L_BASE.y)
        const { ox: rx, oy: ry } = computeOffset(EYE_R_BASE.x, EYE_R_BASE.y)

        // Apply float offset so eyes move with the body float
        const floatOffsetY = fy * (320 / rect.height)  // convert px float to SVG units approx

        const setEyePos = (pupilId, irisId, shineId, bx, by, ox, oy) => {
          const pupil = svg.getElementById(pupilId)
          const iris  = svg.getElementById(irisId)
          const shine = svg.getElementById(shineId)
          if (pupil) { pupil.setAttribute('cx', bx + ox); pupil.setAttribute('cy', by + oy) }
          if (iris)  { iris.setAttribute('cx', bx + ox);  iris.setAttribute('cy', by + oy) }
          if (shine) { shine.setAttribute('cx', bx + ox + 3); shine.setAttribute('cy', by + oy - 3) }
        }

        setEyePos('eyePupilL', 'eyeIrisL', 'eyeShineL', EYE_L_BASE.x, EYE_L_BASE.y, lx, ly)
        setEyePos('eyePupilR', 'eyeIrisR', 'eyeShineR', EYE_R_BASE.x, EYE_R_BASE.y, rx, ry)
      }

      rafRef.current = requestAnimationFrame(tick)
    }
    rafRef.current = requestAnimationFrame(tick)
    return () => cancelAnimationFrame(rafRef.current)
  }, [])

  return (
    <div ref={wrapRef} style={{ width: size, height: size * (320/280), flexShrink: 0 }}>
      <svg
        ref={svgRef}
        id="mizuSvg"
        viewBox="0 0 280 320"
        xmlns="http://www.w3.org/2000/svg"
        style={{ width: '100%', height: '100%', overflow: 'visible' }}
      >
        <defs>
          <radialGradient id="bodyGrad" cx="45%" cy="38%" r="65%">
            <stop offset="0%" stopColor="#ff2d78" stopOpacity="0.55"/>
            <stop offset="45%" stopColor="#cc1060" stopOpacity="0.35"/>
            <stop offset="100%" stopColor="#4a0025" stopOpacity="0.2"/>
          </radialGradient>
          <radialGradient id="shimGrad" cx="40%" cy="35%" r="55%">
            <stop offset="0%" stopColor="#ff6eb0" stopOpacity="0.5"/>
            <stop offset="60%" stopColor="#ff2d78" stopOpacity="0.1"/>
            <stop offset="100%" stopColor="#ff2d78" stopOpacity="0"/>
          </radialGradient>
          <radialGradient id="coreGrad" cx="50%" cy="50%" r="50%">
            <stop offset="0%" stopColor="#ffffff" stopOpacity="1"/>
            <stop offset="35%" stopColor="#ff6eb0" stopOpacity="0.85"/>
            <stop offset="100%" stopColor="#ff2d78" stopOpacity="0"/>
          </radialGradient>
          <linearGradient id="hlGrad" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stopColor="#ffffff" stopOpacity="0.35"/>
            <stop offset="100%" stopColor="#ff6eb0" stopOpacity="0"/>
          </linearGradient>
          <filter id="glow" x="-40%" y="-40%" width="180%" height="180%">
            <feGaussianBlur stdDeviation="5" result="b"/>
            <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
          </filter>
          <filter id="bigGlow" x="-50%" y="-50%" width="200%" height="200%">
            <feGaussianBlur stdDeviation="10" result="b"/>
            <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
          </filter>
          <filter id="softBlur" x="-20%" y="-20%" width="140%" height="140%">
            <feGaussianBlur stdDeviation="3"/>
          </filter>
        </defs>

        <path id="bodyGlow"
          d="M140,48 C198,38 248,72 252,132 C256,188 224,240 180,260 C158,272 122,274 98,264 C52,244 28,192 32,136 C36,80 82,58 140,48Z"
          fill="none" stroke="rgba(255,45,120,0.4)" strokeWidth="1"
          filter="url(#bigGlow)" opacity="0.7"/>
        <path id="bodyBlob"
          d="M140,52 C195,42 244,76 248,134 C252,188 220,238 178,258 C156,270 120,272 96,262 C52,242 30,190 34,136 C38,82 85,62 140,52Z"
          fill="url(#bodyGrad)" stroke="rgba(255,45,120,0.7)" strokeWidth="1.5"/>
        <path id="shimBlob"
          d="M140,64 C188,56 228,86 230,136 C232,180 204,222 170,240 C152,250 124,250 104,240 C68,224 52,182 56,136 C60,90 92,72 140,64Z"
          fill="url(#shimGrad)" opacity="0.8"/>
        <path id="hlStreak"
          d="M94,80 Q110,64 138,62 Q120,72 106,90Z"
          fill="url(#hlGrad)" opacity="0.7"/>

        <path id="drip1" d="M100,258 Q96,282 98,295 Q100,304 103,295 Q106,280 100,258Z" fill="rgba(255,45,120,0.5)" stroke="rgba(255,45,120,0.6)" strokeWidth="0.8"/>
        <path id="drip2" d="M175,255 Q172,275 174,286 Q176,293 179,286 Q182,273 175,255Z" fill="rgba(255,45,120,0.4)" stroke="rgba(255,45,120,0.5)" strokeWidth="0.8"/>
        <path id="drip3" d="M140,268 Q137,286 139,296 Q141,302 143,296 Q145,284 140,268Z" fill="rgba(255,110,176,0.45)" stroke="rgba(255,110,176,0.5)" strokeWidth="0.7"/>

        <circle id="fDrop1" cx="60" cy="200" r="5" fill="rgba(255,45,120,0.6)"/>
        <circle id="fDrop2" cx="224" cy="190" r="4" fill="rgba(255,45,120,0.5)"/>
        <circle id="fDrop3" cx="52" cy="160" r="3" fill="rgba(255,110,176,0.55)"/>
        <circle id="fDrop4" cx="232" cy="155" r="2.5" fill="rgba(255,110,176,0.45)"/>

        <ellipse id="coreGlow" cx="140" cy="148" rx="44" ry="48" fill="url(#coreGrad)" filter="url(#glow)" opacity="0.85"/>

        <g id="brows">
          <path id="browL" d="M105,112 Q116,108 126,112" fill="none" stroke="rgba(255,110,176,0.9)" strokeWidth="3" strokeLinecap="round"/>
          <path id="browR" d="M154,112 Q164,108 175,112" fill="none" stroke="rgba(255,110,176,0.9)" strokeWidth="3" strokeLinecap="round"/>
        </g>
        <g id="eyes">
          <ellipse id="eyeBgL" cx="116" cy="132" rx="15" ry="16" fill="rgba(255,200,230,0.15)"/>
          <ellipse id="eyeWhiteL" cx="116" cy="132" rx="11" ry="12" fill="rgba(255,220,240,0.9)"/>
          <ellipse id="eyeIrisL" cx="116" cy="132" rx="6" ry="7" fill="#1a0010"/>
          <ellipse id="eyePupilL" cx="116" cy="132" rx="3.5" ry="4" fill="#ff2d78" filter="url(#glow)"/>
          <ellipse id="eyeShineL" cx="119" cy="129" rx="2.5" ry="2.5" fill="white" opacity="0.9"/>
          <ellipse id="eyeBgR" cx="164" cy="132" rx="15" ry="16" fill="rgba(255,200,230,0.15)"/>
          <ellipse id="eyeWhiteR" cx="164" cy="132" rx="11" ry="12" fill="rgba(255,220,240,0.9)"/>
          <ellipse id="eyeIrisR" cx="164" cy="132" rx="6" ry="7" fill="#1a0010"/>
          <ellipse id="eyePupilR" cx="164" cy="132" rx="3.5" ry="4" fill="#ff2d78" filter="url(#glow)"/>
          <ellipse id="eyeShineR" cx="167" cy="129" rx="2.5" ry="2.5" fill="white" opacity="0.9"/>
        </g>
        <g id="lids" opacity="0">
          <path id="lidL" d="M105,126 Q116,120 127,126" fill="#cc1060" opacity="0.9"/>
          <path id="lidR" d="M153,126 Q164,120 175,126" fill="#cc1060" opacity="0.9"/>
        </g>
        <path id="mouth" d="M122,170 Q140,184 158,170" fill="none" stroke="rgba(255,110,176,0.9)" strokeWidth="3" strokeLinecap="round"/>
        <path id="tongue" d="M134,174 Q140,185 146,174 Q143,190 137,190 Q131,190 134,174Z" fill="#ff2d78" opacity="0" filter="url(#glow)"/>

        <ellipse id="blushL" cx="95" cy="148" rx="16" ry="9" fill="rgba(255,45,120,0.25)" opacity="0" filter="url(#softBlur)"/>
        <ellipse id="blushR" cx="185" cy="148" rx="16" ry="9" fill="rgba(255,45,120,0.25)" opacity="0" filter="url(#softBlur)"/>
        <path id="sweat" d="M190,118 Q188,130 190,136 Q192,130 194,118 Q192,112 190,118Z" fill="rgba(180,200,255,0.7)" opacity="0"/>

        <g id="sparkles" opacity="0">
          <text x="44" y="130" fontSize="18" fill="#ff6eb0" filter="url(#glow)">✦</text>
          <text x="216" y="125" fontSize="14" fill="#ff2d78" filter="url(#glow)">✦</text>
          <text x="60" y="175" fontSize="10" fill="#ff6eb0">✦</text>
        </g>
        <g id="splatGroup" opacity="0">
          <circle cx="42" cy="140" r="6" fill="rgba(255,45,120,0.6)"/>
          <circle cx="240" cy="130" r="8" fill="rgba(255,45,120,0.5)"/>
          <circle cx="56" cy="105" r="4" fill="rgba(255,110,176,0.7)"/>
          <circle cx="228" cy="108" r="5" fill="rgba(255,110,176,0.6)"/>
        </g>
      </svg>
    </div>
  )
}
