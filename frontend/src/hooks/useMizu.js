// useMizu.js — custom hook
// Any component can call mizuReact(trigger, data) to make Mizu speak.
// MizuFloat subscribes to the same event bus to receive and display the line.
//
// Architecture: a tiny in-memory event emitter on window.__mizuBus
// This avoids prop-drilling through the entire component tree.

// ─── Event bus (initialised once) ────────────────────────────────────────────
if (typeof window !== 'undefined' && !window.__mizuBus) {
  window.__mizuBus = {
    _listeners: [],
    emit(event) {
      this._listeners.forEach(fn => fn(event))
    },
    on(fn) {
      this._listeners.push(fn)
      return () => { this._listeners = this._listeners.filter(f => f !== fn) }
    },
  }
}

// ─── mizuReact: call this from anywhere ──────────────────────────────────────
// trigger: string key (eval_result, notes_generated, tab_switch, idle_short, etc.)
// data:    object with context (scores, topic, tab, etc.)
export async function mizuReact(trigger, data = {}) {
  try {
    const token = localStorage.getItem('reflectai_token')
    if (!token) return

    const res = await fetch('/api/mizu/react', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`,
      },
      body: JSON.stringify({ trigger, data }),
    })

    if (!res.ok) return
    const { line } = await res.json()
    if (!line) return

    // Determine mood from trigger
    const moodMap = {
      eval_result:    data.avg >= 70 ? 'impressed' : data.avg >= 40 ? 'concerned' : 'judgy',
      notes_generated: 'encouraging',
      tab_switch:     'idle',
      idle_short:     'concerned',
      idle_long:      'judgy',
      typing_active:  'encouraging',
      typing_stopped: 'concerned',
    }
    const mood = moodMap[trigger] || 'idle'

    // Emit to MizuFloat
    if (window.__mizuBus) {
      window.__mizuBus.emit({ line, mood, trigger })
    }

  } catch (err) {
    // Silent fail — never break the app over a Mizu line
    console.warn('Mizu react failed silently:', err.message)
  }
}

// ─── useMizuListener: used inside MizuFloat to receive events ────────────────
import { useEffect } from 'react'

export function useMizuListener(callback) {
  useEffect(() => {
    if (!window.__mizuBus) return
    const unsub = window.__mizuBus.on(callback)
    return unsub
  }, [callback])
}
