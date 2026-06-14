import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'

export default function Register() {
  const { register } = useAuth()
  const navigate     = useNavigate()

  const [form,    setForm]    = useState({ name: '', email: '', password: '' })
  const [error,   setError]   = useState('')
  const [loading, setLoading] = useState(false)

  const handle = (e) => setForm({ ...form, [e.target.name]: e.target.value })

  const submit = async (e) => {
    e.preventDefault()
    setError('')
    if (form.password.length < 6) {
      setError('Password must be at least 6 characters')
      return
    }
    setLoading(true)
    try {
      await register(form.name, form.email, form.password)
      navigate('/dashboard')
    } catch (err) {
      setError(err.response?.data?.error || 'Registration failed. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-bg flex items-center justify-center px-4">
      <div className="glass-card w-full max-w-md px-10 py-12">
        <div className="flex items-center gap-2 mb-8">
          <div className="w-2 h-2 rounded-full animate-pulse-dot"
               style={{ background: 'linear-gradient(135deg,#d13a97,#8b2fc9)', boxShadow: '0 0 10px #d13a97' }} />
          <span className="font-serif text-xl font-semibold">ReflectAI</span>
        </div>

        <h1 className="font-serif text-2xl font-semibold mb-1">Create account</h1>
        <p className="text-muted text-sm mb-8">Start your conceptual mastery journey</p>

        {error && (
          <div className="mb-5 px-4 py-3 rounded-lg bg-danger/10 border border-danger/25
                          text-sm text-red-400 font-medium">
            {error}
          </div>
        )}

        <form onSubmit={submit} className="space-y-4">
          <div>
            <label className="block text-xs font-medium text-muted uppercase tracking-wider mb-2">Full name</label>
            <input name="name" type="text" required value={form.name} onChange={handle}
                   placeholder="Your name" className="form-input" />
          </div>
          <div>
            <label className="block text-xs font-medium text-muted uppercase tracking-wider mb-2">Email address</label>
            <input name="email" type="email" required value={form.email} onChange={handle}
                   placeholder="you@example.com" className="form-input" />
          </div>
          <div>
            <label className="block text-xs font-medium text-muted uppercase tracking-wider mb-2">Password</label>
            <input name="password" type="password" required value={form.password} onChange={handle}
                   placeholder="Min. 6 characters" className="form-input" />
          </div>

          <button type="submit" disabled={loading}
                  className="btn-primary w-full py-3 text-sm mt-2 disabled:opacity-60">
            {loading ? 'Creating account...' : 'Create account →'}
          </button>
        </form>

        <p className="text-center text-muted text-sm mt-6">
          Already have an account?{' '}
          <Link to="/login" className="text-accent font-medium hover:underline">Sign in</Link>
        </p>
      </div>
    </div>
  )
}
