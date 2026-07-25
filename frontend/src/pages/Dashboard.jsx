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

// ── Navbar layout controls ──────────────────────────────────────────
// Change these and the whole top bar (plus sidebar/main offsets below,
// which stay in sync automatically) will follow.
const NAVBAR_HEIGHT    = 20  // px — overall bar height
const NAVBAR_PADDING_X = 20  // px — left/right edge spacing
const NAVBAR_GAP_LOGO  = 10  // px — gap between dot and "ReflectAI" text
const NAVBAR_GAP_USER  = 10  // px — gap between avatar and name/sign-out

// Vertical position of the logo/user content INSIDE the bar.
// 'flex-start' = stick to top, 'center' = middle, 'flex-end' = stick to bottom.
const NAVBAR_VERTICAL_ALIGN = 'center'
// Fine-tune nudge on top of the alignment above (px). Positive = push down,
// negative = push up. Use this for small adjustments once ALIGN is set.
const NAVBAR_VERTICAL_NUDGE = -21

// ── Logo ("ReflectAI") controls ─────────────────────────────────────
const LOGO_DOT_SIZE   = 10    // px — diameter of the pink/purple dot
const LOGO_FONT_SIZE  = 16   // px — "ReflectAI" text size
const LOGO_FONT_WEIGHT = 600 // 400 normal / 600 semibold / 700 bold

// ── User block (avatar + name/sign-out) controls ────────────────────
const AVATAR_SIZE          = 28  // px — circle diameter
const AVATAR_FONT_SIZE     = 11  // px — initial letter inside the circle
const USERNAME_FONT_SIZE   = 12  // px — user's name text
const SIGNOUT_FONT_SIZE    = 10  // px — "Sign out" text
const USER_TEXT_LINE_GAP   = 2   // px — space between name and "Sign out"

export default function Dashboard() {
  const { user, logout } = useAuth()
  const navigate = useNavigate()

  const [tab,       setTab]       = useState('evaluate')
  const [mizuEnabled, setMizuEnabled] = useState(
  () => localStorage.getItem('reflectai_mizu') !== 'off'
)
  const [lectureId, setLectureId] = useState(null)   // null = show Learn home/lang picker
  const [langId, setLangId] = useState(null)
  const [sidebarOpen, setSidebarOpen] = useState(true)
  const [sidebarBtnHover, setSidebarBtnHover] = useState(false)
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
      <nav
        className="sticky top-0 z-50 flex justify-between border-b border-border bg-bg/90 backdrop-blur-xl"
        style={{
          height: NAVBAR_HEIGHT,
          paddingLeft: NAVBAR_PADDING_X,
          paddingRight: NAVBAR_PADDING_X,
          alignItems: NAVBAR_VERTICAL_ALIGN,
        }}
      >
        <div className="flex items-center" style={{ gap: NAVBAR_GAP_LOGO, marginTop: NAVBAR_VERTICAL_NUDGE }}>
          <div style={{ position: 'relative' }}>
            <button
              onClick={() => setSidebarOpen(o => !o)}
              onMouseEnter={() => setSidebarBtnHover(true)}
              onMouseLeave={() => setSidebarBtnHover(false)}
              className="flex items-center justify-center rounded-md hover:bg-white/[0.06] transition-colors shrink-0"
              style={{ width: 24, height: 24, marginRight: 4 }}
            >
              <svg
                width="16" height="16" viewBox="0 0 16 16" fill="none"
                xmlns="http://www.w3.org/2000/svg"
                style={{ color: '#888' }}
              >
                <rect x="1.5" y="2.5" width="13" height="11" rx="2" stroke="currentColor" strokeWidth="1.3" />
                <line x1="6" y1="2.5" x2="6" y2="13.5" stroke="currentColor" strokeWidth="1.3" />
                {sidebarOpen ? (
                  <path d="M4.3 8L3.1 6.8M3.1 6.8L4.3 5.6M3.1 6.8H4.7" stroke="currentColor" strokeWidth="1.2" strokeLinecap="round" strokeLinejoin="round" transform="translate(0.3,1.2)" />
                ) : (
                  <path d="M2.9 8L4.1 6.8M4.1 6.8L2.9 5.6M4.1 6.8H2.5" stroke="currentColor" strokeWidth="1.2" strokeLinecap="round" strokeLinejoin="round" transform="translate(0.3,1.2)" />
                )}
              </svg>
            </button>
            {(
              <div
                className="font-mono"
                style={{
                  position: 'absolute',
                  top: '130%',
                  left: 0,
                  whiteSpace: 'nowrap',
                  background: '#161119',
                  border: '1px solid rgba(209,58,151,0.35)',
                  color: '#eee',
                  fontSize: 11,
                  padding: '5px 10px',
                  borderRadius: 6,
                  boxShadow: '0 4px 14px rgba(0,0,0,0.45), 0 0 0 1px rgba(139,47,201,0.15)',
                  zIndex: 100,
                  pointerEvents: 'none',
                  opacity: sidebarBtnHover ? 1 : 0,
                  transform: sidebarBtnHover ? 'translateY(0)' : 'translateY(-4px)',
                  transition: 'opacity 0.15s ease, transform 0.15s ease',
                }}
              >
                {sidebarOpen ? 'Close sidebar' : 'Open sidebar'}
              </div>
            )}
          </div>
          <div className="rounded-full animate-pulse-dot shrink-0"
            style={{
              width: LOGO_DOT_SIZE,
              height: LOGO_DOT_SIZE,
              background: 'linear-gradient(135deg,#d13a97,#8b2fc9)',
              boxShadow: '0 0 8px #d13a97',
            }} />
          <span
            className="font-serif leading-none"
            style={{ fontSize: LOGO_FONT_SIZE, fontWeight: LOGO_FONT_WEIGHT }}
          >
            ReflectAI
          </span>
        </div>
        <div
          className="flex items-center cursor-pointer"
          style={{ gap: NAVBAR_GAP_USER, marginTop: NAVBAR_VERTICAL_NUDGE }}
          onClick={handleLogout}
        >
          <div
            className="rounded-full flex items-center justify-center font-bold text-white shrink-0"
            style={{
              width: AVATAR_SIZE,
              height: AVATAR_SIZE,
              fontSize: AVATAR_FONT_SIZE,
              background: 'linear-gradient(135deg,#d13a97,#8b2fc9)',
            }}
          >
            {user?.name?.charAt(0).toUpperCase()}
          </div>
          <div className="leading-none">
            <div className="font-semibold" style={{ fontSize: USERNAME_FONT_SIZE }}>
              {user?.name}
            </div>
            <div
              className="text-muted2"
              style={{ fontSize: SIGNOUT_FONT_SIZE, marginTop: USER_TEXT_LINE_GAP }}
            >
              Sign out
            </div>
          </div>
        </div>
      </nav>



      <div className="flex flex-1 min-h-0">

        {/* ── Left sidebar nav ── */}
         <aside
  className="border-r border-border bg-card/50 sticky overflow-y-auto shrink-0 flex flex-col"
  style={{
    width: sidebarOpen ? 256 : 50,
    top: NAVBAR_HEIGHT,
    height: `calc(100vh - ${NAVBAR_HEIGHT}px)`,
    transition: 'width 0.25s cubic-bezier(0.4, 0, 0.2, 1)',
  }}
>
  <div className="py-2 flex-1" style={{ paddingTop: 12 }}>
    {NAV.map(section => (
      <div key={section.group} className="mb-1">
        {sidebarOpen && (
          <div className="px-5 mb-1 mt-3 text-[10px] text-muted2 uppercase tracking-widest font-semibold">
            {section.group}
          </div>
        )}
        {!sidebarOpen && <div className="mt-3" />}

        {section.items.map(n => (
          <div
            key={n.id}
            className={`sidebar-item ${tab === n.id ? 'active' : ''}`}
            onClick={() => handleNavTo(n.id)}
            title={!sidebarOpen ? n.label : undefined}
            style={{
              justifyContent: sidebarOpen ? undefined : 'center',
              paddingLeft:    sidebarOpen ? undefined : 0,
              paddingRight:   sidebarOpen ? undefined : 0,
            }}
          >
            <span className="w-5 text-center shrink-0">{n.icon}</span>
            {sidebarOpen && (
              <span style={{ overflow: 'hidden', whiteSpace: 'nowrap' }}>
                {n.label}
              </span>
            )}
          </div>
        ))}
      </div>
    ))}
  </div>
</aside>
        {/* ── Main content ── */}
        {/* Learn tab gets no padding — its child components manage their own layout */}
        <main
          className={`flex-1 overflow-y-auto ${isFullBleed ? '' : 'p-10'}`}
          style={{ height: `calc(100vh - ${NAVBAR_HEIGHT}px)` }}
        >

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
