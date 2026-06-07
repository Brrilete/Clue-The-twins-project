interface Props {
    fastMode: boolean
    onToggleFast: () => void
    onReset: () => void
}

export default function AdminControls({ fastMode, onToggleFast, onReset }: Props) {
    return (
        <div className="fixed top-4 right-4 z-50 flex gap-2">
            <button
                onClick={onToggleFast}
                className={`px-3 py-2 text-xs border rounded-lg transition ${
                    fastMode
                        ? 'text-white border-white/40 bg-white/10'
                        : 'text-white/30 border-white/10 hover:text-white/60 hover:border-white/30'
                }`}
            >
                ⚡ {fastMode ? 'Rápido ON' : 'Rápido OFF'}
            </button>
            <button
                onClick={onReset}
                className="px-3 py-2 text-xs text-white/30 border border-white/10 rounded-lg hover:text-white/60 hover:border-white/30 transition"
            >
                Reiniciar
            </button>
        </div>
    )
}
