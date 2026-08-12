import { useEffect, useRef } from 'react'
import WebGLFluidEnhanced from 'webgl-fluid-enhanced'

// ── brand palette, ordered brightest edge-glow to deepest shadow ──
const BRAND_PALETTE = ['#EC4899', '#D6409F', '#B9267A', '#7A1440']

// ── full config, used on desktop / precise pointers ──
// Every dissipation and curl value below is chosen so the fluid feels
// light: it reacts fast and fades fast, instead of dragging a thick
// trail behind the cursor.
const FLUID_CONFIG = {
  simResolution: 128,        // velocity/pressure grid — 128 is the sweet spot, doubling this quadruples GPU cost for barely any visible gain
  dyeResolution: 1024,       // resolution the color itself is painted at — raised so big shapes stay crisp instead of blurry
  captureResolution: 512,
  densityDissipation: 4.2,   // raised again — splats need to clear fast so overlapping ones don't stack channels toward white
  velocityDissipation: 2,    // how fast motion energy fades — high value stops the fluid from "coasting" after you stop moving
  pressure: 0.15,            // low pressure keeps the fluid soft instead of pushing back hard on itself
  pressureIterations: 20,
  curl: 3,                   // vorticity strength — low curl gives smooth wisps, high curl gives busy swirling (that's the "heavy" feeling)
  splatRadius: 0.22,         // pulled back slightly from 0.28 — smaller footprint means less overlap between consecutive splats
  splatForce: 1,             // unused by manual splats below, kept for parity if you ever re-enable built-in hover
  shading: true,
  colorful: false,           // false because we are driving color from BRAND_PALETTE ourselves
  colorUpdateSpeed: 6,
  colorPalette: BRAND_PALETTE,
  hover: false,               // built-in listener is off — see the manual pointer handling below
  backgroundColor: '#000000',
  transparent: false,
  brightness: 0.4,           // pulled down from 0.7 — this is the ceiling each channel can reach, lower means overlapping splats sum toward a light pink instead of white
  bloom: true,
  bloomIterations: 8,
  bloomResolution: 256,
  bloomIntensity: 0.35,      // pulled down from 0.65 — bloom was the other big contributor to the white blowout
  bloomThreshold: 0.65,      // raised from 0.45 — only the genuinely brightest spots glow now, not every mid-tone splat
  bloomSoftKnee: 0.5,
  sunrays: true,
  sunraysResolution: 196,
  sunraysWeight: 0.4,
}

// ── reduced-cost config for touch devices and small screens ──
// bloom and sunrays are the two most expensive passes, they go first
const FLUID_CONFIG_LITE = {
  ...FLUID_CONFIG,
  simResolution: 96,
  dyeResolution: 512,
  bloom: false,
  sunrays: false,
}

// How strongly a pointer swipe pushes the fluid. This is applied by hand
// because splatAtLocation(), unlike the library's own drag handler, does
// not multiply by the splatForce config value for you.
const MANUAL_SPLAT_FORCE = 2600

// Below this many normalised units of movement per frame, a splat is
// skipped. Without this a motionless cursor (mouse jitter, trackpad
// noise) keeps injecting dye and the fluid never settles.
const JITTER_THRESHOLD = 2

export default function FluidHeroBackground() {
  const wrapperRef = useRef(null)
  const containerRef = useRef(null)
  const simRef = useRef(null)
  const runningRef = useRef(false)
  const rafRef = useRef(null)
  const lastPointRef = useRef(null)
  const pendingPointRef = useRef(null)

  useEffect(() => {
    const wrapper = wrapperRef.current
    const container = containerRef.current
    if (!wrapper || !container) return

    const prefersReducedMotion = window.matchMedia(
      '(prefers-reduced-motion: reduce)'
    ).matches
    if (prefersReducedMotion) return // respect the OS-level preference, render nothing

    const isLite =
      window.matchMedia('(pointer: coarse)').matches || window.innerWidth < 768

    let sim
    try {
      sim = new WebGLFluidEnhanced(container)
      sim.setConfig(isLite ? FLUID_CONFIG_LITE : FLUID_CONFIG)
      sim.start()
      sim.multipleSplats(2) // a couple of gentle splats on load so the hero isn't a flat black rectangle
    } catch (err) {
      // WebGL unsupported or blocked — fail silently, the section keeps its plain black background
      console.warn('FluidHeroBackground: WebGL fluid could not start', err)
      return
    }
    simRef.current = sim
    runningRef.current = true

    // ── manual pointer tracking, throttled to one splat per animation frame ──
    // Listening on every native "pointermove" and calling into WebGL each
    // time is what makes cursor-reactive backgrounds feel heavy: mousemove
    // can fire far more often than the screen repaints. Coalescing into
    // rAF guarantees at most one splat per rendered frame.
    const applyPendingSplat = () => {
      rafRef.current = null
      const point = pendingPointRef.current
      if (!point) return

      const rect = container.getBoundingClientRect()
      const x = point.x - rect.left
      const y = point.y - rect.top
      const inside = x >= 0 && y >= 0 && x <= rect.width && y <= rect.height

      const prev = lastPointRef.current
      lastPointRef.current = inside ? { x, y } : null
      if (!inside || !prev) return

      const aspect = rect.width / rect.height
      let dNormX = (x - prev.x) / rect.width
      let dNormY = -(y - prev.y) / rect.height // flipped: WebGL texture space is bottom-left origin
      if (aspect < 1) dNormX *= aspect
      if (aspect > 1) dNormY /= aspect

      const dx = dNormX * MANUAL_SPLAT_FORCE
      const dy = dNormY * MANUAL_SPLAT_FORCE
      if (Math.abs(dx) < JITTER_THRESHOLD && Math.abs(dy) < JITTER_THRESHOLD) return

      // splatAtLocation() normalises its x argument against canvas.width
      // (device pixels) but its y argument against canvas.clientHeight
      // (CSS pixels) — an inconsistency in the library itself. Scaling x
      // by devicePixelRatio here corrects it, otherwise every splat on a
      // retina screen lands squeezed into the left half of the canvas.
      //
      // The color argument is deliberately left undefined. Passing an
      // explicit hex string routes through the library's HEXtoRGB(), which
      // returns raw 0-255 channel values, and splatAtLocation() then
      // multiplies that by 10 — instantly clipping to white once bloom
      // amplifies it, which is the white wash you saw. Leaving it
      // undefined routes through generateColor() instead, which picks
      // from colorPalette and scales correctly against brightness.
      const dpr = window.devicePixelRatio || 1
      simRef.current?.splatAtLocation(x * dpr, y, dx, dy)
    }

    const onPointerMove = (event) => {
      pendingPointRef.current = { x: event.clientX, y: event.clientY }
      if (rafRef.current === null) {
        rafRef.current = requestAnimationFrame(applyPendingSplat)
      }
    }
    // Listens on window, not on the fluid's own div. The fluid div is a
    // z-0 sibling of the hero text/card content, which sits on top of it
    // at z-10. Pointer events go to whatever is topmost at that screen
    // position and only bubble through ITS ancestors — never sideways to
    // a sibling — so a listener on the fluid div itself would miss almost
    // every mouse move made over the actual hero content.
    window.addEventListener('pointermove', onPointerMove, { passive: true })

    // ── stop rendering when the hero is off-screen or the tab is hidden ──
    // The simulation keeps running its render loop even while paused, so
    // scrolling past the hero without this would still cost a GPU frame
    // every tick for no visible reason.
    const setRunning = (shouldRun) => {
      if (!simRef.current || shouldRun === runningRef.current) return
      shouldRun ? simRef.current.start() : simRef.current.stop()
      runningRef.current = shouldRun
    }

    const observer = new IntersectionObserver(
      ([entry]) => setRunning(entry.isIntersecting && !document.hidden),
      { threshold: 0.05 }
    )
    observer.observe(wrapper)

    const onVisibilityChange = () => {
      const rect = wrapper.getBoundingClientRect()
      const inViewport = rect.bottom > 0 && rect.top < window.innerHeight
      setRunning(!document.hidden && inViewport)
    }
    document.addEventListener('visibilitychange', onVisibilityChange)

    return () => {
      window.removeEventListener('pointermove', onPointerMove)
      document.removeEventListener('visibilitychange', onVisibilityChange)
      observer.disconnect()
      if (rafRef.current !== null) cancelAnimationFrame(rafRef.current)
      simRef.current?.stop()
      simRef.current = null
    }
  }, [])

  return (
    <div ref={wrapperRef} className="absolute inset-0 z-0 overflow-hidden bg-black">
      <div ref={containerRef} className="absolute inset-0 pointer-events-none" />
      {/* fades the pure-black fluid into the site's #191919 background at the seam */}
      <div
        className="absolute inset-x-0 bottom-0 h-40 pointer-events-none"
        style={{ background: 'linear-gradient(to bottom, transparent, #191919)' }}
      />
    </div>
  )
}
