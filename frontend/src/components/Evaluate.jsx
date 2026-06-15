import { useState, useRef, useEffect } from 'react'
import api from '../api/axios'
import { mizuReact } from '../hooks/useMizu'

const STEPS = ['Enter topic', 'Write explanation', 'Get AI feedback']

export default function Evaluate() {
  const [topic,        setTopic]        = useState('')
  const [explanation,  setExplanation]  = useState('')
  const [step,         setStep]         = useState(0)
  const [loading,      setLoading]      = useState(false)
  const [loadingMsg,   setLoadingMsg]   = useState('')
  const [result,       setResult]       = useState(null)
  const [error,        setError]        = useState('')
  const [isRecording,  setIsRecording]  = useState(false)
  const [micError,     setMicError]     = useState('')

  const resultsRef     = useRef(null)
  const recognitionRef = useRef(null)
  const isRecordingRef = useRef(false)   // ref so onend closure can read current value
  const finalTextRef   = useRef('')      // accumulates final transcript segments

  const loadingSteps = [
    'Analyzing conceptual accuracy...',
    'Evaluating clarity of explanation...',
    'Measuring depth of understanding...',
    'Identifying knowledge gaps...',
    'Detecting misconceptions...',
    'Generating academic feedback...',
  ]

  // ── Voice recording ────────────────────────────────────────────────────────

  const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition

  const startRecording = () => {
    setMicError('')
    if (!SpeechRecognition) {
      setMicError('Your browser does not support voice input. Try Chrome or Edge.')
      return
    }

    const recognition = new SpeechRecognition()
    recognition.continuous     = true
    recognition.interimResults = true
    recognition.lang           = 'en-US'

    recognition.onresult = (e) => {
      let interim = ''
      for (let i = e.resultIndex; i < e.results.length; i++) {
        if (e.results[i].isFinal) {
          finalTextRef.current += e.results[i][0].transcript + ' '
        } else {
          interim += e.results[i][0].transcript
        }
      }
      setExplanation(finalTextRef.current + interim)
    }

    // Auto-restart so pauses never cut the session short
    recognition.onend = () => {
      if (isRecordingRef.current) {
        try { recognition.start() } catch (_) {}
      }
    }

    recognition.onerror = (e) => {
      if (e.error === 'no-speech') return  // normal pause — ignore
      setMicError('Microphone error: ' + e.error)
      stopRecording()
    }

    recognitionRef.current  = recognition
    isRecordingRef.current  = true
    try {
      recognition.start()
      setIsRecording(true)
    } catch {
      setMicError('Could not start microphone. Please allow microphone access.')
    }
  }

  const stopRecording = () => {
    isRecordingRef.current = false
    if (recognitionRef.current) {
      recognitionRef.current.onend = null   // prevent auto-restart
      recognitionRef.current.stop()
      recognitionRef.current = null
    }
    setIsRecording(false)
  }

  const toggleMic = () => {
    if (isRecording) {
      stopRecording()
    } else {
      finalTextRef.current = explanation   // keep any typed text
      startRecording()
    }
  }

  // ── Submit ─────────────────────────────────────────────────────────────────

  const submit = async () => {
    if (isRecording) stopRecording()

    if (!topic.trim())                    { setError('Please enter a topic');                    return }
    if (explanation.trim().length < 30)   { setError('Write at least a couple of sentences');    return }
    setError('')
    setLoading(true)
    setStep(2)

    let si = 0
    setLoadingMsg(loadingSteps[0])
    const interval = setInterval(() => {
      si = (si + 1) % loadingSteps.length
      setLoadingMsg(loadingSteps[si])
    }, 900)

    try {
      const { data } = await api.post('/evaluate', { topic, explanation })
      setResult(data)
      setTimeout(() => resultsRef.current?.scrollIntoView({ behavior: 'smooth' }), 100)
      const avg = Math.round(((data.accuracy || 0) + (data.clarity || 0) + (data.depth || 0)) / 3)
      mizuReact('eval_result', {
        topic,
        accuracy: data.accuracy || 0,
        clarity:  data.clarity  || 0,
        depth:    data.depth    || 0,
        avg,
        misconceptions: data.misconceptions || [],
        strengths:      data.strengths      || [],
      })
    } catch (err) {
      setError(err.response?.data?.error || 'Evaluation failed. Check your OpenAI key in backend .env')
      setStep(1)
    } finally {
      clearInterval(interval)
      setLoading(false)
    }
  }

  const reset = () => {
    stopRecording()
    finalTextRef.current = ''
    setTopic(''); setExplanation(''); setStep(0); setResult(null); setError(''); setMicError('')
  }

  useEffect(() => () => stopRecording(), [])

  return (
    <div>
      <h1 className="font-serif text-2xl font-semibold mb-1">Evaluate a Concept</h1>
      <p className="text-muted text-sm mb-8">Explain what you know — our AI will score your conceptual depth</p>

      {/* Input card */}
      <div className="glass-card p-7 mb-6">

        {/* Step indicator */}
        <div className="flex gap-0 mb-7">
          {STEPS.map((s, i) => (
            <div key={s} className="flex items-center gap-2 flex-1">
              <div className={`w-7 h-7 rounded-full border-2 flex items-center justify-center
                               text-xs font-bold flex-shrink-0 transition-all duration-300
                               ${i < step  ? 'bg-teal border-teal text-black'
                               : i === step ? 'border-accent text-white shadow-[0_0_14px_rgba(209,58,151,0.4)]'
                                             : 'border-border text-muted2'}`}
                   style={i === step ? { background: 'linear-gradient(135deg,#d13a97,#8b2fc9)' } : {}}>
                {i < step ? '✓' : i + 1}
              </div>
              <span className={`text-sm font-medium ${i === step ? 'text-white' : 'text-muted2'}`}>{s}</span>
              {i < STEPS.length - 1 && <div className="flex-1 h-px bg-border mx-2" />}
            </div>
          ))}
        </div>

        {/* Topic */}
        <div className="relative mb-4">
          <span className="absolute left-4 top-1/2 -translate-y-1/2 text-muted2">🔍</span>
          <input id="mizuTopicInput"
                 value={topic}
                 onChange={e => { setTopic(e.target.value); setStep(e.target.value ? 1 : 0) }}
                 placeholder="e.g. Photosynthesis, Newton's Second Law, Binary Search..."
                 className="form-input pl-10" />
        </div>

        {/* Explanation textarea */}
        <div className="relative mb-1">
          <textarea
            id="mizuExplainInput"
            value={explanation}
            onChange={e => {
              setExplanation(e.target.value)
              if (!isRecording) finalTextRef.current = e.target.value
            }}
            placeholder={isRecording
              ? 'Listening… speak freely, take pauses — recording continues until you click Evaluate ↓'
              : 'Explain the concept in your own words. Type here or click "Use Mic" below. The AI evaluates conceptual depth, not memorised definitions...'}
            rows={6}
            className="form-input resize-y leading-relaxed"
            style={isRecording
              ? { borderColor: 'rgba(209,58,151,0.6)', boxShadow: '0 0 0 3px rgba(209,58,151,0.12)', transition: 'all .2s' }
              : {}}
          />
        </div>

        {/* Recording status */}
        <div className="flex items-center gap-2 mb-4 min-h-[22px]">
          {isRecording && (
            <>
              <span className="relative flex h-2.5 w-2.5 flex-shrink-0">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-[#d13a97] opacity-75" />
                <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-[#d13a97]" />
              </span>
              <span className="text-xs font-medium" style={{ color: '#d13a97' }}>
                Recording… pauses won't stop it — click <strong>Evaluate</strong> when done
              </span>
            </>
          )}
          {micError && <span className="text-xs text-red-400">{micError}</span>}
        </div>

        {error && (
          <div className="mb-4 px-4 py-2.5 rounded-lg bg-danger/10 border border-danger/25 text-sm text-red-400">
            {error}
          </div>
        )}

        {/* Bottom bar */}
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3">
            <span className="text-xs text-muted2 font-mono">{explanation.length} characters</span>

            {/* Mic button */}
            <button
              onClick={toggleMic}
              title={isRecording ? 'Stop recording' : 'Start voice — won\'t stop on pauses'}
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold
                         transition-all duration-200 border select-none"
              style={isRecording
                ? { background: 'rgba(209,58,151,0.15)', borderColor: 'rgba(209,58,151,0.55)', color: '#d13a97' }
                : { background: 'rgba(255,255,255,0.05)', borderColor: 'rgba(255,255,255,0.12)', color: '#aaa' }}
            >
              {isRecording ? (
                <>
                  <svg width="12" height="12" viewBox="0 0 14 14" fill="currentColor">
                    <rect x="2" y="2" width="10" height="10" rx="2" />
                  </svg>
                  Stop Mic
                </>
              ) : (
                <>
                  <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                       strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <rect x="9" y="2" width="6" height="12" rx="3" />
                    <path d="M5 10a7 7 0 0 0 14 0" />
                    <line x1="12" y1="19" x2="12" y2="22" />
                    <line x1="8"  y1="22" x2="16" y2="22" />
                  </svg>
                  Use Mic
                </>
              )}
            </button>
          </div>

          <button onClick={submit} disabled={loading}
                  className="btn-primary px-8 py-2.5 text-sm disabled:opacity-60">
            {loading ? (
              <span className="flex items-center gap-2">
                <span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                {loadingMsg}
              </span>
            ) : 'Evaluate →'}
          </button>
        </div>
      </div>

      {/* Results */}
      {result && (
        <div ref={resultsRef}>
          <div className="flex items-center gap-2 mb-5">
            <div className="w-1.5 h-1.5 rounded-full bg-teal" style={{ boxShadow: '0 0 8px #00c896' }} />
            <span className="text-xs text-muted uppercase tracking-widest font-semibold">Evaluation complete</span>
          </div>

          <div className="grid grid-cols-3 gap-3 mb-4">
            <ScoreCard label="Accuracy" value={result.accuracy}  color="#d13a97" barClass="bg-brand-grad" />
            <ScoreCard label="Clarity"  value={result.clarity}   color="#00c896" barClass="bg-teal" />
            <ScoreCard label="Depth"    value={result.depth}     color="#ffb020" barClass="bg-warn" />
          </div>

          <div className="grid grid-cols-2 gap-3 mb-4">
            <div className="glass-card p-5">
              <div className="text-xs text-muted uppercase tracking-widest font-semibold mb-3 flex items-center gap-2">
                <span className="w-1.5 h-1.5 rounded-full bg-warn" />
                Missing Concepts
              </div>
              <div>
                {(result.missing_concepts || []).length > 0
                  ? result.missing_concepts.map(c => <span key={c} className="concept-tag-missing">⚠ {c}</span>)
                  : <span className="concept-tag-covered">✓ None detected</span>}
              </div>
            </div>
            <div className="glass-card p-5">
              <div className="text-xs text-muted uppercase tracking-widest font-semibold mb-3 flex items-center gap-2">
                <span className="w-1.5 h-1.5 rounded-full bg-danger" />
                Misconceptions
              </div>
              <div>
                {(result.misconceptions || []).length > 0
                  ? result.misconceptions.map(c => <span key={c} className="concept-tag-misconception">✗ {c}</span>)
                  : <span className="concept-tag-covered">✓ None detected</span>}
              </div>
            </div>
          </div>

          {result.coverage?.length > 0 && (
            <div className="glass-card p-6 mb-4">
              <div className="text-xs text-muted uppercase tracking-widest font-semibold mb-5 flex items-center gap-2">
                <span className="w-1.5 h-1.5 rounded-full bg-accent" />
                Concept Coverage Breakdown
              </div>
              {result.coverage.map(c => {
                const colMap = { covered: '#00c896', partial: '#ffb020', missing: '#ff4d4f' }
                return (
                  <div key={c.concept} className="mb-4">
                    <div className="flex justify-between text-sm mb-1.5">
                      <span className="font-medium">{c.concept}</span>
                      <span className="font-mono text-muted text-xs">{c.percentage}%</span>
                    </div>
                    <div className="h-1.5 bg-border rounded-full overflow-hidden">
                      <div className="h-full rounded-full transition-all duration-1000"
                           style={{ width: `${c.percentage}%`, background: colMap[c.status] || '#666' }} />
                    </div>
                  </div>
                )
              })}
            </div>
          )}

          <div className="glass-card p-6 mb-6">
            <div className="flex items-center gap-2 mb-4">
              <span>🎓</span>
              <div className="text-xs text-muted uppercase tracking-widest font-semibold">Academic Feedback</div>
            </div>
            <p className="text-[#ddd] text-sm leading-relaxed italic border-l-2 border-accent pl-4 mb-5">
              {result.academic_feedback}
            </p>
            {result.revision_notes?.length > 0 && (
              <div className="bg-accent/5 border border-accent/15 rounded-xl p-4">
                <div className="text-xs text-accent uppercase tracking-widest font-semibold mb-3">
                  Simplified Revision Notes
                </div>
                {result.revision_notes.map((n, i) => (
                  <div key={i} className="flex gap-2.5 text-sm text-muted mb-2">
                    <span className="text-accent mt-0.5 shrink-0">→</span>
                    <span>{n}</span>
                  </div>
                ))}
              </div>
            )}
          </div>

          <button onClick={reset} className="btn-primary px-6 py-2.5 text-sm">
            ← New Evaluation
          </button>
        </div>
      )}
    </div>
  )
}

function ScoreCard({ label, value, color, barClass }) {
  const [displayed, setDisplayed] = useState(0)

  useEffect(() => {
    let current = 0
    const step = value / 60
    const timer = setInterval(() => {
      current = Math.min(current + step, value)
      setDisplayed(Math.floor(current))
      if (current >= value) clearInterval(timer)
    }, 16)
    return () => clearInterval(timer)
  }, [value])

  const badge = value >= 80 ? { cls: 'text-teal bg-teal/10', txt: '↑ Excellent' }
              : value >= 65 ? { cls: 'text-teal bg-teal/10', txt: '↑ Good' }
                            : { cls: 'text-danger bg-danger/10', txt: '↓ Needs work' }

  return (
    <div className="glass-card p-5">
      <div className="text-xs text-muted uppercase tracking-widest font-semibold mb-2.5">{label}</div>
      <div>
        <span className="font-serif text-4xl font-semibold" style={{ color }}>{displayed}</span>
        <span className="text-muted text-sm ml-1">/100</span>
      </div>
      <span className={`inline-flex items-center text-xs font-semibold mt-2 px-2 py-0.5 rounded-full ${badge.cls}`}>
        {badge.txt}
      </span>
      <div className="h-1 bg-border rounded-full mt-3 overflow-hidden">
        <div className={`score-bar ${barClass}`} style={{ width: `${value}%` }} />
      </div>
    </div>
  )
}
