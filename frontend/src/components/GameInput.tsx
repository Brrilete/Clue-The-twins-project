interface Props {
    input: string
    loading: boolean
    onChange: (value: string) => void
    onSend: () => void
}

export default function GameInput({ input, loading, onChange, onSend }: Props) {
    return (
        <div className="sticky bottom-0 py-4 mt-8">
            <div className="flex gap-3">
                <input
                    type="text"
                    value={input}
                    onChange={(e) => onChange(e.target.value)}
                    onKeyDown={(e) => e.key === 'Enter' && onSend()}
                    placeholder="¿Qué haces?"
                    disabled={loading}
                    className="flex-1 bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/30 outline-none focus:border-white/50 transition font-mono"
                />
                <button
                    onClick={onSend}
                    disabled={loading}
                    className="px-6 py-3 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20 transition disabled:opacity-50"
                >
                    {loading ? '...' : '→'}
                </button>
            </div>
        </div>
    )
}
