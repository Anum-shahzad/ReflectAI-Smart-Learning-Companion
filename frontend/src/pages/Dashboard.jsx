import React, { useState } from 'react'
import { useAuth }    from '../context/AuthContext'
import { useNavigate } from 'react-router-dom'

import Evaluate       from '../components/Evaluate'
import History        from '../components/History'
import Analytics      from '../components/Analytics'
import NotesGenerator from '../components/NotesGenerator'
import Chatbot        from '../components/Chatbot'
import Learn          from '../components/Learn'
import LectureViewer  from '../components/LectureViewer'
import MizuFloat      from '../components/MizuFloat'

const NAV = [
  {
    group: 'MAIN',
    items: [
      { id: 'evaluate',  icon: '⚡', label: 'Evaluate'  },
      { id: 'history',   icon: '📋', label: 'History'   },
      { id: 'analytics', icon: '📊', label: 'Analytics' },
    ],
  },
  {
    group: 'LEARN',
    items: [
      { id: 'learn',  icon: '📚', label: 'Learn'           },
      { id: 'notes',  icon: '📝', label: 'Notes Generator'  },
    ],
  },
  {
    group: 'PRACTICE',
    items: [
      { id: 'chatbot', icon: '💬', label: 'AI Chatbot' },
    ],
  },
  {
    group: 'ACCOUNT',
    items: [
      { id: 'settings', icon: '⚙️', label: 'Settings' },
    ],
  },
]

export default function Dashboard() {
  const { user, logout } = useAuth()
  const navigate = useNavigate()

  const [tab,       setTab]       = useState('evaluate')
  const [mizuEnabled, setMizuEnabled] = useState(
  () => localStorage.getItem('reflectai_mizu') !== 'off'
)
  const [lectureId, setLectureId] = useState(null)   // null = show Learn home/lang picker
  const [langId,    setLangId]    = useState(null)   // currently open language

  const handleLogout = () => { logout(); navigate('/') }

  // Clicking a sidebar nav item — go to that section, clear lecture state
  const handleNavTo = (id) => {
    setTab(id)
    setLectureId(null)
    setLangId(null)
  }

  // User clicks a lecture from Learn's language panel or from LectureViewer prev/next
  const handleOpenLecture = (lId, lngId) => {
    setLectureId(lId)
    if (lngId) setLangId(lngId)
    setTab('learn')
  }

  // "← All Languages" clicked inside LectureViewer
  const handleBackToLearn = () => {
    setLectureId(null)
    // keep langId so Learn re-opens that language's panel
  }

  // Whether the current view needs the full height without padding
  // (both Learn's language panel and LectureViewer use edge-to-edge layout)
  const handleToggleMizu = () => {
  setMizuEnabled(prev => {
    const next = !prev
    localStorage.setItem('reflectai_mizu', next ? 'on' : 'off')
    return next
  })
}
  const isFullBleed = tab === 'learn'

  return (
    <div className="min-h-screen bg-bg flex flex-col">

      {/* ── Top nav ── */}
      <nav className="sticky top-0 z-50 flex items-center justify-between px-10 py-4 border-b border-border bg-bg/90 backdrop-blur-xl">
        <div className="flex items-center gap-2.5">
          <div className="w-2 h-2 rounded-full animate-pulse-dot"
            style={{ background: 'linear-gradient(135deg,#d13a97,#8b2fc9)', boxShadow: '0 0 10px #d13a97' }} />
          <span className="font-serif text-xl font-semibold">ReflectAI</span>
        </div>
        <div className="flex items-center gap-3 cursor-pointer" onClick={handleLogout}>
          <div className="w-9 h-9 rounded-full flex items-center justify-center font-bold text-sm text-white"
            style={{ background: 'linear-gradient(135deg,#d13a97,#8b2fc9)' }}>
            {user?.name?.charAt(0).toUpperCase()}
          </div>
          <div>
            <div className="text-sm font-semibold">{user?.name}</div>
            <div className="text-xs text-muted2">Sign out</div>
          </div>
        </div>
      </nav>

      <div className="flex flex-1 min-h-0">

        {/* ── Left sidebar nav ── */}
        <aside className="w-64 border-r border-border bg-card/50 sticky top-[61px] h-[calc(100vh-61px)] overflow-y-auto shrink-0">
          <div className="py-4">
            {NAV.map(section => (
              <div key={section.group} className="mb-2">
                <div className="px-5 mb-1 mt-3 text-[10px] text-muted2 uppercase tracking-widest font-semibold">
                  {section.group}
                </div>
                {section.items.map(n => (
                  <div key={n.id}
                    className={`sidebar-item ${tab === n.id ? 'active' : ''}`}
                    onClick={() => handleNavTo(n.id)}>
                    <span className="w-5 text-center">{n.icon}</span>
                    {n.label}
                  </div>
                ))}
              </div>
            ))}
          </div>
        </aside>

        {/* ── Main content ── */}
        {/* Learn tab gets no padding — its child components manage their own layout */}
        <main className={`flex-1 overflow-y-auto h-[calc(100vh-61px)] ${isFullBleed ? '' : 'p-10'}`}>

          {tab === 'evaluate'  && <Evaluate />}
          {tab === 'history'   && <History />}
          {tab === 'analytics' && <Analytics />}
          {tab === 'notes'     && <NotesGenerator />}
          {tab === 'chatbot'   && <Chatbot />}
          {tab === 'settings'  && <Settings user={user} mizuEnabled={mizuEnabled} onToggleMizu={handleToggleMizu} />}
          {tab === 'learn' && (
            lectureId
              ? <LectureViewer
                  lectureId={lectureId}
                  langId={langId}
                  onBack={handleBackToLearn}
                  onNavigateLecture={handleOpenLecture}
                />
              : <Learn
                  selectedLangId={langId}
                  onOpenLecture={handleOpenLecture}
                />
          )}
        </main>
      </div>

       {tab !== 'chatbot' && mizuEnabled && <MizuFloat activeTab={tab} />}
    </div>
  )
}

function Settings({ user, mizuEnabled, onToggleMizu }) {
  const [hovered, setHovered] = React.useState(false)

  const handleToggleHover = async (entering) => {
    setHovered(entering)
    if (entering && mizuEnabled) {
      // Mizu reacts dramatically when user hovers the off button
      try {
        const token = localStorage.getItem('reflectai_token')
        if (!token) return
        const res = await fetch('/api/mizu/react', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
          },
          body: JSON.stringify({ trigger: 'mizu_toggle_hover', data: {} }),
        })
        const { line } = await res.json()
        if (line && window.__mizuBus) {
          window.__mizuBus.emit({ line, mood: 'concerned' })
        }
      } catch (_) {}
    }
  }

  return (
    <div>
      <h1 className="font-serif text-2xl font-semibold mb-1">Settings</h1>
      <p className="text-muted text-sm mb-8">Manage your account preferences</p>
      <div className="max-w-md space-y-6">

        <div className="glass-card p-6" data-mizu-perch="settings-profile-card">
          <h2 className="font-semibold text-white mb-4">Profile</h2>
          <div className="space-y-4">
            <div>
              <label className="block text-xs font-mono text-muted uppercase tracking-wider mb-2">Name</label>
              <input defaultValue={user?.name} className="form-input" />
            </div>
            <div>
              <label className="block text-xs font-mono text-muted uppercase tracking-wider mb-2">Email</label>
              <input defaultValue={user?.email} className="form-input" disabled style={{ opacity: 0.6 }} />
            </div>
            <button className="btn-primary px-6 py-2.5 text-sm">Save changes</button>
          </div>
        </div>

        {/* Mizu toggle card */}
        <div className="glass-card p-6">
          <h2 className="font-semibold text-white mb-1">Mizu Companion</h2>
          <p className="text-muted text-xs mb-4">
            Mizu is the AI companion that reacts to what you do. You can hide him if you prefer a quieter experience.
          </p>
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-white">
                {mizuEnabled ? 'Mizu is active' : 'Mizu is hidden'}
              </p>
              <p className="text-xs text-muted mt-0.5">
                {mizuEnabled ? 'Watching your every move.' : 'Gone. But is he really?'}
              </p>
            </div>
            <button
              onMouseEnter={() => handleToggleHover(true)}
              onMouseLeave={() => handleToggleHover(false)}
              onClick={onToggleMizu}
              style={{
                width: 52,
                height: 28,
                borderRadius: 14,
                border: 'none',
                cursor: 'pointer',
                padding: 3,
                background: mizuEnabled
                  ? 'linear-gradient(135deg, #d13a97, #8b2fc9)'
                  : 'rgba(255,255,255,0.08)',
                transition: 'background 0.3s',
                display: 'flex',
                alignItems: 'center',
                justifyContent: mizuEnabled ? 'flex-end' : 'flex-start',
              }}
            >
              <div style={{
                width: 22,
                height: 22,
                borderRadius: '50%',
                background: 'white',
                opacity: mizuEnabled ? 1 : 0.4,
                transition: 'opacity 0.3s',
              }} />
            </button>
          </div>
        </div>

        <div className="glass-card p-6">
          <h2 className="font-semibold text-white mb-4">About ReflectAI</h2>
          <div className="space-y-2 text-sm text-muted">
            <p>Version 2.0 — Learn Edition</p>
            <p>Built for CS, Engineering & AI students</p>
            <p className="text-xs text-muted2 mt-3">Powered by Groq · llama-3.3-70b-versatile</p>
          </div>
        </div>

      </div>
    </div>
  )
}
