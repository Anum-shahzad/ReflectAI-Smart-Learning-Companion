import { Link } from 'react-router-dom'

export default function Landing() {
  return (
    <div className="min-h-screen bg-bg relative overflow-x-hidden">

      {/* Glow orb */}
      <div className="absolute top-[-200px] left-1/2 -translate-x-1/2 w-[700px] h-[700px]
                      rounded-full pointer-events-none"
           style={{ background: 'radial-gradient(ellipse, rgba(209,58,151,0.16) 0%, transparent 65%)' }} />

      {/* NAV */}
      <nav className="sticky top-0 z-50 flex items-center justify-between px-12 py-5
                      border-b border-border bg-bg/80 backdrop-blur-xl">
        <div className="flex items-center gap-2.5">
          <div className="w-2 h-2 rounded-full bg-brand-grad animate-pulse-dot"
               style={{ background: 'linear-gradient(135deg,#d13a97,#8b2fc9)', boxShadow: '0 0 10px #d13a97' }} />
          <span className="font-serif text-xl font-semibold tracking-tight">ReflectAI</span>
        </div>
        <div className="flex items-center gap-8">
          <Link to="/login"    className="text-muted text-sm font-medium hover:text-white transition-colors">Sign in</Link>
          <Link to="/register" className="btn-primary text-sm">Get Started →</Link>
        </div>
      </nav>

      {/* HERO */}
      <section className="flex flex-col items-center justify-center text-center
                           px-6 pt-24 pb-32 relative">
        <div className="animate-fadeup inline-flex items-center gap-2 border border-accent/25
                        bg-accent/8 rounded-full px-4 py-1.5 text-xs text-accent
                        font-medium uppercase tracking-widest mb-8">
          <span>✦</span> AI-Powered Conceptual Mastery
        </div>

        <h1 className="animate-fadeup delay-100 font-serif text-5xl md:text-7xl font-semibold
                       leading-[1.08] tracking-tight mb-6 max-w-3xl">
          Don't just memorize.<br />
          <span style={{ background: 'linear-gradient(135deg,#d13a97,#8b2fc9)',
                         WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
            Truly understand.
          </span>
        </h1>

        <p className="animate-fadeup delay-200 text-muted text-lg leading-relaxed
                      max-w-[500px] mb-10 font-light">
          ReflectAI evaluates how well you can <em>explain</em> a concept — not whether
          you picked the right letter. Get AI feedback on accuracy, clarity, and depth.
        </p>

        <div className="animate-fadeup delay-300 flex gap-4 items-center">
          <Link to="/register" className="btn-primary px-8 py-3 text-base">Start learning free →</Link>
          <Link to="/login"    className="btn-ghost px-8 py-3 text-base">Sign in</Link>
        </div>

        {/* Preview card */}
        <div className="animate-fadeup delay-400 mt-20 w-full max-w-2xl glass-card
                        shadow-[0_40px_120px_rgba(0,0,0,0.6),0_0_60px_rgba(209,58,151,0.07)]">
          <div className="flex items-center gap-2 px-4 py-3 border-b border-border">
            <div className="w-2.5 h-2.5 rounded-full bg-[#ff5f5f]" />
            <div className="w-2.5 h-2.5 rounded-full bg-[#ffbe2e]" />
            <div className="w-2.5 h-2.5 rounded-full bg-[#2eca44]" />
            <span className="ml-2 text-xs text-muted2 font-mono">ReflectAI — Evaluation Results</span>
          </div>
          <div className="grid grid-cols-3 gap-3 p-6">
            {[
              { label: 'Accuracy', val: 87, color: '#d13a97', bar: 'bg-brand-grad' },
              { label: 'Clarity',  val: 91, color: '#00c896', bar: 'bg-teal' },
              { label: 'Depth',    val: 74, color: '#ffb020', bar: 'bg-warn' },
            ].map(s => (
              <div key={s.label} className="bg-white/[0.03] border border-border rounded-xl p-4 text-center">
                <div className="text-xs text-muted uppercase tracking-widest mb-2">{s.label}</div>
                <div className="font-serif text-3xl font-semibold" style={{ color: s.color }}>{s.val}</div>
                <div className="h-1 bg-border rounded-full mt-3 overflow-hidden">
                  <div className={`h-full rounded-full ${s.bar}`} style={{ width: `${s.val}%` }} />
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* STATS */}
      <div className="flex justify-center gap-16 py-10 border-t border-border">
        {[
          { n: '2,000+', l: 'Active Students' },
          { n: '50k+',   l: 'Evaluations Run' },
          { n: '94%',    l: 'Satisfaction Rate' },
        ].map(s => (
          <div key={s.l} className="text-center">
            <div className="font-serif text-2xl font-semibold"
                 style={{ background: 'linear-gradient(135deg,#d13a97,#8b2fc9)',
                          WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
              {s.n}
            </div>
            <div className="text-xs text-muted mt-1 font-medium">{s.l}</div>
          </div>
        ))}
      </div>
    </div>
  )
}
