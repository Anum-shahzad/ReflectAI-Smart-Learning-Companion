import { useState, useEffect } from 'react'
import api from '../api/axios'
import MizuCharacter from './MizuCharacter'
import { mizuReact } from '../hooks/useMizu'

// Minimal markdown renderer
function renderMarkdown(text) {
  if (!text) return ''
  return text
    .replace(/^### (.+)$/gm, '<h3 class="text-base font-semibold text-white mt-5 mb-2">$1</h3>')
    .replace(/^## (.+)$/gm,  '<h2 class="text-lg font-semibold text-white mt-6 mb-3 pb-2" style="border-bottom:1px solid #2e2e2e">$2</h2>')
    .replace(/^# (.+)$/gm,   '<h1 class="text-xl font-bold text-white mt-4 mb-4">$1</h1>')
    .replace(/\*\*(.+?)\*\*/g, '<strong class="text-white font-semibold">$1</strong>')
    .replace(/\*(.+?)\*/g, '<em class="text-pink-300">$1</em>')
    .replace(/`([^`]+)`/g, '<code class="bg-white/5 border border-white/10 rounded px-1.5 py-0.5 text-xs font-mono text-pink-300">$1</code>')
    .replace(/```(\w+)?\n([\s\S]+?)```/gm, (_, lang, code) =>
      `<pre class="bg-[#0d0d0d] border border-white/10 rounded-xl p-4 my-3 overflow-x-auto"><code class="text-sm font-mono text-green-300">${code.replace(/</g,'&lt;').replace(/>/g,'&gt;')}</code></pre>`)
    .replace(/^\- (.+)$/gm,   '<li class="flex gap-2 text-sm text-[#aaaaaa] my-0.5"><span class="text-pink-400 mt-1 shrink-0">▸</span><span>$1</span></li>')
    .replace(/^\d+\. (.+)$/gm,'<li class="text-sm text-[#aaaaaa] my-0.5 ml-4 list-decimal">$1</li>')
    .replace(/\|(.+)\|/g, m => {
      const cells = m.split('|').filter(Boolean).map(c => c.trim())
      if (cells.every(c => /^-+$/.test(c))) return ''
      return '<tr>' + cells.map(c => `<td class="border border-white/10 px-3 py-2 text-sm text-[#aaaaaa]">${c}</td>`).join('') + '</tr>'
    })
    .replace(/(<tr>[\s\S]+?<\/tr>)/g, '<table class="w-full border-collapse my-3">$1</table>')
    .replace(/\n\n/g, '<br/><br/>')
}

export default function NotesGenerator() {
  const [topic,     setTopic]     = useState('')
  const [content,   setContent]   = useState('')
  const [loading,   setLoading]   = useState(false)
  const [saving,    setSaving]    = useState(false)
  const [saved,     setSaved]     = useState(false)
  const [error,     setError]     = useState('')
  const [savedNotes, setSavedNotes] = useState([])
  const [viewNote,  setViewNote]  = useState(null)
  const [tab,       setTab]       = useState('generate') // 'generate' | 'saved'
   

  useEffect(() => { fetchSaved() }, [])

  const fetchSaved = async () => {
    try {
      const { data } = await api.get('/notes')
      setSavedNotes(data.notes || [])
    } catch {}
  }

  const generate = async () => {
    if (!topic.trim()) return setError('Enter a topic first')
    setError(''); setContent(''); setSaved(false)
    setLoading(true) 
    try {
      const { data } = await api.post('/notes/generate', { topic })
      setContent(data.content)
       
      mizuReact('notes_generated', { topic })
    } catch (err) {
      setError(err.response?.data?.error || 'Failed to generate notes')
      
    } finally {
      setLoading(false)
    }
  }

  const saveNote = async () => {
    if (!content) return
    setSaving(true)
    try {
      await api.post('/notes/save', { topic_name: topic, generated_content: content })
      setSaved(true); fetchSaved()
       
    } catch {
      setError('Failed to save note')
    } finally {
      setSaving(false)
    }
  }

  const deleteNote = async (id) => {
    try {
      await api.delete(`/notes/${id}`)
      setSavedNotes(n => n.filter(x => x.id !== id))
      if (viewNote?.id === id) setViewNote(null)
    } catch {}
  }

  const openNote = async (id) => {
    try {
      const { data } = await api.get(`/notes/${id}`)
      setViewNote(data)
    } catch {}
  }

  const exportPDF = () => {
    const win = window.open('', '_blank')
    win.document.write(`
      <html><head><title>${topic} Notes</title>
      <style>body{font-family:Georgia,serif;max-width:800px;margin:40px auto;color:#111;line-height:1.7}
      h1{color:#d13a97}h2{border-bottom:2px solid #eee;padding-bottom:8px}
      code{background:#f5f5f5;padding:2px 6px;border-radius:4px;font-size:13px}
      pre{background:#1a1a1a;color:#00ff88;padding:16px;border-radius:8px;overflow:auto}
      </style></head><body>${renderMarkdown(viewNote?.generated_content || content)}</body></html>
    `)
    win.document.close()
    win.print()
  }

  return (
    <div>
       <div className="mb-1">
      <h1 className="font-serif text-2xl font-semibold">Notes Generator</h1>
        <p className="text-muted text-sm mt-1">Enter a topic — Mizu's brain does the rest</p>
      </div>

      {/* Tabs */}
      <div className="flex gap-1 mb-8 p-1 rounded-xl w-fit" style={{ background: '#1a1a1a', border: '1px solid #2e2e2e' }}>
        {['generate','saved'].map(t => (
          <button key={t} onClick={() => setTab(t)}
            className={`px-5 py-2 rounded-lg text-sm font-medium capitalize transition-all ${tab === t ? 'bg-brand-grad text-white' : 'text-muted hover:text-white'}`}>
            {t === 'generate' ? '⚡ Generate' : `📚 Saved (${savedNotes.length})`}
          </button>
        ))}
      </div>

      {tab === 'generate' && (
        <div className="space-y-6">
          {/* Input */}
          <div className="glass-card p-6">
            <label className="block text-xs font-mono text-muted uppercase tracking-widest mb-3">Topic Name</label>
            <div className="flex gap-3">
              <input
                value={topic}
                onChange={e => { setTopic(e.target.value); setSaved(false) }}
                onKeyDown={e => e.key === 'Enter' && generate()}
                placeholder="e.g. Binary Search Trees, React Hooks, TCP/IP..."
                className="form-input flex-1"
              />
              <button onClick={generate} disabled={loading || !topic.trim()} className="btn-primary px-6 shrink-0 disabled:opacity-50 disabled:cursor-not-allowed">
                {loading ? (
                  <span className="flex items-center gap-2">
                    <span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"/>
                    Generating…
                  </span>
                ) : 'Generate Notes'}
              </button>
            </div>
            {error && <p className="text-danger text-sm mt-3">{error}</p>}
          </div>

          {/* Loading state */}
          {loading && (
            <div className="glass-card p-12 text-center">
              <div className="flex justify-center mb-4">
                <MizuCharacter mood="concerned" size={100} />
              </div>
              <p className="text-muted text-sm animate-pulse">Mizu is thinking hard about <strong className="text-white">{topic}</strong>…</p>
            </div>
          )}

          {/* Result */}
          {content && !loading && (
            <div className="glass-card p-6 animate-fadeup">
              <div className="flex items-center justify-between mb-5">
                <div>
                  <h2 className="font-serif text-lg font-semibold">{topic}</h2>
                  <p className="text-xs text-muted mt-0.5">Generated by Mizu AI</p>
                </div>
                <div className="flex gap-2">
                  <button onClick={saveNote} disabled={saving || saved}
                    className={`px-4 py-2 rounded-lg text-sm font-medium transition-all ${saved ? 'bg-teal/20 text-teal border border-teal/30' : 'btn-ghost'}`}>
                    {saved ? '✓ Saved' : saving ? 'Saving…' : '💾 Save'}
                  </button>
                  <button onClick={exportPDF} className="btn-ghost px-4 py-2 text-sm">
                    📄 Export PDF
                  </button>
                </div>
              </div>
              <div
                className="prose-custom leading-relaxed text-[#aaaaaa]"
                dangerouslySetInnerHTML={{ __html: renderMarkdown(content) }}
              />
            </div>
          )}

          {!content && !loading && (
            <div className="glass-card p-16 text-center">
              <div className="text-5xl mb-4">📝</div>
              <p className="text-muted font-medium">Enter a topic above and hit Generate</p>
              <p className="text-muted2 text-sm mt-2">Mizu will create structured notes with explanations, code examples, and summaries</p>
            </div>
          )}
        </div>
      )}

      {tab === 'saved' && (
        <div>
          {viewNote ? (
            <div className="glass-card p-6 animate-fadeup">
              <div className="flex items-center justify-between mb-5">
                <div>
                  <button onClick={() => setViewNote(null)} className="text-muted text-sm hover:text-white transition mb-2">← Back to list</button>
                  <h2 className="font-serif text-xl font-semibold">{viewNote.topic_name}</h2>
                  <p className="text-xs text-muted mt-1">{new Date(viewNote.created_at).toLocaleDateString()}</p>
                </div>
                <div className="flex gap-2">
                  <button onClick={exportPDF} className="btn-ghost px-4 py-2 text-sm">📄 Export PDF</button>
                  <button onClick={() => deleteNote(viewNote.id)} className="px-4 py-2 rounded-lg text-sm text-danger border border-danger/30 hover:bg-danger/10 transition-all">🗑 Delete</button>
                </div>
              </div>
              <div className="leading-relaxed text-[#aaaaaa]"
                dangerouslySetInnerHTML={{ __html: renderMarkdown(viewNote.generated_content) }} />
            </div>
          ) : (
            <div>
              {savedNotes.length === 0 ? (
                <div className="glass-card p-16 text-center">
                  <div className="text-4xl mb-4">📭</div>
                  <p className="text-muted">No saved notes yet</p>
                  <p className="text-muted2 text-sm mt-2">Generate some notes and save them for later</p>
                </div>
              ) : (
                <div className="grid gap-3">
                  {savedNotes.map(note => (
                    <div key={note.id} className="glass-card p-5 flex items-center justify-between group hover:border-accent/30 transition-all cursor-pointer" onClick={() => openNote(note.id)}>
                      <div>
                        <h3 className="font-medium text-white group-hover:text-accent transition-colors">{note.topic_name}</h3>
                        <p className="text-xs text-muted mt-1">{new Date(note.created_at).toLocaleDateString('en-US', { year:'numeric', month:'short', day:'numeric' })}</p>
                      </div>
                      <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button onClick={e => { e.stopPropagation(); openNote(note.id) }} className="px-3 py-1.5 rounded-lg text-xs bg-accent/10 text-accent border border-accent/20 hover:bg-accent/20">Open</button>
                        <button onClick={e => { e.stopPropagation(); deleteNote(note.id) }} className="px-3 py-1.5 rounded-lg text-xs text-danger border border-danger/20 hover:bg-danger/10">Delete</button>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}
        </div>
      )}
    </div>
  )
}
