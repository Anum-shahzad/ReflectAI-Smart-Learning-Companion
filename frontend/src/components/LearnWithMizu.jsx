import { useState } from 'react'
import MizuCharacter from './MizuCharacter'

const MIZU_LINES = {
  idle:        { text: "Hey. I'm Mizu. I'm your AI learning companion. Don't make it weird.", label: "Mizu says" },
  impressed:   { text: "Okay… that clarity? Clean. I'm actually impressed. Don't make it weird.", label: "When you nail it" },
  sarcastic:   { text: "Bro… are you SERIOUS right now? Did we even read the question? It's okay. Breathe. We fix it. 😐", label: "When you miss badly" },
  judgy:       { text: "Mmhmm. Really. That's your answer. Sure. Let me just… sit with that for a second. 👁️", label: "When you're kinda wrong" },
  concerned:   { text: "Hmm. We're missing some logic here. Let's tighten that up — together.", label: "When you're close" },
  encouraging: { text: "SEE?! THAT'S what I'm talking about. Brain absolutely unlocked. I knew you had it. 🔓🔥", label: "When you improve" },
  chaos:       { text: "That was… brave. Not correct. But BRAVE. Respect the chaos. Now let's actually try. 💀", label: "Complete chaos mode" },
}

const TRAITS = [
  { emoji: '💧', name: 'Liquid Form', desc: 'True blob body — morphs dramatically with every mood' },
  { emoji: '🧠', name: 'Genius Coder', desc: 'Deeply knowledgeable, hates sloppy logic' },
  { emoji: '🙄', name: 'Sarcastic', desc: 'Rolling eyes, dramatic sighs, iconic smirks' },
  { emoji: '🤨', name: 'Judgy', desc: 'One raised brow. Sees everything.' },
  { emoji: '⚡', name: 'Chaotic', desc: 'Unpredictable, explosive, always correct' },
  { emoji: '💗', name: 'Caring', desc: 'Goes hard for you when you put in the work' },
]

export default function LearnWithMizu({ onNavigate }) {
  const [mood, setMood] = useState('idle')
  const line = MIZU_LINES[mood]

  return (
    <div>
      <h1 className="font-serif text-2xl font-semibold mb-1">Learn with Mizu</h1>
      <p className="text-muted text-sm mb-8">Meet your AI learning companion — sarcastic, caring, and always right</p>

      {/* Main showcase */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
        {/* Left: Mizu + mood controls */}
        <div className="glass-card p-8 flex flex-col items-center gap-6">
          <div style={{
            position: 'relative',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
          }}>
            {/* Ambient glow */}
            <div style={{
              position: 'absolute', bottom: 0, left: '50%', transform: 'translateX(-50%)',
              width: 160, height: 40,
              background: 'radial-gradient(ellipse, rgba(255,45,120,0.5), transparent 70%)',
              filter: 'blur(10px)',
            }}/>
            <MizuCharacter mood={mood} size={200} />
          </div>

          {/* Mood selector */}
          <div className="flex flex-wrap gap-2 justify-center">
            {Object.keys(MIZU_LINES).map(m => (
              <button key={m} onClick={() => setMood(m)}
                className={`text-xs px-3 py-1.5 rounded-full border transition-all capitalize font-mono ${
                  mood === m
                    ? 'border-pink-500 text-white bg-pink-500/15'
                    : 'border-border text-muted hover:text-white hover:border-pink-500/40'
                }`}>
                {m}
              </button>
            ))}
          </div>
        </div>

        {/* Right: Dialogue + traits */}
        <div className="flex flex-col gap-4">
          {/* Dialogue bubble */}
          <div className="glass-card p-5 animate-fadeup" key={mood}
            style={{ borderLeft: '3px solid rgba(255,45,120,0.6)' }}>
            <div className="text-[10px] font-mono uppercase tracking-widest text-pink-400 mb-2">{line.label}</div>
            <p className="text-sm text-[#dddddd] leading-relaxed">{line.text}</p>
          </div>

          {/* Traits */}
          <div className="glass-card p-5">
            <div className="text-[10px] font-mono uppercase tracking-widest text-muted mb-4">Character Traits</div>
            <div className="grid grid-cols-2 gap-3">
              {TRAITS.map(t => (
                <div key={t.name} className="flex items-start gap-2.5">
                  <span className="text-lg shrink-0">{t.emoji}</span>
                  <div>
                    <div className="text-xs font-semibold text-white">{t.name}</div>
                    <div className="text-xs text-muted leading-snug mt-0.5">{t.desc}</div>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Where Mizu appears */}
          <div className="glass-card p-5">
            <div className="text-[10px] font-mono uppercase tracking-widest text-muted mb-3">Where Mizu lives</div>
            <div className="space-y-2">
              {[
                { icon: '⚡', label: 'Evaluate', desc: 'Reacts to your explanation quality' },
                { icon: '📝', label: 'Notes', desc: 'Hangs out while generating notes' },
                { icon: '📚', label: 'Lectures', desc: 'Appears during learning sessions' },
                { icon: '💬', label: 'Chatbot', desc: "That IS Mizu's AI brain talking" },
              ].map(item => (
                <div key={item.label} className="flex items-center gap-3">
                  <span className="w-7 h-7 rounded-lg flex items-center justify-center text-sm"
                    style={{ background: 'rgba(255,45,120,0.1)', border: '1px solid rgba(255,45,120,0.2)' }}>
                    {item.icon}
                  </span>
                  <div>
                    <span className="text-xs font-medium text-white">{item.label}</span>
                    <span className="text-xs text-muted ml-2">{item.desc}</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* CTA cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {[
          {
            icon: '💬', title: 'Chat with Mizu',
            desc: "Ask anything. Get roasted gently. Learn something.",
            action: 'chatbot', label: 'Open Chatbot',
          },
          {
            icon: '⚡', title: 'Get Evaluated',
            desc: "Explain a concept and watch Mizu judge your understanding.",
            action: 'evaluate', label: 'Start Evaluating',
          },
          {
            icon: '📚', title: 'Study a Path',
            desc: "Pick a programming language and follow the structured lectures.",
            action: 'paths', label: 'Browse Paths',
          },
        ].map(card => (
          <div key={card.title} className="glass-card p-6 hover:border-accent/30 transition-all group">
            <div className="text-3xl mb-3">{card.icon}</div>
            <h3 className="font-semibold text-white mb-2 group-hover:text-accent transition-colors">{card.title}</h3>
            <p className="text-sm text-muted mb-4 leading-relaxed">{card.desc}</p>
            <button onClick={() => onNavigate && onNavigate(card.action)} className="btn-primary text-sm px-4 py-2">
              {card.label}
            </button>
          </div>
        ))}
      </div>
    </div>
  )
}
