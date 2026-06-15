import { useState, useEffect, useRef } from 'react'
import api from '../api/axios'
import MizuCharacter, { getMoodFromScore } from './MizuCharacter'

function renderMarkdown(text) {
  if (!text) return ''
  return text
    .replace(/```(\w+)?\n([\s\S]+?)```/gm, (_, lang, code) =>
      `<pre style="background:#0d0d0d;border:1px solid rgba(255,255,255,0.08);border-radius:10px;padding:14px;margin:8px 0;overflow-x:auto"><code style="font-family:'DM Mono',monospace;font-size:12px;color:#4ade80;white-space:pre">${code.replace(/</g,'&lt;').replace(/>/g,'&gt;')}</code></pre>`)
    .replace(/`([^`]+)`/g, '<code style="background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.1);border-radius:4px;padding:2px 6px;font-family:DM Mono,monospace;font-size:12px;color:#f9a8d4">$1</code>')
    .replace(/\*\*(.+?)\*\*/g, '<strong style="color:#fff;font-weight:600">$1</strong>')
    .replace(/\*(.+?)\*/g, '<em style="color:#f9a8d4">$1</em>')
    .replace(/^### (.+)$/gm, '<div style="font-size:14px;font-weight:600;color:#fff;margin:10px 0 4px">$1</div>')
    .replace(/^## (.+)$/gm,  '<div style="font-size:15px;font-weight:700;color:#fff;margin:12px 0 6px">$1</div>')
    .replace(/^\- (.+)$/gm,  '<div style="display:flex;gap:8px;margin:3px 0"><span style="color:#ff2d78;margin-top:2px">▸</span><span>$1</span></div>')
    .replace(/\n\n/g, '<br/>')
}

const SUGGESTIONS = [
  "Explain recursion with an example",
  "What's the difference between TCP and UDP?",
  "Help me understand Big O notation",
  "What is a closure in JavaScript?",
  "Explain gradient descent",
  "What are pointers in C++?",
  "How does React's useEffect work?",
  "What is a neural network?",
]

export default function Chatbot() {
  const [messages,  setMessages]  = useState([])
  const [input,     setInput]     = useState('')
  const [loading,   setLoading]   = useState(false)
  const [mood,      setMood]      = useState('idle')
  const [histLoad,  setHistLoad]  = useState(true)
  const bottomRef  = useRef(null)
  const inputRef   = useRef(null)

  useEffect(() => { loadHistory() }, [])
  useEffect(() => { bottomRef.current?.scrollIntoView({ behavior: 'smooth' }) }, [messages, loading])

  const loadHistory = async () => {
    try {
      const { data } = await api.get('/chat/history')
      if (data.history?.length) {
        setMessages(data.history.map(h => ({ role: h.role, content: h.message, ts: h.created_at })))
      }
    } catch {}
    finally { setHistLoad(false) }
  }

  const send = async () => {
    const msg = input.trim()
    if (!msg || loading) return

    const userMsg = { role: 'user', content: msg, ts: new Date().toISOString() }
    setMessages(prev => [...prev, userMsg])
    setInput('')
    setLoading(true)
    setMood('concerned')

    try {
      const history = messages.slice(-20)
      const { data } = await api.post('/chat', { message: msg, history })
      const aiMsg = { role: 'assistant', content: data.reply, ts: new Date().toISOString() }
      setMessages(prev => [...prev, aiMsg])
      // Pick mood based on response length/content
      if (data.reply.includes('impressed') || data.reply.includes('clean') || data.reply.includes('🔓')) {
        setMood('impressed')
      } else if (data.reply.includes('Brain') || data.reply.includes('SEE')) {
        setMood('encouraging')
      } else if (data.reply.includes('Bro') || data.reply.includes('serious')) {
        setMood('sarcastic')
      } else if (data.reply.includes('Hmm') || data.reply.includes('missing')) {
        setMood('judgy')
      } else {
        setMood('idle')
      }
    } catch (err) {
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: "Mizu crashed into a wall. Try again. 💀",
        ts: new Date().toISOString(), error: true
      }])
      setMood('chaos')
    } finally {
      setLoading(false)
      inputRef.current?.focus()
    }
  }

  const clearChat = async () => {
    try {
      await api.delete('/chat/history')
      setMessages([])
      setMood('idle')
    } catch {}
  }

  const useSuggestion = (s) => { setInput(s); inputRef.current?.focus() }

  if (histLoad) return (
    <div className="flex items-center justify-center h-64">
      <div className="w-6 h-6 border-2 border-accent/30 border-t-accent rounded-full animate-spin"/>
    </div>
  )

  return (
    <div className="flex gap-6 h-[calc(100vh-160px)]">
      {/* Left: Mizu panel */}
      <div className="w-56 shrink-0 flex flex-col gap-4">
        <div className="glass-card p-4 flex flex-col items-center gap-3">
          <MizuCharacter mood={mood} size={120} />
          <div className="text-center">
            <div className="text-xs font-mono text-pink-400 uppercase tracking-widest">Mizu</div>
            <div className="text-xs text-muted mt-1">AI Learning Companion</div>
          </div>
          <div className="w-full h-px" style={{ background: 'linear-gradient(to right, transparent, rgba(255,45,120,0.3), transparent)' }} />
          <div className="text-xs text-muted text-center leading-relaxed">
            {mood === 'idle' && "Ask me anything. I'm bored."}
            {mood === 'impressed' && "Okay now we're talking. 🔥"}
            {mood === 'encouraging' && "YES. Keep going! 🔓"}
            {mood === 'sarcastic' && "Really? That's your question?"}
            {mood === 'judgy' && "I see what's happening here."}
            {mood === 'concerned' && "Let me think about this…"}
            {mood === 'chaos' && "Okay this is fine. Everything is fine. 💀"}
          </div>
        </div>

        {/* Quick suggestions */}
        <div className="glass-card p-4">
          <div className="text-[10px] font-mono text-muted2 uppercase tracking-widest mb-3">Quick Ask</div>
          <div className="flex flex-col gap-1.5">
            {SUGGESTIONS.slice(0, 4).map(s => (
              <button key={s} onClick={() => useSuggestion(s)}
                className="text-left text-xs text-muted hover:text-white py-1.5 px-2 rounded-lg hover:bg-white/5 transition-all leading-snug">
                {s}
              </button>
            ))}
          </div>
        </div>

        {messages.length > 0 && (
          <button onClick={clearChat} className="text-xs text-muted hover:text-danger transition-colors text-center py-2">
            🗑 Clear history
          </button>
        )}
      </div>

      {/* Right: Chat area */}
      <div className="flex-1 flex flex-col glass-card overflow-hidden">
        {/* Header */}
        <div className="flex items-center justify-between px-5 py-4 border-b border-border shrink-0">
          <div>
            <h2 className="font-semibold text-white">Chat with Mizu</h2>
            <p className="text-xs text-muted">Session-based · responses powered by Groq</p>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-1.5 h-1.5 rounded-full bg-teal animate-pulse-dot"/>
            <span className="text-xs text-teal">Online</span>
          </div>
        </div>

        {/* Messages */}
        <div className="flex-1 overflow-y-auto px-5 py-4 space-y-4">
          {messages.length === 0 && (
            <div className="flex flex-col items-center justify-center h-full text-center">
              <div className="text-4xl mb-4">💬</div>
              <p className="text-muted font-medium">Start a conversation</p>
              <p className="text-muted2 text-sm mt-2 max-w-xs">Ask about any CS topic, get code help, or clarify your evaluation feedback</p>
              <div className="flex flex-wrap gap-2 mt-6 justify-center">
                {SUGGESTIONS.map(s => (
                  <button key={s} onClick={() => useSuggestion(s)}
                    className="text-xs px-3 py-1.5 rounded-full border border-border text-muted hover:text-white hover:border-accent/40 transition-all">
                    {s}
                  </button>
                ))}
              </div>
            </div>
          )}

          {messages.map((msg, i) => (
            <div key={i} className={`flex gap-3 ${msg.role === 'user' ? 'flex-row-reverse' : ''} animate-fadeup`}>
              {/* Avatar */}
              <div className="shrink-0 w-8 h-8 rounded-full flex items-center justify-center"
                style={msg.role === 'assistant'
                  ? { background: 'radial-gradient(#ff2d78 0%, #4a0025 100%)', border: '1px solid rgba(255,45,120,0.5)' }
                  : { background: 'linear-gradient(135deg,#d13a97,#8b2fc9)' }}>
                {msg.role === 'assistant' ? '💧' : '👤'}
              </div>
              {/* Bubble */}
              <div className={`max-w-[75%] rounded-2xl px-4 py-3 text-sm leading-relaxed ${
                msg.role === 'user'
                  ? 'text-white rounded-tr-sm'
                  : 'text-[#cccccc] rounded-tl-sm'
              } ${msg.error ? 'border border-danger/30' : ''}`}
                style={msg.role === 'user'
                  ? { background: 'linear-gradient(135deg,#d13a97,#8b2fc9)' }
                  : { background: '#1e1e1e', border: '1px solid #2e2e2e' }}>
                {msg.role === 'assistant' ? (
                  <div dangerouslySetInnerHTML={{ __html: renderMarkdown(msg.content) }} />
                ) : (
                  <span>{msg.content}</span>
                )}
                <div className="text-[10px] opacity-40 mt-1.5">
                  {new Date(msg.ts).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                </div>
              </div>
            </div>
          ))}

          {loading && (
            <div className="flex gap-3 animate-fadeup">
              <div className="shrink-0 w-8 h-8 rounded-full flex items-center justify-center"
                style={{ background: 'radial-gradient(#ff2d78 0%, #4a0025 100%)', border: '1px solid rgba(255,45,120,0.5)' }}>
                💧
              </div>
              <div className="rounded-2xl rounded-tl-sm px-4 py-3 flex items-center gap-1.5"
                style={{ background: '#1e1e1e', border: '1px solid #2e2e2e' }}>
                {[0,1,2].map(i => (
                  <div key={i} className="w-2 h-2 rounded-full animate-bounce"
                    style={{ background: '#ff2d78', animationDelay: `${i * 0.15}s` }} />
                ))}
              </div>
            </div>
          )}
          <div ref={bottomRef} />
        </div>

        {/* Input */}
        <div className="px-5 py-4 border-t border-border shrink-0">
          <div className="flex gap-3">
            <input
              ref={inputRef}
              value={input}
              onChange={e => setInput(e.target.value)}
              onKeyDown={e => e.key === 'Enter' && !e.shiftKey && send()}
              placeholder="Ask Mizu anything… (Enter to send)"
              className="form-input flex-1"
            />
            <button onClick={send} disabled={loading || !input.trim()}
              className="btn-primary px-5 shrink-0 disabled:opacity-50 disabled:cursor-not-allowed">
              {loading ? <span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin block"/> : '→'}
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}
