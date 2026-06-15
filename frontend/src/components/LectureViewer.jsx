import { useState, useEffect } from 'react'
import api from '../api/axios'

// ── Markdown renderer (preserved from original) ─────────────────────────────
function renderMarkdown(text) {
  if (!text) return ''
  return text
    .replace(/```(\w+)?\n([\s\S]+?)```/gm, (_, lang, code) =>
      `<pre style="background:#0a0a0f;border:1px solid rgba(255,45,120,0.15);border-radius:12px;padding:18px;margin:14px 0;overflow-x:auto">
        <div style="font-family:DM Mono,monospace;font-size:11px;color:rgba(255,45,120,0.6);margin-bottom:8px;text-transform:uppercase;letter-spacing:.1em">${lang || 'code'}</div>
        <code style="font-family:'DM Mono',monospace;font-size:13px;color:#4ade80;white-space:pre;display:block;line-height:1.7">${code.replace(/</g,'&lt;').replace(/>/g,'&gt;')}</code></pre>`)
    .replace(/^### (.+)$/gm, '<h3 style="font-size:15px;font-weight:600;color:#fff;margin:18px 0 8px">$1</h3>')
    .replace(/^## (.+)$/gm,  '<h2 style="font-size:17px;font-weight:700;color:#fff;margin:24px 0 10px;padding-bottom:8px;border-bottom:1px solid #2e2e2e">$1</h2>')
    .replace(/^# (.+)$/gm,   '<h1 style="font-size:22px;font-weight:800;color:#fff;margin:0 0 16px;background:linear-gradient(135deg,#d13a97,#8b2fc9);-webkit-background-clip:text;-webkit-text-fill-color:transparent">$1</h1>')
    .replace(/\*\*(.+?)\*\*/g, '<strong style="color:#fff;font-weight:600">$1</strong>')
    .replace(/`([^`]+)`/g,    '<code style="background:rgba(255,45,120,0.08);border:1px solid rgba(255,45,120,0.2);border-radius:5px;padding:2px 7px;font-family:DM Mono,monospace;font-size:12px;color:#ff6eb0">$1</code>')
    .replace(/^\- (.+)$/gm,   '<div style="display:flex;gap:10px;margin:5px 0;color:#aaa;font-size:14px"><span style="color:#ff2d78;flex-shrink:0;margin-top:2px">▸</span><span>$1</span></div>')
    .replace(/^\|(.+)\|$/gm, row => {
      const cells = row.split('|').filter(Boolean).map(c => c.trim())
      if (cells.every(c => /^-+$/.test(c))) return ''
      return '<tr>' + cells.map(c => `<td style="border:1px solid #2e2e2e;padding:8px 12px;font-size:13px;color:#aaa">${c}</td>`).join('') + '</tr>'
    })
    .replace(/(<tr>[\s\S]+?<\/tr>)/g, m => `<table style="width:100%;border-collapse:collapse;margin:12px 0">${m}</table>`)
    .replace(/\n\n/g, '<br/>')
}

// ── Main component ───────────────────────────────────────────────────────────
export default function LectureViewer({ lectureId, langId, onBack, onNavigateLecture }) {
  const [lecture,    setLecture]    = useState(null)
  const [siblings,   setSiblings]   = useState([])   // all lectures in this language
  const [prev,       setPrev]       = useState(null)
  const [next,       setNext]       = useState(null)
  const [loading,    setLoading]    = useState(true)
  const [completing, setCompleting] = useState(false)

  // Quiz state
  const [quizPrompt, setQuizPrompt] = useState(false)  // show "take a quiz?" banner
  const [showQuiz,   setShowQuiz]   = useState(false)
  const [quiz,       setQuiz]       = useState(null)
  const [answers,    setAnswers]    = useState({})
  const [result,     setResult]     = useState(null)
  const [submitting, setSubmitting] = useState(false)

  // Reset and load whenever lectureId changes
  useEffect(() => {
    setShowQuiz(false)
    setQuizPrompt(false)
    setQuiz(null)
    setResult(null)
    setAnswers({})
    fetchLecture()
  }, [lectureId])

  // Load sibling list for sidebar whenever langId changes
  useEffect(() => {
    if (langId) fetchSiblings()
  }, [langId])

  const fetchLecture = async () => {
    setLoading(true)
    try {
      const { data } = await api.get(`/paths/lecture/${lectureId}`)
      setLecture(data.lecture)
      setPrev(data.prev)
      setNext(data.next)
      // Show quiz prompt at bottom if this lecture has a quiz
      if (data.lecture?.quiz_id) setQuizPrompt(true)
    } catch {}
    finally { setLoading(false) }
  }

  const fetchSiblings = async () => {
    try {
      const { data } = await api.get(`/paths/${langId}/lectures`)
      setSiblings(data.lectures || [])
    } catch {}
  }

  const markComplete = async () => {
    setCompleting(true)
    try {
      await api.post(`/paths/lecture/${lectureId}/complete`)
      setLecture(l => ({ ...l, completed: true }))
      setSiblings(s => s.map(lec => lec.id === lectureId ? { ...lec, completed: true } : lec))
    } catch {}
    finally { setCompleting(false) }
  }

  const openQuiz = async () => {
    try {
      const { data } = await api.get(`/paths/quiz/${lectureId}`)
      setQuiz(data)
      setShowQuiz(true)
      setQuizPrompt(false)
    } catch {
      alert('No quiz available for this lecture yet.')
    }
  }

  const submitQuiz = async () => {
    if (Object.keys(answers).length < quiz.questions.length)
      return alert('Please answer all questions before submitting.')
    setSubmitting(true)
    try {
      const { data } = await api.post(`/paths/quiz/${quiz.quiz_id}/submit`, { answers })
      setResult(data)
    } catch {}
    finally { setSubmitting(false) }
  }

  // ── Render ─────────────────────────────────────────────────────────────────
  return (
    <div className="flex h-full">

      {/* ── Left: lecture list sidebar ── */}
      <aside className="w-56 shrink-0 border-r border-border flex flex-col overflow-hidden"
        style={{ background: 'rgba(0,0,0,0.25)' }}>

        {/* Header */}
        <div className="p-4 border-b border-border shrink-0" style={{ background: '#151515' }}>
          <button onClick={() => onBack && onBack()}
            className="flex items-center gap-1.5 text-xs text-muted hover:text-white transition mb-3">
            ← All Languages
          </button>
          {lecture && (
            <div className="flex items-center gap-2">
              <span className="text-2xl">{lecture.language_icon}</span>
              <span className="text-sm font-semibold text-white">{lecture.language_name}</span>
            </div>
          )}
        </div>

        {/* Lecture links */}
        <nav className="overflow-y-auto flex-1 py-1">
          {siblings.map((lec, i) => {
            const isActive = lec.id === lectureId
            return (
              <button key={lec.id}
                onClick={() => onNavigateLecture && onNavigateLecture(lec.id, langId)}
                className="w-full text-left px-4 py-2.5 text-xs leading-snug flex items-start gap-2 transition-all"
                style={{
                  borderLeft: isActive ? '2px solid #d13a97' : '2px solid transparent',
                  background:  isActive ? 'rgba(209,58,151,0.10)' : 'transparent',
                  color:       isActive ? '#fff' : lec.completed ? '#00c896' : '#bbb',
                }}>
                <span className="shrink-0 w-4 font-mono text-[10px] mt-0.5 opacity-60">
                  {lec.completed ? '✓' : i + 1}
                </span>
                <span className={isActive ? 'font-medium' : ''}>{lec.title}</span>
              </button>
            )
          })}
        </nav>
      </aside>

      {/* ── Right: lecture content ── */}
      <div className="flex-1 overflow-y-auto">
        {loading ? (
          <div className="flex items-center justify-center h-64">
            <div className="w-6 h-6 border-2 border-accent/30 border-t-accent rounded-full animate-spin" />
          </div>
        ) : !lecture ? (
          <div className="text-muted text-center py-20">Lecture not found</div>
        ) : (
          <div className="max-w-3xl p-10">

            {/* Breadcrumb */}
            <div className="flex items-center gap-2 text-xs text-muted mb-5 flex-wrap">
              <button onClick={() => onBack && onBack()} className="hover:text-white transition">
                Learn
              </button>
              <span>/</span>
              <span>{lecture.language_icon} {lecture.language_name}</span>
              <span>/</span>
              <span className="text-white">{lecture.title}</span>
            </div>

            {/* Title + badges + actions */}
            <div className="mb-7">
              <div className="flex items-center gap-2 mb-3 flex-wrap">
                <span className="text-xs px-2 py-0.5 rounded-full capitalize"
                  style={{ background:'rgba(255,45,120,0.1)', border:'1px solid rgba(255,45,120,0.3)', color:'#ff2d78' }}>
                  {lecture.difficulty_level}
                </span>
                {lecture.completed && (
                  <span className="text-xs px-2 py-0.5 rounded-full"
                    style={{ background:'rgba(0,200,150,0.1)', border:'1px solid rgba(0,200,150,0.3)', color:'#00c896' }}>
                    ✓ Completed
                  </span>
                )}
              </div>
              <h1 className="font-serif text-2xl font-bold text-white mb-4">{lecture.title}</h1>
              <div className="flex gap-2 flex-wrap">
                {!lecture.completed && (
                  <button onClick={markComplete} disabled={completing}
                    className="btn-primary px-5 py-2 text-sm disabled:opacity-50">
                    {completing ? 'Saving…' : '✓ Mark as Complete'}
                  </button>
                )}
                {lecture.youtube_link && (
                  <a href={lecture.youtube_link} target="_blank" rel="noreferrer"
                    className="px-5 py-2 rounded-lg text-sm font-medium border border-border text-muted hover:text-white hover:border-red-500/40 transition-all flex items-center gap-2">
                    ▶ Watch Video
                  </a>
                )}
              </div>
            </div>

            {/* Lecture body */}
            <div className="glass-card p-7 mb-6">
              <div className="leading-relaxed text-[14px]"
                dangerouslySetInnerHTML={{ __html: renderMarkdown(
                  lecture.content || '## Content coming soon\n\nThis lecture is being prepared.'
                ) }} />
            </div>

            {/* YouTube recommendation (after content) */}
            {lecture.youtube_link && (
              <div className="glass-card p-5 mb-6 flex items-center gap-4"
                style={{ borderColor: 'rgba(255,50,50,0.25)' }}>
                <div className="w-12 h-12 rounded-xl flex items-center justify-center shrink-0 text-xl"
                  style={{ background:'rgba(255,0,0,0.1)', border:'1px solid rgba(255,0,0,0.25)' }}>
                  ▶
                </div>
                <div className="flex-1">
                  <p className="text-sm font-semibold text-white mb-0.5">
                    Recommended video for this lecture
                  </p>
                  <p className="text-xs text-muted">
                    Watch on YouTube to reinforce what you just read
                  </p>
                </div>
                <a href={lecture.youtube_link} target="_blank" rel="noreferrer"
                  className="btn-ghost px-4 py-2 text-sm shrink-0">
                  Watch →
                </a>
              </div>
            )}

            {/* Quiz prompt banner */}
            {quizPrompt && !showQuiz && !result && (
              <div className="glass-card p-5 mb-6 flex items-center gap-4 animate-fadeup"
                style={{ borderColor: 'rgba(255,176,32,0.3)' }}>
                <span className="text-3xl">📝</span>
                <div className="flex-1">
                  <p className="text-sm font-semibold text-white mb-0.5">
                    Ready to test your knowledge?
                  </p>
                  <p className="text-xs text-muted leading-relaxed">
                    Take a short quiz on this lecture — optional, no pressure.
                  </p>
                </div>
                <div className="flex gap-2 shrink-0">
                  <button onClick={() => setQuizPrompt(false)}
                    className="px-3 py-1.5 rounded-lg text-xs border border-border text-muted hover:text-white transition">
                    Skip
                  </button>
                  <button onClick={openQuiz} className="btn-primary px-4 py-1.5 text-xs">
                    Take Quiz
                  </button>
                </div>
              </div>
            )}

            {/* Quiz panel */}
            {showQuiz && quiz && (
              <div className="glass-card p-6 mb-6 animate-fadeup">
                <div className="flex items-center justify-between mb-5">
                  <h2 className="font-serif text-lg font-semibold">Quiz — {lecture.title}</h2>
                  <button
                    onClick={() => { setShowQuiz(false); setResult(null); setAnswers({}); }}
                    className="text-xs text-muted hover:text-white transition">
                    ✕ Close
                  </button>
                </div>

                {result ? (
                  /* Result screen */
                  <div className="text-center py-4">
                    <div className="text-6xl font-bold mb-2" style={{
                      background: 'linear-gradient(135deg,#d13a97,#8b2fc9)',
                      WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent'
                    }}>
                      {result.score}%
                    </div>
                    <p className="text-muted text-sm mb-1">{result.correct} / {result.total} correct</p>
                    <p className="text-sm font-medium mt-2"
                      style={{ color: result.score >= 70 ? '#00c896' : '#ffb020' }}>
                      {result.score >= 90 ? '🔥 Outstanding! You nailed it.' :
                       result.score >= 70 ? '✅ Solid work. Keep going.' :
                       result.score >= 40 ? '📖 Getting there — review and retry.' :
                       "💡 Revisit this lecture, then try again."}
                    </p>
                    <div className="mt-5 space-y-1.5 text-left">
                      {result.results.map((r, i) => (
                        <div key={i} className="flex items-center gap-3 text-xs">
                          <span style={{ color: r.isRight ? '#00c896' : '#ff4d4f', fontWeight: 600 }}>
                            {r.isRight ? '✓' : '✗'}
                          </span>
                          <span className="text-muted">Q{i+1}:</span>
                          <span style={{ color: r.isRight ? '#00c896' : '#ff4d4f' }}>
                            You answered {r.given}
                          </span>
                          {!r.isRight && <span className="text-muted">(correct: {r.correct})</span>}
                        </div>
                      ))}
                    </div>
                    <button onClick={() => { setResult(null); setAnswers({}) }}
                      className="btn-ghost px-6 py-2 text-sm mt-5">
                      Retry Quiz
                    </button>
                  </div>
                ) : (
                  /* Questions */
                  <div className="space-y-6">
                    {quiz.questions.map((q, i) => (
                      <div key={q.id}>
                        <p className="text-sm font-medium text-white mb-3">{i+1}. {q.question_text}</p>
                        <div className="space-y-2">
                          {['A','B','C','D'].map(opt => {
                            const text = q[`option_${opt.toLowerCase()}`]
                            const sel  = answers[q.id] === opt
                            return (
                              <label key={opt}
                                className={`flex items-center gap-3 p-3 rounded-xl border cursor-pointer transition-all ${
                                  sel ? 'border-accent/60 bg-accent/10 text-white'
                                      : 'border-border text-muted hover:border-accent/30 hover:text-white'
                                }`}>
                                <input type="radio" name={`q_${q.id}`} className="hidden"
                                  onChange={() => setAnswers(a => ({ ...a, [q.id]: opt }))} />
                                <span className={`w-7 h-7 rounded-lg flex items-center justify-center text-xs font-mono font-semibold shrink-0 ${
                                  sel ? 'bg-accent text-white' : 'bg-white/5 text-muted'
                                }`}>{opt}</span>
                                <span className="text-sm">{text}</span>
                              </label>
                            )
                          })}
                        </div>
                      </div>
                    ))}
                    <button onClick={submitQuiz} disabled={submitting}
                      className="btn-primary px-8 py-2.5 text-sm w-full disabled:opacity-50">
                      {submitting ? 'Checking…' : 'Submit Answers'}
                    </button>
                  </div>
                )}
              </div>
            )}

            {/* Prev / Next navigation */}
            <div className="flex gap-3">
              {prev && (
                <button
                  className="flex-1 glass-card p-4 text-left hover:border-accent/30 transition-all group"
                  onClick={() => onNavigateLecture && onNavigateLecture(prev.id, langId)}>
                  <p className="text-[10px] text-muted mb-1 uppercase tracking-wider">← Previous</p>
                  <p className="text-sm font-medium text-white group-hover:text-accent transition-colors">
                    {prev.title}
                  </p>
                </button>
              )}
              {next && (
                <button
                  className="flex-1 glass-card p-4 text-right hover:border-accent/30 transition-all group ml-auto"
                  onClick={() => onNavigateLecture && onNavigateLecture(next.id, langId)}>
                  <p className="text-[10px] text-muted mb-1 uppercase tracking-wider">Next →</p>
                  <p className="text-sm font-medium text-white group-hover:text-accent transition-colors">
                    {next.title}
                  </p>
                </button>
              )}
            </div>

          </div>
        )}
      </div>
    </div>
  )
}
