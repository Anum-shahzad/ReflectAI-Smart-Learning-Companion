import { useState, useEffect } from 'react'
import api from '../api/axios'

const DIFF_COLORS = {
  beginner:     { bg: 'rgba(0,200,150,0.1)', border: 'rgba(0,200,150,0.3)', text: '#00c896' },
  intermediate: { bg: 'rgba(255,176,32,0.1)', border: 'rgba(255,176,32,0.3)', text: '#ffb020' },
  advanced:     { bg: 'rgba(255,77,79,0.1)', border: 'rgba(255,77,79,0.3)', text: '#ff4d4f' },
}

export default function ProgrammingPaths({ onOpenLecture }) {
  const [languages, setLanguages] = useState([])
  const [selected,  setSelected]  = useState(null)
  const [lectures,  setLectures]  = useState([])
  const [langInfo,  setLangInfo]  = useState(null)
  const [loading,   setLoading]   = useState(true)

  useEffect(() => { fetchLanguages() }, [])

  const fetchLanguages = async () => {
    try {
      const { data } = await api.get('/paths')
      setLanguages(data.languages || [])
    } catch {}
    finally { setLoading(false) }
  }

  const selectLanguage = async (lang) => {
    setSelected(lang.id)
    setLangInfo(lang)
    setLoading(true)
    try {
      const { data } = await api.get(`/paths/${lang.id}/lectures`)
      setLectures(data.lectures || [])
    } catch {}
    finally { setLoading(false) }
  }

  if (loading && !selected) return (
    <div className="flex items-center justify-center h-64">
      <div className="w-6 h-6 border-2 border-accent/30 border-t-accent rounded-full animate-spin"/>
    </div>
  )

  return (
    <div>
      <h1 className="font-serif text-2xl font-semibold mb-1">Programming Paths</h1>
      <p className="text-muted text-sm mb-8">Structured learning paths for CS & engineering students</p>

      {!selected ? (
        /* Language Grid */
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {languages.map(lang => {
            const pct = lang.lecture_count > 0 ? Math.round((lang.completed_count / lang.lecture_count) * 100) : 0
            return (
              <div key={lang.id}
                onClick={() => selectLanguage(lang)}
                className="glass-card p-6 cursor-pointer hover:border-accent/40 transition-all group hover:-translate-y-0.5"
                style={{ borderColor: selected === lang.id ? lang.color : undefined }}>
                <div className="flex items-start justify-between mb-4">
                  <div className="text-4xl">{lang.icon}</div>
                  <div className="text-xs font-mono px-2 py-1 rounded-full"
                    style={{ background: `${lang.color}15`, border: `1px solid ${lang.color}40`, color: lang.color }}>
                    {lang.lecture_count} lectures
                  </div>
                </div>
                <h3 className="font-semibold text-white text-lg mb-1 group-hover:text-accent transition-colors">{lang.name}</h3>
                <p className="text-muted text-xs mb-4 leading-relaxed">{lang.description}</p>

                {/* Progress bar */}
                {lang.completed_count > 0 && (
                  <div>
                    <div className="flex justify-between text-xs text-muted mb-1.5">
                      <span>Progress</span>
                      <span style={{ color: lang.color }}>{pct}%</span>
                    </div>
                    <div className="h-1.5 rounded-full bg-white/5">
                      <div className="h-1.5 rounded-full transition-all duration-700"
                        style={{ width: `${pct}%`, background: lang.color }} />
                    </div>
                  </div>
                )}
              </div>
            )
          })}
        </div>
      ) : (
        /* Lecture List */
        <div>
          <div className="flex items-center gap-3 mb-6">
            <button onClick={() => { setSelected(null); setLectures([]) }}
              className="text-muted text-sm hover:text-white transition flex items-center gap-1.5">
              ← Languages
            </button>
            <span className="text-border">/</span>
            <div className="flex items-center gap-2">
              <span className="text-2xl">{langInfo?.icon}</span>
              <span className="font-semibold text-white">{langInfo?.name}</span>
            </div>
            <div className="ml-auto text-xs text-muted">
              {langInfo?.completed_count || 0} / {langInfo?.lecture_count || 0} completed
            </div>
          </div>

          {loading ? (
            <div className="flex items-center justify-center h-40">
              <div className="w-6 h-6 border-2 border-accent/30 border-t-accent rounded-full animate-spin"/>
            </div>
          ) : (
            <div className="space-y-2">
              {lectures.map((lec, i) => {
                const diff = DIFF_COLORS[lec.difficulty_level] || DIFF_COLORS.beginner
                return (
                  <div key={lec.id}
                    onClick={() => onOpenLecture && onOpenLecture(lec.id)}
                    className="glass-card p-5 flex items-center gap-4 cursor-pointer hover:border-accent/30 transition-all group">
                    {/* Number / checkmark */}
                    <div className="w-9 h-9 rounded-full flex items-center justify-center shrink-0 text-sm font-mono font-semibold"
                      style={{
                        background: lec.completed ? 'rgba(0,200,150,0.15)' : 'rgba(255,255,255,0.04)',
                        border: lec.completed ? '1.5px solid rgba(0,200,150,0.5)' : '1.5px solid #2e2e2e',
                        color: lec.completed ? '#00c896' : '#666',
                      }}>
                      {lec.completed ? '✓' : i + 1}
                    </div>

                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <h3 className="font-medium text-white group-hover:text-accent transition-colors">{lec.title}</h3>
                        <span className="text-[10px] px-2 py-0.5 rounded-full capitalize"
                          style={{ background: diff.bg, border: `1px solid ${diff.border}`, color: diff.text }}>
                          {lec.difficulty_level}
                        </span>
                      </div>
                      {lec.score != null && (
                        <p className="text-xs text-muted mt-0.5">Quiz score: <span style={{ color: lec.score >= 70 ? '#00c896' : '#ffb020' }}>{lec.score}%</span></p>
                      )}
                    </div>

                    <div className="flex items-center gap-3 shrink-0">
                      {lec.quiz_id && (
                        <span className="text-xs px-2 py-1 rounded-md border border-border text-muted">📝 Quiz</span>
                      )}
                      <span className="text-muted group-hover:text-white transition-colors">→</span>
                    </div>
                  </div>
                )
              })}
            </div>
          )}
        </div>
      )}
    </div>
  )
}
