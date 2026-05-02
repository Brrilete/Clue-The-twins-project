export default function Login() {
  const handleGoogle = () => {
    window.location.href = 'https://petroleum-blah-dinner.ngrok-free.dev/auth/google'
  }

  const handleGitHub = () => {
    window.location.href = 'https://petroleum-blah-dinner.ngrok-free.dev/auth/github'
  }

  const handleGuest = () => {
    window.location.href = 'https://petroleum-blah-dinner.ngrok-free.dev/auth/guest'
  }

  return (
    <div className="min-h-screen bg-black flex items-center justify-center">
      <div
        className="absolute inset-0 bg-cover bg-center opacity-30"
        style={{ backgroundImage: "url('/portada.jpg')" }} />

      <div className="relative z-10 flex flex-col items-center gap-6 p-10 rounded-2xl border border-white/10 bg-black/60 backdrop-blur-sm w-full max-w-sm">
        <h1 className="text-white text-3xl font-bold tracking-widest uppercase">Gemelos</h1>
        <p className="text-white/50 text-sm text-center">Un misterio te espera</p>

        <div className="flex flex-col gap-3 w-full mt-4">
          <button
            onClick={handleGoogle}
            className="flex items-center justify-center gap-3 w-full py-3 rounded-lg bg-white text-black font-semibold hover:bg-white/90 transition"
          >
            <img src="https://www.svgrepo.com/show/475656/google-color.svg" className="w-5 h-5" />
            Continuar con Google
          </button>

          <button
            onClick={handleGitHub}
            className="flex items-center justify-center gap-3 w-full py-3 rounded-lg bg-[#24292e] text-white font-semibold hover:bg-[#24292e]/80 transition"
          >
            <img src="https://www.svgrepo.com/show/512317/github-142.svg" className="w-5 h-5 invert" />
            Continuar con GitHub
          </button>

          <div className="flex items-center gap-3 my-1">
            <div className="flex-1 h-px bg-white/10" />
            <span className="text-white/30 text-xs">o</span>
            <div className="flex-1 h-px bg-white/10" />
          </div>

          <button
            onClick={handleGuest}
            className="w-full py-3 rounded-lg border border-white/20 text-white/60 text-sm hover:border-white/40 hover:text-white/80 transition"
          >
            Entrar como invitado
          </button>
        </div>
      </div>
    </div>
  )
}