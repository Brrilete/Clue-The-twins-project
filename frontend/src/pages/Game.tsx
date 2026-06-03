import { useState, useEffect, useRef } from 'react'
import { useSearchParams } from 'react-router-dom'
import TypeWriter from '../components/TypeWriter'
import { useGameStore } from '../store/gameStore'
import api from '../api/client'
import Blackjack from '../components/Blackjack'

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

interface Item {
    id: number
    name: string
    description: string
}

function getItemIcon(id: number): string {
    const icons: Record<number, string> = {
        1: '📄',
        2: '🔫',
        3: '✈️',
        4: '📸',
        5: '🗝️',
        6: '🧾',
        7: '📝',
    }
    return icons[id] ?? '📦'
}

export default function Game() {
    const { sceneImage, setScene } = useGameStore()
    const [messages, setMessages] = useState<Message[]>([])
    const [typingDone, setTypingDone] = useState(false)
    const [input, setInput] = useState('')
    const [loading, setLoading] = useState(false)
    const [player, setPlayer] = useState<Player | null>(null)
    const [fastMode, setFastMode] = useState(false)
    const [showInventory, setShowInventory] = useState(false)
    const [showBlackjack, setShowBlackjack] = useState(false)
    const [inventory, setInventory] = useState<Item[]>([])
    const [selectedItem, setSelectedItem] = useState<Item | null>(null)
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

    const loadInventory = async () => {
        try {
            const res = await api.get(`/player/${playerId}/inventory`)
            setInventory(res.data.items)
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

            // Activar blackjack si la acción es jugar en escena 13
            if (data.action === 'jugar' && player?.location_scene_id === 13) {
                setMessages(prev => [...prev, { text: data.text, isPlayer: false }])
                setTimeout(() => setShowBlackjack(true), fastMode ? 100 : data.text.length * 15 + 500)
                setLoading(false)
                return
            }

            if (data.next_scene) {
                if (data.text && data.text.trim() !== '') {
                    setMessages(prev => [...prev, { text: data.text, isPlayer: false }])
                }
                setTimeout(async () => {
                    const sceneRes = await api.get(`/scene/${data.next_scene}/text/${playerId}`)
                    setMessages(prev => [...prev, { text: sceneRes.data.text, isPlayer: false }])
                    setScene(sceneRes.data.text, sceneRes.data.image_url)
                    // Actualizar player con nueva escena
                    setPlayer(prev => prev ? { ...prev, location_scene_id: data.next_scene } : prev)
                }, data.text?.trim() ? data.text.length * 15 + 1000 : 100)
            } else {
                setMessages(prev => [...prev, { text: data.text, isPlayer: false }])
                setScene(data.text, sceneImage)
            }

            // Actualizar datos del jugador
            if (data.player) {
                setPlayer(data.player)
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

            {/* Botones admin */}
            {(player?.role === 'admin' || player?.role === 'advanced') && (
                <div className="fixed top-4 right-4 z-50 flex gap-2">
                    <button
                        onClick={() => setFastMode(f => !f)}
                        className={`px-3 py-2 text-xs border rounded-lg transition ${
                            fastMode
                                ? 'text-white border-white/40 bg-white/10'
                                : 'text-white/30 border-white/10 hover:text-white/60 hover:border-white/30'
                        }`}
                    >
                        ⚡ {fastMode ? 'Rápido ON' : 'Rápido OFF'}
                    </button>
                    <button
                        onClick={handleReset}
                        className="px-3 py-2 text-xs text-white/30 border border-white/10 rounded-lg hover:text-white/60 hover:border-white/30 transition"
                    >
                        Reiniciar
                    </button>
                </div>
            )}

            {/* Botón inventario */}
            <button
                onClick={() => { setShowInventory(v => !v); loadInventory(); setSelectedItem(null) }}
                className="fixed bottom-6 left-4 z-50 w-12 h-12 flex items-center justify-center bg-black/60 border border-white/20 rounded-full hover:bg-white/10 transition text-2xl"
                title="Inventario"
            >
                🎒
            </button>

            {/* Ventana inventario */}
            {showInventory && (
                <div className="fixed bottom-24 left-4 z-50 w-80 bg-black/95 border border-white/20 rounded-xl overflow-hidden shadow-2xl">
                    <div className="flex items-center justify-between px-4 py-3 border-b border-white/10">
                        <span className="text-white font-mono text-sm font-bold">🎒 Inventario</span>
                        <button
                            onClick={() => setShowInventory(false)}
                            className="text-white/40 hover:text-white transition text-sm"
                        >
                            ✕
                        </button>
                    </div>
                    <div className="flex h-52">
                        <div className="w-1/2 border-r border-white/10 overflow-y-auto">
                            {inventory.length === 0 ? (
                                <p className="text-white/30 text-xs p-4 font-mono text-center mt-4">
                                    Sin objetos
                                </p>
                            ) : (
                                inventory.map(item => (
                                    <button
                                        key={item.id}
                                        onClick={() => setSelectedItem(item)}
                                        className={`w-full flex flex-col items-center gap-1 p-3 hover:bg-white/10 transition border-b border-white/5 ${
                                            selectedItem?.id === item.id ? 'bg-white/10' : ''
                                        }`}
                                    >
                                        <span className="text-2xl">{getItemIcon(item.id)}</span>
                                        <span className="text-white/60 text-xs font-mono text-center leading-tight">
                                            {item.name}
                                        </span>
                                    </button>
                                ))
                            )}
                        </div>
                        <div className="w-1/2 p-3 flex flex-col">
                            {selectedItem ? (
                                <>
                                    <p className="text-3xl mb-2 text-center">{getItemIcon(selectedItem.id)}</p>
                                    <p className="text-white font-mono text-xs font-bold mb-2">{selectedItem.name}</p>
                                    <p className="text-white/60 font-mono text-xs leading-relaxed">{selectedItem.description}</p>
                                </>
                            ) : (
                                <p className="text-white/20 font-mono text-xs mt-4 text-center">
                                    Pulsa un objeto para ver su descripción
                                </p>
                            )}
                        </div>
                    </div>
                </div>
            )}

            {/* Blackjack */}
            {showBlackjack && (
                <Blackjack
                    playerId={playerId}
                    onClose={() => {
                        setShowBlackjack(false)
                        setTypingDone(true)
                    }}
                    onResult={(msg) => {
                        setShowBlackjack(false)
                        setTypingDone(false)
                        setMessages(prev => [...prev, { text: msg, isPlayer: false }])
                    }}
                />
            )}

            {/* Contenido scrolleable */}
            <div className="relative z-10 max-w-2xl mx-auto w-full px-6 py-12 min-h-screen flex flex-col">
                <div className="flex-1 flex flex-col gap-6">
                    {messages.map((msg, i) => (
                        <div key={i}>
                            {msg.isPlayer ? (
                                <p className="text-white/40 font-mono text-sm">{msg.text}</p>
                            ) : i === messages.length - 1 && !typingDone ? (
                                fastMode ? (
                                    <p
                                        className="text-white font-mono text-lg leading-8 whitespace-pre-wrap"
                                        ref={el => { if (el) setTypingDone(true) }}
                                    >
                                        {msg.text}
                                    </p>
                                ) : (
                                    <TypeWriter
                                        text={msg.text}
                                        onDone={() => setTypingDone(true)}
                                    />
                                )
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