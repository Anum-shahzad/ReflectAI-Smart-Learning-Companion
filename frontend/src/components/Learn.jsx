import { useState, useEffect } from 'react'
import api from '../api/axios'

// Map DB language names → W3Schools-style categories
const CATEGORIES = [
  { label: 'HTML & CSS',         color: '#e44d26', keys: ['html','css','bootstrap','tailwind','sass','scss','rwd'] },
  { label: 'JavaScript',         color: '#f0db4f', keys: ['javascript','js','react','vue','angular','typescript','jquery','node','next','nuxt'] },
  { label: 'Backend',            color: '#3572a5', keys: ['python','java','php','ruby','go','rust','kotlin','django','flask','spring','laravel'] },
  { label: 'Database & SQL',     color: '#336791', keys: ['sql','mysql','postgresql','mongodb','sqlite','redis','database'] },
  { label: 'Systems',            color: '#999',    keys: ['c++','cpp','c language','assembly','c#','csharp'] },
  { label: 'Data & AI',          color: '#4584b6', keys: ['data','ai','machine learning','ml','r language','r programming','pandas','numpy','tensorflow','data science'] },
]

function matchCategory(langName) {
  const n = langName.toLowerCase()
  for (const cat of CATEGORIES) {
    if (cat.keys.some(k => n.includes(k))) return cat
  }
  return { label: 'More', color: '#888', keys: [] }
}

export default function Learn({ onOpenLecture, selectedLangId }) {
  const [languages, setLanguages]   = useState([])
  const [loading,   setLoading]     = useState(true)
  // "home" view vs "language selected" view
  const [activeLang,   setActiveLang]   = useState(null)   // full lang object
  const [lectures,     setLectures]     = useState([])
  const [loadingLecs,  setLoadingLecs]  = useState(false)

  useEffect(() => { fetchLanguages() }, [])

  // If parent passes a selectedLangId (e.g. navigating back to same language),
  // reopen that language once languages are loaded
  useEffect(() => {
    if (selectedLangId && languages.length > 0 && !activeLang) {
      const lang = languages.find(l => l.id === selectedLangId)
      if (lang) openLanguage(lang)
    }
  }, [selectedLangId, languages])

  const fetchLanguages = async () => {
    try {
      const { data } = await api.get('/paths')
      setLanguages(data.languages || [])
    } catch {}
    finally { setLoading(false) }
  }

  const openLanguage = async (lang) => {
    setActiveLang(lang)
    setLoadingLecs(true)
    try {
      const { data } = await api.get(`/paths/${lang.id}/lectures`)
      setLectures(data.lectures || [])
    } catch {}
    finally { setLoadingLecs(false) }
  }

  const backToHome = () => {
    setActiveLang(null)
    setLectures([])
  }

  // ── HOME: category grid like W3Schools ─────────────────────────────────────
  if (!activeLang) {
    if (loading) return (
      <div className="flex items-center justify-center h-64">
        <div className="w-6 h-6 border-2 border-accent/30 border-t-accent rounded-full animate-spin" />
      </div>
    )

    // Group languages into categories, preserving order
    const used = new Set()
    const grouped = []
    for (const cat of CATEGORIES) {
      const matched = languages.filter(l => !used.has(l.id) && matchCategory(l.name).label === cat.label)
      if (matched.length) {
        matched.forEach(l => used.add(l.id))
        grouped.push({ ...cat, langs: matched })
      }
    }
    const rest = languages.filter(l => !used.has(l.id))
    if (rest.length) grouped.push({ label: 'More', color: '#888', langs: rest })

    return (
      <div>
        <h1 className="font-serif text-2xl font-semibold mb-1">Learn</h1>
        <p className="text-muted text-sm mb-8">
          Structured tutorials — click any language to start learning
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-x-10 gap-y-8">
          {grouped.map(cat => (
            <div key={cat.label}>
              <h2 className="text-sm font-bold mb-3 pb-2 border-b border-border"
                style={{ color: cat.color }}>
                {cat.label}
              </h2>
              <div className="space-y-0.5">
                {cat.langs.map(lang => {
                  const pct = lang.lecture_count > 0
                    ? Math.round((lang.completed_count / lang.lecture_count) * 100) : 0
                  return (
                    <button key={lang.id} onClick={() => openLanguage(lang)}
                      className="w-full flex items-center justify-between px-2 py-2 rounded-lg text-left group transition-all hover:bg-white/[0.04]">
                      <div className="flex items-center gap-2.5 min-w-0">
                        <span className="text-lg shrink-0">{lang.icon}</span>
                        <div className="min-w-0">
                          <span className="text-sm text-white/90 group-hover:text-white group-hover:underline underline-offset-2 leading-none">
                            Learn {lang.name}
                          </span>
                          {lang.completed_count > 0 && (
                            <div className="flex items-center gap-1.5 mt-1">
                              <div className="h-[3px] w-14 rounded-full bg-white/10">
                                <div className="h-[3px] rounded-full transition-all"
                                  style={{ width: `${pct}%`, background: cat.color }} />
                              </div>
                              <span className="text-[10px] text-muted">{pct}%</span>
                            </div>
                          )}
                        </div>
                      </div>
                      <div className="flex items-center gap-2 shrink-0 ml-2">
                        <span className="text-[10px] text-muted font-mono hidden group-hover:inline">
                          {lang.lecture_count} topics
                        </span>
                        <span className="text-muted group-hover:text-white transition-colors text-sm">›</span>
                      </div>
                    </button>
                  )
                })}
              </div>
            </div>
          ))}
        </div>
      </div>
    )
  }

  // ── LANGUAGE SELECTED: W3Schools-style two-panel layout ─────────────────────
  // This fills the entire main panel — Dashboard removes padding when this is shown
  return (
    <div className="flex h-full">

      {/* Left lecture list sidebar */}
      <aside className="w-56 shrink-0 border-r border-border flex flex-col overflow-hidden"
        style={{ background: 'rgba(0,0,0,0.25)' }}>

        {/* Language header */}
        <div className="p-4 border-b border-border shrink-0" style={{ background: '#151515' }}>
          <button onClick={backToHome}
            className="flex items-center gap-1.5 text-xs text-muted hover:text-white transition mb-3">
            ← All Languages
          </button>
          <div className="flex items-center gap-2">
            <span className="text-2xl">{activeLang.icon}</span>
            <div>
              <div className="text-sm font-semibold text-white">{activeLang.name}</div>
              <div className="text-[10px] text-muted mt-0.5">
                {activeLang.completed_count || 0}/{activeLang.lecture_count || 0} done
              </div>
            </div>
          </div>
          {activeLang.lecture_count > 0 && (
            <div className="mt-2.5 h-1 rounded-full bg-white/5">
              <div className="h-1 rounded-full transition-all"
                style={{
                  width: `${Math.round(((activeLang.completed_count||0)/activeLang.lecture_count)*100)}%`,
                  background: matchCategory(activeLang.name).color,
                }} />
            </div>
          )}
        </div>

        {/* Lecture list */}
        <nav className="overflow-y-auto flex-1 py-1">
          {loadingLecs ? (
            <div className="flex justify-center py-10">
              <div className="w-5 h-5 border-2 border-accent/30 border-t-accent rounded-full animate-spin" />
            </div>
          ) : (
            lectures.map((lec, i) => (
              <button key={lec.id}
                onClick={() => onOpenLecture(lec.id, activeLang.id)}
                className="w-full text-left px-4 py-2.5 text-xs leading-snug transition-all flex items-start gap-2 border-l-2"
                style={{
                  color: lec.completed ? '#00c896' : '#bbb',
                  borderLeftColor: 'transparent',
                  background: 'transparent',
                }}
                onMouseEnter={e => {
                  e.currentTarget.style.background = 'rgba(255,255,255,0.04)'
                  e.currentTarget.style.borderLeftColor = 'rgba(209,58,151,0.4)'
                  e.currentTarget.style.color = '#fff'
                }}
                onMouseLeave={e => {
                  e.currentTarget.style.background = 'transparent'
                  e.currentTarget.style.borderLeftColor = 'transparent'
                  e.currentTarget.style.color = lec.completed ? '#00c896' : '#bbb'
                }}>
                <span className="shrink-0 w-4 font-mono text-[10px] mt-0.5 text-muted">
                  {lec.completed ? '✓' : i + 1}
                </span>
                <span>{lec.title}</span>
              </button>
            ))
          )}
        </nav>
      </aside>

      {/* Right: pick a topic prompt */}
      <div className="flex-1 flex flex-col items-center justify-center p-12 text-center">
        <div className="text-5xl mb-5">{activeLang.icon}</div>
        <h2 className="font-serif text-xl font-semibold mb-2">
          {activeLang.name} Tutorial
        </h2>
        <p className="text-sm text-muted mb-6 max-w-xs leading-relaxed">
          {activeLang.description || `Pick a topic from the sidebar to start learning ${activeLang.name}.`}
        </p>
        {lectures.length > 0 && (
          <button
            onClick={() => onOpenLecture(lectures[0].id, activeLang.id)}
            className="btn-primary px-6 py-2.5 text-sm">
            Start from the beginning →
          </button>
        )}
      </div>
    </div>
  )
}
