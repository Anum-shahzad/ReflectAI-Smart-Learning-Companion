import { useState, useEffect } from 'react'
import api from '../api/axios'

export default function History() {
  const [history, setHistory] = useState([])
  const [loading, setLoading] = useState(true)
  const [error,   setError]   = useState('')

  useEffect(() => {
    api.get('/evaluate/history')
      .then(({ data }) => setHistory(data.history))
      .catch(() => setError('Failed to load history'))
      .finally(() => setLoading(false))
  }, [])

  return (
    <div>
      <h1 className="font-serif text-2xl font-semibold mb-1">Evaluation History</h1>
      <p className="text-muted text-sm mb-8">Review your past submissions and track progress</p>

      {loading && (
        <div className="flex items-center gap-3 text-muted">
          <div className="w-5 h-5 border-2 border-border border-t-accent rounded-full animate-spin" />
          Loading...
        </div>
      )}

      {error && (
        <div className="px-4 py-3 rounded-lg bg-danger/10 border border-danger/25 text-red-400 text-sm">{error}</div>
      )}

      {!loading && !error && history.length === 0 && (
          <div className="glass-card p-16 text-center" data-mizu-perch="history-main">
          <div className="text-4xl mb-4">📭</div>
          <div className="text-muted font-medium">No evaluations yet</div>
          <div className="text-muted2 text-sm mt-1">Go to Evaluate to submit your first concept</div>
        </div>
      )}

      <div className="space-y-2.5">
        {history.map(item => {
          const avg = Math.round((item.accuracy_score + item.clarity_score + item.depth_score) / 3)
          const badgeCls = avg >= 80 ? 'text-teal bg-teal/10'
                         : avg >= 65 ? 'text-warn bg-warn/10'
                                     : 'text-danger bg-danger/10'
          return (
            <div key={item.id}
                 className="glass-card px-6 py-4 flex items-center justify-between
                            hover:border-muted2 transition-all duration-200 cursor-default">
              <div>
                <div className="font-semibold text-sm mb-1">{item.topic}</div>
                <div className="text-xs text-muted2 font-mono">
                  {new Date(item.created_at).toLocaleDateString('en-US', {
                    month: 'short', day: 'numeric', year: 'numeric'
                  })}
                </div>
              </div>
              <div className="flex items-center gap-4">
                <div className="flex gap-1.5 text-xs font-mono text-muted2">
                  <span title="Accuracy">{item.accuracy_score}</span>
                  <span>·</span>
                  <span title="Clarity">{item.clarity_score}</span>
                  <span>·</span>
                  <span title="Depth">{item.depth_score}</span>
                </div>
                <span className={`text-xs font-bold font-mono px-2.5 py-1 rounded-md ${badgeCls}`}>
                  Avg {avg}
                </span>
              </div>
            </div>
          )
        })}
      </div>
    </div>
  )
}
