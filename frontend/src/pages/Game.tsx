import { useState, useEffect, useRef } from 'react'
import { useSearchParams } from 'react-router-dom'
import TypeWriter from '../components/TypeWriter'
import { useGameStore } from '../store/gameStore'
import api from '../api/client'

interface Message {
    text: string
    isPlayer: boolean
}

interface Player {
    id: number
    name: string
    sanity: number
    suspicion: number
    location_scene_id: number
    role: 'user' | 'advanced' | 'admin'
}

export default function Game() {
    const { sceneImage, setScene } = useGameStore()
    const [messages, setMessages] = useState<Message[]>([])
    const [typingDone, setTypingDone] = useState(false)
    const [input, setInput] = useState('')
    const [loading, setLoading] = useState(false)
    const [player, setPlayer] = useState<Player | null>(null)
    const [searchParams] = useSearchParams()
    const bottomRef = useRef<HTMLDivElement>(null)

    const playerId = searchParams.get('player_id') ?? '1'

    useEffect(() => {
        const loadHistory = async () => {
            try {
                const res = await api.get(`/player/${playerId}/history`)
                const data = res.data

                if (data.player) {
                    setPlayer(data.player)
                }

                if (data.messages && data.messages.length > 0) {
                    setMessages(data.messages)
                    setTypingDone(true)
                } else {
                    loadScene(1)
                }
            } catch (e) {
                loadScene(1)
            }
        }

        loadHistory()
    }, [])

    useEffect(() => {
        bottomRef.current?.scrollIntoView({ behavior: 'smooth' })
    }, [messages])

    const loadScene = async (sceneId: number) => {
        try {
            const res = await api.get(`/scene/${sceneId}/text/${playerId}`)
            setScene(res.data.text, res.data.image_url)
            setTypingDone(false)
            setMessages(prev => [...prev, { text: res.data.text, isPlayer: false }])
        } catch (e) {
            console.error(e)
        }
    }

    const handleSend = async () => {
        if (!input.trim() || loading) return
        setLoading(true)
        setTypingDone(false)

        const playerText = input
        setInput('')

        setMessages(prev => [...prev, { text: `> ${playerText}`, isPlayer: true }])

        try {
            const res = await api.post('/game/play', {
                player_id: parseInt(playerId),
                text: playerText,
            })
            const data = res.data

            if (data.next_scene) {
                setMessages(prev => [...prev, { text: data.text, isPlayer: false }])
                setTimeout(async () => {
                    const sceneRes = await api.get(`/scene/${data.next_scene}/text/${playerId}`)
                    setMessages(prev => [...prev, { text: sceneRes.data.text, isPlayer: false }])
                    setScene(sceneRes.data.text, sceneRes.data.image_url)
                }, data.text.length * 15 + 1000)
            } else {
                setMessages(prev => [...prev, { text: data.text, isPlayer: false }])
                setScene(data.text, sceneImage)
            }
        } catch (e) {
            console.error(e)
        } finally {
            setLoading(false)
        }
    }

    const handleReset = async () => {
        if (!confirm('¿Resetear tu historia? Perderás todo el progreso.')) return
        try {
            await api.post(`/player/${playerId}/reset`, {
                requester_id: parseInt(playerId)
            })
            window.location.reload()
        } catch (e) {
            console.error(e)
        }
    }

    return (
        <div className="min-h-screen bg-black relative">
            {/* Imagen de fondo FIJA */}
            <div
                className="fixed inset-0 bg-cover bg-center"
                style={{
                    backgroundImage: sceneImage
                        ? `url(${sceneImage})`
                        : "url('https://images.unsplash.com/photo-1467269204594-9661b134dd2b?w=1920')",
                    filter: 'blur(3px) brightness(0.3)',
                    transform: 'scale(1.05)',
                }}
            />

            {/* Botón reset — solo admin y advanced */}
            {(player?.role === 'admin' || player?.role === 'advanced') && (
                <button
                    onClick={handleReset}
                    className="fixed top-4 right-4 z-50 px-3 py-2 text-xs text-white/30 border border-white/10 rounded-lg hover:text-white/60 hover:border-white/30 transition"
                >
                    Reiniciar historia
                </button>
            )}

            {/* Contenido scrolleable */}
            <div className="relative z-10 max-w-2xl mx-auto w-full px-6 py-12 min-h-screen flex flex-col">
                {/* Mensajes */}
                <div className="flex-1 flex flex-col gap-6">
                    {messages.map((msg, i) => (
                        <div key={i}>
                            {msg.isPlayer ? (
                                <p className="text-white/40 font-mono text-sm">{msg.text}</p>
                            ) : i === messages.length - 1 && !typingDone ? (
                                <TypeWriter
                                    text={msg.text}
                                    onDone={() => setTypingDone(true)}
                                />
                            ) : (
                                <p className="text-white font-mono text-lg leading-8 whitespace-pre-wrap">{msg.text}</p>
                            )}
                        </div>
                    ))}
                    <div ref={bottomRef} />
                </div>

                {/* Input */}
                {typingDone && (
                    <div className="sticky bottom-0 py-4 mt-8">
                        <div className="flex gap-3">
                            <input
                                type="text"
                                value={input}
                                onChange={(e) => setInput(e.target.value)}
                                onKeyDown={(e) => e.key === 'Enter' && handleSend()}
                                placeholder="¿Qué haces?"
                                disabled={loading}
                                className="flex-1 bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/30 outline-none focus:border-white/50 transition font-mono"
                            />
                            <button
                                onClick={handleSend}
                                disabled={loading}
                                className="px-6 py-3 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20 transition disabled:opacity-50"
                            >
                                {loading ? '...' : '→'}
                            </button>
                        </div>
                    </div>
                )}
            </div>
        </div>
    )
}