import { useState } from 'react'
import { useSearchParams } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import api from '../api/client'

type Mode = 'main' | 'login' | 'register'

export default function Login() {
  const { t, i18n } = useTranslation()
  const [mode, setMode] = useState<Mode>('main')
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [passwordConfirm, setPasswordConfirm] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const [searchParams] = useSearchParams()

  const pendingVerification = searchParams.get('verified') === 'pending'
  const pendingEmail = searchParams.get('email')

  const changeLanguage = (lang: string) => {
    i18n.changeLanguage(lang)
    localStorage.setItem('language', lang)
  }

  const handleGoogle = () => {
    window.location.href = 'https://clue-the-twins-project-production.up.railway.app/auth/google'
  }

  const handleGitHub = () => {
    window.location.href = 'https://clue-the-twins-project-production.up.railway.app/auth/github'
  }

  const handleLogin = async () => {
    if (!email.trim() || !password.trim()) {
      setError(t('login.errorFields'))
      return
    }
    setLoading(true)
    try {
      const res = await api.post('/auth/login', { email, password })
      const { token, player_id } = res.data
      window.location.href = `/game?token=${token}&player_id=${player_id}`
    } catch (e: any) {
      setError(e.response?.data?.error ?? t('login.errorLogin'))
    } finally {
      setLoading(false)
    }
  }

  const handleRegister = async () => {
    if (!name.trim() || !email.trim() || !password.trim()) {
      setError(t('login.errorFields'))
      return
    }
    if (password !== passwordConfirm) {
      setError(t('login.errorPasswords'))
      return
    }
    if (password.length < 6) {
      setError(t('login.errorPassword6'))
      return
    }
    setLoading(true)
    try {
      const form = document.createElement('form')
      form.method = 'POST'
      form.action = 'https://clue-the-twins-project-production.up.railway.app/auth/register'
      const fields = { name, email, password, password_confirmation: passwordConfirm }
      Object.entries(fields).forEach(([k, v]) => {
        const input = document.createElement('input')
        input.type = 'hidden'
        input.name = k
        input.value = v
        form.appendChild(input)
      })
      document.body.appendChild(form)
      form.submit()
    } catch (e) {
      setError('Error al registrarse.')
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-black flex items-center justify-center">
      <div
        className="absolute inset-0 bg-cover bg-center opacity-30"
        style={{ backgroundImage: "url('/images/portada.jpg')" }}
      />

      <div className="relative z-10 flex flex-col items-center gap-6 p-10 rounded-2xl border border-white/10 bg-black/60 backdrop-blur-sm w-full max-w-sm">

        {/* Selector de idioma */}
        <div className="flex gap-2 self-end">
          <button
            onClick={() => changeLanguage('es')}
            className={`px-3 py-1 text-xs rounded border transition ${
              i18n.language === 'es'
                ? 'border-white text-white bg-white/10'
                : 'border-white/20 text-white/40 hover:border-white/40'
            }`}
          >
            🇪🇸 ES
          </button>
          <button
            onClick={() => changeLanguage('en')}
            className={`px-3 py-1 text-xs rounded border transition ${
              i18n.language === 'en'
                ? 'border-white text-white bg-white/10'
                : 'border-white/20 text-white/40 hover:border-white/40'
            }`}
          >
            🇬🇧 EN
          </button>
        </div>

        <h1 className="text-white text-3xl font-bold tracking-widest uppercase">{t('login.title')}</h1>
        <p className="text-white/50 text-sm text-center">{t('login.subtitle')}</p>

        {pendingVerification && (
          <div className="w-full bg-white/5 border border-white/10 rounded-lg px-4 py-3 text-center">
            <p className="text-white text-sm">{t('login.checkEmail')}</p>
            <p className="text-white/50 text-xs mt-1">
              {t('login.verificationSent')} <span className="text-white/70">{pendingEmail}</span>
            </p>
          </div>
        )}

        {mode === 'main' && (
          <div className="flex flex-col gap-3 w-full mt-4">
            <button
              onClick={handleGoogle}
              className="flex items-center justify-center gap-3 w-full py-3 rounded-lg bg-white text-black font-semibold hover:bg-white/90 transition"
            >
              <img src="https://www.svgrepo.com/show/475656/google-color.svg" className="w-5 h-5" />
              {t('login.google')}
            </button>

            <button
              onClick={handleGitHub}
              className="flex items-center justify-center gap-3 w-full py-3 rounded-lg bg-[#24292e] text-white font-semibold hover:bg-[#24292e]/80 transition"
            >
              <img src="https://www.svgrepo.com/show/512317/github-142.svg" className="w-5 h-5 invert" />
              {t('login.github')}
            </button>

            <div className="flex items-center gap-3 my-1">
              <div className="flex-1 h-px bg-white/10" />
              <span className="text-white/30 text-xs">o</span>
              <div className="flex-1 h-px bg-white/10" />
            </div>

            <button
              onClick={() => { setMode('register'); setError('') }}
              className="w-full py-3 rounded-lg bg-white/10 border border-white/20 text-white text-sm font-semibold hover:bg-white/20 transition"
            >
              {t('login.createAccount')}
            </button>

            <button
              onClick={() => { setMode('login'); setError('') }}
              className="w-full py-2 text-white/40 text-xs hover:text-white/60 transition"
            >
              {t('login.alreadyHave')}
            </button>
          </div>
        )}

        {mode === 'login' && (
          <div className="flex flex-col gap-3 w-full mt-2">
            <p className="text-white/50 text-xs text-center">{t('login.loginTitle')}</p>

            <input
              type="email"
              placeholder={t('login.email')}
              value={email}
              onChange={e => { setEmail(e.target.value); setError('') }}
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/30 outline-none focus:border-white/50 transition text-sm"
            />

            <input
              type="password"
              placeholder={t('login.password')}
              value={password}
              onChange={e => { setPassword(e.target.value); setError('') }}
              onKeyDown={e => e.key === 'Enter' && handleLogin()}
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/30 outline-none focus:border-white/50 transition text-sm"
            />

            {error && <p className="text-red-400 text-xs">{error}</p>}

            <button
              onClick={handleLogin}
              disabled={loading}
              className="w-full py-3 rounded-lg bg-white/10 border border-white/20 text-white text-sm hover:bg-white/20 transition disabled:opacity-50"
            >
              {loading ? t('login.entering') : t('login.enterGuest')}
            </button>

            <button
              onClick={() => { setMode('main'); setError('') }}
              className="text-white/30 text-xs hover:text-white/50 transition text-center"
            >
              {t('login.back')}
            </button>
          </div>
        )}

        {mode === 'register' && (
          <div className="flex flex-col gap-3 w-full mt-2">
            <p className="text-white/50 text-xs text-center">{t('login.createAccountTitle')}</p>

            <input
              type="text"
              placeholder={t('login.name')}
              value={name}
              onChange={e => { setName(e.target.value); setError('') }}
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/30 outline-none focus:border-white/50 transition text-sm"
            />

            <input
              type="email"
              placeholder={t('login.email')}
              value={email}
              onChange={e => { setEmail(e.target.value); setError('') }}
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/30 outline-none focus:border-white/50 transition text-sm"
            />

            <input
              type="password"
              placeholder={t('login.password')}
              value={password}
              onChange={e => { setPassword(e.target.value); setError('') }}
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/30 outline-none focus:border-white/50 transition text-sm"
            />

            <input
              type="password"
              placeholder={t('login.confirmPassword')}
              value={passwordConfirm}
              onChange={e => { setPasswordConfirm(e.target.value); setError('') }}
              onKeyDown={e => e.key === 'Enter' && handleRegister()}
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/30 outline-none focus:border-white/50 transition text-sm"
            />

            {error && <p className="text-red-400 text-xs">{error}</p>}

            <button
              onClick={handleRegister}
              disabled={loading}
              className="w-full py-3 rounded-lg bg-white/10 border border-white/20 text-white text-sm hover:bg-white/20 transition disabled:opacity-50"
            >
              {loading ? t('login.creating') : t('login.createAccount')}
            </button>

            <button
              onClick={() => { setMode('main'); setError('') }}
              className="text-white/30 text-xs hover:text-white/50 transition text-center"
            >
              {t('login.back')}
            </button>
          </div>
        )}
      </div>
    </div>
  )
}