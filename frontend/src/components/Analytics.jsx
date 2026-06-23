import { useState, useEffect, useRef } from 'react'
import api from '../api/axios'

function StatCard({ label, value, sub, color = '#d13a97' }) {
  return (
    <div className="glass-card p-5">
      <p className="text-xs font-mono text-muted uppercase tracking-widest mb-2">{label}</p>
      <div className="text-3xl font-bold mb-1" style={{ color }}>{value ?? '—'}</div>
      {sub && <p className="text-xs text-muted">{sub}</p>}
    </div>
  )
}

function MiniBar({ label, value, max = 100, color = '#d13a97' }) {
  return (
    <div className="mb-3">
      <div className="flex justify-between text-xs mb-1.5">
        <span className="text-muted">{label}</span>
        <span style={{ color }}>{value ?? 0}</span>
      </div>
      <div className="h-1.5 rounded-full" style={{ background: 'rgba(255,255,255,0.06)' }}>
        <div className="h-1.5 rounded-full transition-all duration-700"
          style={{ width: `${Math.min(100, ((value ?? 0) / max) * 100)}%`, background: color }} />
      </div>
    </div>
  )
}

function SparkLine({ data, color = '#d13a97', width = 200, height = 50 }) {
  if (!data || data.length < 2) return <div style={{ width, height }} className="flex items-center justify-center text-muted text-xs">Not enough data</div>

  const max = Math.max(...data)
  const min = Math.min(...data)
  const range = max - min || 1
  const pts = data.map((v, i) => {
    const x = (i / (data.length - 1)) * width
    const y = height - ((v - min) / range) * (height - 10) - 5
    return `${x},${y}`
  }).join(' ')

  return (
    <svg width={width} height={height} style={{ overflow: 'visible' }}>
      <defs>
        <linearGradient id="sparkGrad" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor={color} stopOpacity="0.3"/>
          <stop offset="100%" stopColor={color} stopOpacity="0"/>
        </linearGradient>
      </defs>
      <polyline fill="none" stroke={color} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" points={pts}/>
      {data.map((v, i) => {
        const x = (i / (data.length - 1)) * width
        const y = height - ((v - min) / range) * (height - 10) - 5
        return <circle key={i} cx={x} cy={y} r="3" fill={color}/>
      })}
    </svg>
  )
}

export default function Analytics() {
  const [data,    setData]    = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    api.get('/analytics').then(r => setData(r.data)).catch(() => {}).finally(() => setLoading(false))
  }, [])

  if (loading) return (
    <div className="flex items-center justify-center h-64">
      <div className="w-6 h-6 border-2 border-accent/30 border-t-accent rounded-full animate-spin"/>
    </div>
  )

  if (!data) return <div className="text-muted text-center py-20">Could not load analytics</div>

  const { evaluations, progress, quizzes, notes, activity } = data
  const trendScores = (evaluations.trend || []).map(t => Math.round((t.accuracy_score + t.clarity_score + t.depth_score) / 3))

  return (
    <div>
      <h1 className="font-serif text-2xl font-semibold mb-1">Analytics</h1>
      <p className="text-muted text-sm mb-8">Your complete learning dashboard</p>

      {/* Top stats */}
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8" data-mizu-perch="analytics-stats-row">
        <StatCard label="Evaluations" value={evaluations.total_evaluations} sub="Total attempts" color="#d13a97"/>
        <StatCard label="Lectures Done" value={progress.lectures_completed || 0} sub={`of ${progress.lectures_viewed || 0} viewed`} color="#00c896"/>
        <StatCard label="Quizzes Taken" value={quizzes.quizzes_taken || 0} sub={`Avg score: ${quizzes.avg_quiz_score || 0}%`} color="#f59e0b"/>
        <StatCard label="Notes Saved" value={notes.notes_count || 0} sub="Total notes" color="#8b2fc9"/>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
        {/* Score averages */}
         <div className="glass-card p-6" data-mizu-perch="analytics-scoretrend">
         <h2 className="font-semibold text-white mb-5">Average Scores</h2>
          {evaluations.total_evaluations > 0 ? (
            <>
              <MiniBar label="Accuracy" value={evaluations.avg_accuracy} color="#d13a97"/>
              <MiniBar label="Clarity"  value={evaluations.avg_clarity}  color="#8b2fc9"/>
              <MiniBar label="Depth"    value={evaluations.avg_depth}    color="#00c896"/>
              <div className="mt-4 pt-4 border-t border-border grid grid-cols-3 gap-4 text-center">
                {[['Best Acc', evaluations.best_accuracy, '#d13a97'],
                  ['Best Clarity', evaluations.best_clarity, '#8b2fc9'],
                  ['Best Depth', evaluations.best_depth, '#00c896']].map(([l,v,c]) => (
                  <div key={l}>
                    <div className="text-lg font-bold" style={{ color: c }}>{v}</div>
                    <div className="text-xs text-muted">{l}</div>
                  </div>
                ))}
              </div>
            </>
          ) : (
            <div className="text-center py-8 text-muted text-sm">No evaluations yet</div>
          )}
        </div>

        {/* Score trend */}
        <div className="glass-card p-6">
          <h2 className="font-semibold text-white mb-5">Score Trend</h2>
          {trendScores.length >= 2 ? (
            <div className="overflow-hidden">
              <SparkLine data={trendScores} color="#d13a97" width={340} height={80}/>
              <p className="text-xs text-muted mt-3">Last {trendScores.length} evaluations · overall score</p>
            </div>
          ) : (
            <div className="flex items-center justify-center h-24 text-muted text-sm">
              Need at least 2 evaluations to show trend
            </div>
          )}
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Top topics */}
        <div className="glass-card p-6">
          <h2 className="font-semibold text-white mb-5">Most Evaluated Topics</h2>
          {evaluations.topics?.length > 0 ? (
            <div className="space-y-3">
              {evaluations.topics.slice(0, 6).map((t, i) => (
                <div key={i} className="flex items-center gap-3">
                  <div className="w-6 h-6 rounded-full flex items-center justify-center text-xs font-mono"
                    style={{ background: 'rgba(209,58,151,0.1)', border: '1px solid rgba(209,58,151,0.3)', color: '#d13a97' }}>
                    {i+1}
                  </div>
                  <div className="flex-1">
                    <div className="flex justify-between text-sm mb-1">
                      <span className="text-white truncate pr-2">{t.topic}</span>
                      <span className="text-muted shrink-0">{t.attempts}×</span>
                    </div>
                    <div className="h-1 rounded-full bg-white/5">
                      <div className="h-1 rounded-full" style={{ width: `${t.avg_score}%`, background: 'linear-gradient(135deg,#d13a97,#8b2fc9)' }}/>
                    </div>
                  </div>
                  <span className="text-xs text-muted shrink-0">{t.avg_score}%</span>
                </div>
              ))}
            </div>
          ) : (
            <div className="text-center py-8 text-muted text-sm">No topics yet</div>
          )}
        </div>

        {/* Activity + quiz summary */}
        <div className="space-y-4">
           <div className="glass-card p-6" data-mizu-perch="analytics-weekly">
           <h2 className="font-semibold text-white mb-4">Weekly Activity</h2>
            {activity?.length > 0 ? (
              <div className="flex items-end gap-2 h-16">
                {activity.slice(-7).map((a, i) => {
                  const max = Math.max(...activity.map(x => x.count))
                  const pct = (a.count / max) * 100
                  return (
                    <div key={i} className="flex-1 flex flex-col items-center gap-1">
                      <div className="w-full rounded-sm transition-all" title={`${a.count} evaluations`}
                        style={{ height: `${Math.max(4, pct * 0.48)}px`, background: 'linear-gradient(135deg,#d13a97,#8b2fc9)', opacity: 0.7 + pct * 0.003 }}/>
                      <span className="text-[9px] text-muted">{new Date(a.day).toLocaleDateString('en', { weekday: 'short' }).slice(0,1)}</span>
                    </div>
                  )
                })}
              </div>
            ) : (
              <p className="text-muted text-sm text-center py-4">No activity this week</p>
            )}
          </div>

          <div className="glass-card p-6">
            <h2 className="font-semibold text-white mb-4">Quiz Performance</h2>
            {quizzes.quizzes_taken > 0 ? (
              <div className="space-y-3">
                <MiniBar label="Average Score" value={quizzes.avg_quiz_score} color="#f59e0b"/>
                <MiniBar label="Best Score"    value={quizzes.best_quiz_score} color="#00c896"/>
                <p className="text-xs text-muted mt-2">{quizzes.quizzes_taken} quiz{quizzes.quizzes_taken !== 1 ? 'zes' : ''} completed</p>
              </div>
            ) : (
              <p className="text-muted text-sm text-center py-2">No quizzes taken yet</p>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
