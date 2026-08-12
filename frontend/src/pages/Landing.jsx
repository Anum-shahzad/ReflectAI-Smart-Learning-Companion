import { useState } from 'react'
import { Link } from 'react-router-dom'

import Reveal from '../components/landing/Reveal'
import LandingMizu from '../components/landing/LandingMizu'
import MizuCharacter from '../components/MizuCharacter'
import FluidHeroBackground from '../components/landing/FluidHeroBackground'

// ── stack marquee icons (already shipped in src/assets/icons) ──
import iconPython from '../assets/icons/python.svg'
import iconJavascript from '../assets/icons/javascript.svg'
import iconHtml from '../assets/icons/html.svg'
import iconJava from '../assets/icons/java.svg'
import iconCplusplus from '../assets/icons/cplusplus.svg'
import iconTypescript from '../assets/icons/typescript.svg'
import iconRust from '../assets/icons/rust.svg'
import iconReact from '../assets/icons/react.svg'
import iconNodejs from '../assets/icons/nodejs.svg'
import iconSql from '../assets/icons/sql.svg'
import iconMysql from '../assets/icons/mysql.svg'
import iconDocker from '../assets/icons/docker.svg'
import iconGit from '../assets/icons/git.svg'
import iconTailwind from '../assets/icons/tailwindcss.svg'

// ── real product screenshots ──
import shotEvaluate from '../assets/landing/evaluate.png'
import shotAnalytics from '../assets/landing/analytics.png'
import shotLearn from '../assets/landing/learn_overview.png'
import shotLecture from '../assets/landing/html_lecture.png'
import shotNotes from '../assets/landing/notes.png'
import shotHistory from '../assets/landing/history.png'
import shotChat from '../assets/landing/settings_mizu.png'

const MARQUEE_ICONS = [
  { src: iconPython, alt: 'Python' },
  { src: iconJavascript, alt: 'JavaScript' },
  { src: iconHtml, alt: 'HTML' },
  { src: iconJava, alt: 'Java' },
  { src: iconCplusplus, alt: 'C++' },
  { src: iconTypescript, alt: 'TypeScript' },
  { src: iconRust, alt: 'Rust' },
  { src: iconReact, alt: 'React' },
  { src: iconNodejs, alt: 'Node.js' },
  { src: iconSql, alt: 'SQL' },
  { src: iconMysql, alt: 'MySQL' },
  { src: iconDocker, alt: 'Docker' },
  { src: iconGit, alt: 'Git' },
  { src: iconTailwind, alt: 'Tailwind CSS' },
]

const FEATURES = [
  {
    title: 'Evaluate a Concept',
    body: 'Explain any topic by voice or text. Get scored on accuracy, clarity, and conceptual depth — not keyword matching.',
    icon: <path d="M13 2 3 14h9l-1 8 10-12h-9l1-8z" />,
  },
  {
    title: 'Chat with Mizu',
    body: 'Your AI learning companion, running on Llama 3.3 70B. Ask about recursion, closures, Big O — get a real explanation, code included.',
    icon: <path d="M12 8v13M8 5a3 3 0 1 1 4 3 3 3 0 1 1 4-3" />,
  },
  {
    title: 'Structured Learning Paths',
    body: 'Python to Java to Rust — ordered lectures per language, each with progress tracking and a quiz at the end to prove it stuck.',
    icon: (
      <>
        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" />
        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
      </>
    ),
  },
  {
    title: 'Analytics',
    body: 'Accuracy, clarity, and depth trends over time — plus your best scores and most-evaluated topics, tracked automatically.',
    icon: <path d="M4 4v16h16M8 16v-4M13 16V8M18 16v-7" />,
  },
  {
    title: 'Notes Generator',
    body: 'Give Mizu a topic — get structured notes with explanations, code examples, and summaries. Save the ones worth keeping.',
    icon: (
      <>
        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
        <path d="M14 2v6h6M9 13h6M9 17h6M9 9h1" />
      </>
    ),
  },
  {
    title: 'Evaluation History',
    body: "Every explanation you've ever submitted, timestamped and scored — so you can see exactly where you've improved.",
    icon: (
      <>
        <circle cx="12" cy="12" r="9" />
        <path d="M12 7v5l3 3" />
      </>
    ),
  },
]

const SHOWCASE = [
  { key: 'evaluate', label: 'Evaluate', img: shotEvaluate, title: 'Evaluate a Concept', body: 'The three-step flow — type or speak your explanation, then let the AI score it.' },
  { key: 'analytics', label: 'Analytics', img: shotAnalytics, title: 'Analytics', body: 'Accuracy, clarity, and depth — averaged, trended, and broken down by topic.' },
  { key: 'learn', label: 'Learn', img: shotLearn, title: 'Learn', body: 'Every language and tool, grouped by category — click in and start from lecture one.' },
  { key: 'lecture', label: 'Lecture view', img: shotLecture, title: 'Inside a lecture', body: 'Real written lessons, not video links — with a synced sidebar so you never lose your place.' },
  { key: 'notes', label: 'Notes Generator', img: shotNotes, title: 'Notes Generator', body: 'Type a topic, hit generate — Mizu writes structured notes you can save for later.' },
  { key: 'history', label: 'History', img: shotHistory, title: 'Evaluation History', body: 'Every submission logged with its accuracy, clarity, and depth breakdown.' },
]

 function FeatureIcon({ children }) {

  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"
      strokeLinecap="round" strokeLinejoin="round" className="w-[19px] h-[19px] text-accent">
      {children}
    </svg>
  )
}

// ── Navbar size controls ─────────────────────────────────────────────────
// (The "Get Started" button uses inline styles here, not just Tailwind
// classes, because it shares .btn-primary with the rest of the site —
// classes added after btn-primary in the same string aren't guaranteed to
// win, since Tailwind orders by its compiled stylesheet, not JSX order.
// Inline styles always take priority over class-based CSS, so that's what
// reliably shrinks just this one instance without touching every other
// button on the site that also uses .btn-primary.)
const NAV_LOGO_FONT_SIZE   = 16   // px — "ReflectAI" text size in the top nav
const NAV_CTA_FONT_SIZE    = 12   // px — "Get Started" text size
const NAV_CTA_PADDING_X    = 13   // px — left/right padding inside the button
const NAV_CTA_PADDING_Y    = 5    // px — top/bottom padding inside the button

export default function Landing() {
  const [activeTab, setActiveTab] = useState(SHOWCASE[0].key)
  const active = SHOWCASE.find((s) => s.key === activeTab)

  return (
    <div className="min-h-screen bg-bg relative overflow-x-hidden">
      {/* background grid texture */}
      <div
        className="fixed inset-0 z-0 pointer-events-none opacity-50"
        style={{
          backgroundImage:
            'linear-gradient(rgba(255,255,255,0.025) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.025) 1px, transparent 1px)',
          backgroundSize: '64px 64px',
          WebkitMaskImage: 'radial-gradient(ellipse 70% 60% at 50% 0%, black 0%, transparent 75%)',
          maskImage: 'radial-gradient(ellipse 70% 60% at 50% 0%, black 0%, transparent 75%)',
        }}
      />

      {/* glow orb */}
      <div
        className="absolute top-[-200px] left-1/2 -translate-x-1/2 w-[700px] h-[700px] rounded-full pointer-events-none z-0"
        style={{ background: 'radial-gradient(ellipse, rgba(209,58,151,0.16) 0%, transparent 65%)' }}
      />

      {/* ═══ NAV ═══ */}
      <nav className="sticky top-0 z-50 flex items-center justify-between px-5 md:px-3 py-3
                       border-b border-border bg-bg/90 backdrop-blur-xl">
        <div className="flex items-center gap-2.5">
          <div className="w-2 h-2 rounded-full"
               style={{ background: 'linear-gradient(135deg,#d13a97,#8b2fc9)', boxShadow: '0 0 10px #d13a97' }} />
          <span className="font-serif font-semibold tracking-tight" style={{ fontSize: NAV_LOGO_FONT_SIZE }}>ReflectAI</span>
        </div>
        <ul className="hidden md:flex items-center gap-8 text-sm text-muted font-medium">
          <li><a href="#how" className="hover:text-white transition-colors">How it works</a></li>
          <li><a href="#features" className="hover:text-white transition-colors">Features</a></li>
           <li><a href="#showcase" className="hover:text-white transition-colors">Inside the app</a></li>
          <li><a href="#mizu" className="hover:text-white transition-colors">Meet Mizu</a></li>
        </ul>
        <div className="flex items-center gap-4">
          <Link to="/login" className="text-muted text-sm font-medium hover:text-white transition-colors">Sign in</Link>
          <Link
            to="/register"
            className="btn-primary"
            style={{
              fontSize: NAV_CTA_FONT_SIZE,
              paddingLeft: NAV_CTA_PADDING_X,
              paddingRight: NAV_CTA_PADDING_X,
              paddingTop: NAV_CTA_PADDING_Y,
              paddingBottom: NAV_CTA_PADDING_Y,
            }}
          >
            Get Started →
          </Link>
        </div>
      </nav>

      {/* ═══ HERO ═══ */}
      <section
        data-mizu-section="hero"
        className="relative z-10 overflow-hidden min-h-screen flex flex-col justify-end px-6 md:px-12 pb-28 pt-28"
      >
        <FluidHeroBackground />
        <div className="relative z-10 max-w-6xl w-full">
          <Reveal>
            <h1 className="font-serif font-semibold leading-[1.05] tracking-tight text-[clamp(2.6rem,6.2vw,5rem)] max-w-5xl">
              Explain it in your own words.{' '}
              <em className="not-italic" style={{ background: 'linear-gradient(135deg,#d13a97,#8b2fc9)',
                WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
                Find out
              </em>{' '}
              if you actually get it.
            </h1>
          </Reveal>
          <Reveal delay={0.08}>
            <div className="mt-8 flex flex-col sm:flex-row sm:items-end sm:justify-between gap-6">
              <p className="text-muted text-[1.02rem] leading-relaxed max-w-[4200px]">
                ReflectAI listens to how you explain a concept — typed or spoken — and scores your
                real understanding: accuracy, clarity, and depth. No multiple choice to hide behind.
              </p>
              <div className="flex flex-wrap gap-3.5 shrink-0">
                <Link to="/register" className="btn-primary px-6 py-3 text-sm">Start evaluating →</Link>
                <a href="#showcase" className="btn-ghost px-6 py-3 text-sm">See it in action</a>
              </div>
            </div>
          </Reveal>
        </div>
      </section>

      {/* ═══ MARQUEE ═══ */}
      <section className="relative z-10 py-12 border-t border-b border-border overflow-hidden">
        <Reveal as="p" className="text-center font-mono text-xs tracking-widest uppercase text-muted2 mb-7">
          Lecture tracks live today — more shipping every week
        </Reveal>
        <div className="flex w-max gap-16 items-center animate-marquee">
          {[...MARQUEE_ICONS, ...MARQUEE_ICONS].map((icon, i) => (
            <img key={i} src={icon.src} alt={icon.alt} className="h-[30px] w-auto opacity-75" style={{ filter: 'grayscale(15%)' }} />
          ))}
        </div>
      </section>

      {/* ═══ HOW IT WORKS ═══ */}
      <section id="how" data-mizu-section="how" className="relative z-10 px-6 md:px-12 py-28 max-w-6xl mx-auto">
        <Reveal className="max-w-xl mb-14">
          <span className="font-mono text-xs tracking-widest uppercase text-accent">
            <span className="text-muted2">/&gt;</span> the evaluate loop
          </span>
          <h2 className="font-serif font-semibold text-[clamp(1.7rem,3vw,2.4rem)] mt-3">
            Three steps. No hiding behind a definition you memorised.
          </h2>
          <p className="text-muted mt-4 leading-relaxed">
            This is the exact flow inside the Evaluate tab — the core of ReflectAI.
          </p>
        </Reveal>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-px bg-border rounded-2xl overflow-hidden border border-border">
          {[
            { n: 1, t: 'Enter topic', d: "Photosynthesis, Newton's Second Law, Binary Search — anything you're supposed to know cold." },
            { n: 2, t: 'Write explanation', d: "Type it or talk it out loud with the mic. Explain it the way you'd explain it to a classmate, not a textbook." },
            { n: 3, t: 'Get AI feedback', d: 'Scored on accuracy, clarity, and depth — with specific notes on what\'s missing, not just a number.' },
          ].map((s, i) => (
            <Reveal key={s.n} delay={i * 0.08} className="bg-bg p-9">
              <div className="w-[30px] h-[30px] rounded-full border border-accent/35 bg-accent/10 text-accent
                              font-mono text-xs flex items-center justify-center mb-5">
                {s.n}
              </div>
              <h3 className="text-lg font-semibold mb-2">{s.t}</h3>
              <p className="text-sm text-muted leading-relaxed">{s.d}</p>
            </Reveal>
          ))}
        </div>
      </section>

      {/* ═══ FEATURES ═══ */}
      <section id="features" data-mizu-section="features" className="relative z-10 px-6 md:px-12 py-24 max-w-6xl mx-auto">
        <Reveal className="max-w-xl mb-10">
          <span className="font-mono text-xs tracking-widest uppercase text-accent">
            <span className="text-muted2">/&gt;</span> everything inside
          </span>
          <h2 className="font-serif font-semibold text-[clamp(1.7rem,3vw,2.4rem)] mt-3">
            One dashboard. Every way you actually study.
          </h2>
        </Reveal>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {FEATURES.map((f, i) => (
            <Reveal key={f.title} delay={(i % 3) * 0.08}
              className="bg-card border border-border rounded-2xl p-7 hover:border-accent/35 hover:-translate-y-1 transition-all duration-300">
              <div className="w-[38px] h-[38px] rounded-[10px] bg-accent/10 border border-accent/35 flex items-center justify-center mb-5">
                <FeatureIcon>{f.icon}</FeatureIcon>
              </div>
              <h3 className="text-[1.05rem] font-semibold mb-2">{f.title}</h3>
              <p className="text-sm text-muted leading-relaxed">{f.body}</p>
            </Reveal>
          ))}
        </div>
      </section>

      {/* ═══ SHOWCASE ═══ */}
      <section id="showcase" data-mizu-section="showcase" className="relative z-10 px-6 md:px-12 py-24 max-w-6xl mx-auto">
        <Reveal className="max-w-xl mb-8">
          <span className="font-mono text-xs tracking-widest uppercase text-accent">
            <span className="text-muted2">/&gt;</span> real screens, not mockups
          </span>
          <h2 className="font-serif font-semibold text-[clamp(1.7rem,3vw,2.4rem)] mt-3">
            What you'll actually see the moment you log in.
          </h2>
        </Reveal>

        <Reveal className="flex flex-wrap gap-2 mb-8">
          {SHOWCASE.map((s) => (
            <button
              key={s.key}
              onClick={() => setActiveTab(s.key)}
              className={`font-mono text-xs px-4 py-2 rounded-lg border transition-all ${
                activeTab === s.key
                  ? 'bg-accent border-accent text-white'
                  : 'border-border text-muted hover:border-accent/35 hover:text-white'
              }`}
            >
              {s.label}
            </button>
          ))}
        </Reveal>

        <Reveal key={active.key}>
          <div className="glass-card">
            <div className="flex items-center gap-1.5 px-4 py-3 border-b border-border">
              <span className="w-2.5 h-2.5 rounded-full bg-border" />
              <span className="w-2.5 h-2.5 rounded-full bg-border" />
              <span className="w-2.5 h-2.5 rounded-full bg-border" />
            </div>
            <img src={active.img} alt={active.title} className="w-full block" />
          </div>
          <div className="mt-5">
            <h3 className="font-semibold text-[1.1rem]">{active.title}</h3>
            <p className="text-sm text-muted mt-1.5 max-w-lg">{active.body}</p>
          </div>
        </Reveal>
      </section>

       

      {/* ═══ MIZU ═══ */}
      <section id="mizu" data-mizu-section="mizu" className="relative z-10 px-6 md:px-12 py-24 max-w-6xl mx-auto">
        <div className="grid grid-cols-1 lg:grid-cols-[0.85fr_1.15fr] gap-14 items-center">
          <div>
            <Reveal>
              <span className="font-mono text-xs tracking-widest uppercase text-accent">
                <span className="text-muted2">/&gt;</span> not your average widget
              </span>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 className="font-serif font-semibold text-[clamp(1.7rem,3vw,2.4rem)] mt-3">
                Meet Mizu. He's watching. He has opinions.
              </h2>
            </Reveal>
            <Reveal delay={0.16}>
              <p className="text-muted mt-4 leading-relaxed">
                Mizu floats around the app reacting to what you're doing — bored when you're idle,
                unimpressed by low scores, occasionally kind. He also happens to write your notes
                and answer your questions. He's not just decoration.
              </p>
            </Reveal>
            <Reveal delay={0.24}>
              <div className="flex flex-col gap-3.5 mt-6">
                {['"Keep going."', '"Notes done. Actually read them."', '"So you don\'t love me."'].map((line) => (
                  <div key={line} className="bg-card border border-border rounded-lg px-4 py-3 font-mono text-sm max-w-[340px]">
                    <span className="block text-[10px] tracking-widest text-accent mb-1">MIZU</span>
                    {line}
                  </div>
                ))}
              </div>
            </Reveal>
          </div>
          <div>
            <Reveal delay={0.16} className="flex justify-center">
              <MizuCharacter mood="impressed" size={200} />
            </Reveal>
            <Reveal delay={0.24} className="mt-8">
              <div className="glass-card">
                <div className="flex items-center gap-1.5 px-4 py-3 border-b border-border">
                  <span className="w-2.5 h-2.5 rounded-full bg-border" />
                  <span className="w-2.5 h-2.5 rounded-full bg-border" />
                  <span className="w-2.5 h-2.5 rounded-full bg-border" />
                </div>
                <img src={shotChat} alt="Chat with Mizu, the AI learning companion" className="w-full block" />
              </div>
            </Reveal>
          </div>
        </div>
      </section>

      {/* ═══ PHILOSOPHY ═══ */}
      <section data-mizu-section="philosophy" className="relative z-10 px-6 py-24">
        <Reveal className="max-w-3xl mx-auto text-center">
          <blockquote className="font-serif font-medium leading-snug text-[clamp(1.4rem,2.6vw,2rem)]">
            You can memorise a definition in five minutes.{' '}
            <em className="not-italic text-accent">Understanding</em> it is the part that
            actually takes work — ReflectAI is built to tell the difference.
          </blockquote>
          <div className="font-mono text-sm text-muted2 mt-6">— why this exists</div>
        </Reveal>
      </section>

      {/* ═══ CTA ═══ */}
      <section data-mizu-section="cta" className="relative z-10 px-6 pb-32">
        <Reveal className="max-w-4xl mx-auto">
          <div className="glass-card text-center px-8 py-16 relative overflow-hidden">
            <div className="absolute inset-0 z-0"
              style={{ background: 'radial-gradient(ellipse 60% 70% at 50% 0%, rgba(209,58,151,0.14), transparent 70%)' }} />
            <div className="relative z-10">
              <h2 className="font-serif font-semibold text-[clamp(1.8rem,3.4vw,2.5rem)]">
                Stop reviewing. Start reflecting.
              </h2>
              <p className="text-muted mt-4 max-w-md mx-auto">
                Pick a topic you think you know. Explain it out loud. See what's actually in your head.
              </p>
              <div className="flex flex-wrap gap-3.5 justify-center mt-8">
                <Link to="/register" className="btn-primary px-7 py-3 text-sm">Create free account →</Link>
                <Link to="/login" className="btn-ghost px-7 py-3 text-sm">Sign in</Link>
              </div>
            </div>
          </div>
        </Reveal>
      </section>

      {/* ═══ FOOTER ═══ */}
      <footer className="relative z-10 border-t border-border px-6 md:px-12 py-10">
        <div className="max-w-6xl mx-auto flex flex-wrap items-center justify-between gap-4">
          <span className="font-serif text-base font-semibold">ReflectAI</span>
          <p className="font-mono text-xs text-muted2">Conceptual mastery, evaluated. Not memorisation, graded.</p>
        </div>
      </footer>

      <LandingMizu />
    </div>
  )
}
