import { useState, useEffect } from 'react'
import { useSearchParams } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { useGameStore } from '../store/gameStore'
import api from '../api/client'
import GameBackground from '../components/GameBackground'
import CharacterAvatar from '../components/CharacterAvatar'
import AdminControls from '../components/AdminControls'
import GameInput from '../components/GameInput'
import MessageList from '../components/MessageList'
import Inventory from '../components/Inventory'
import Blackjack from '../components/Blackjack'

interface Message {
    text: string
    isPlayer: boolean
    character?: string
}

interface Player {
    id: number
    name: string
    sanity: number
    suspicion: number
    location_scene_id: number
    role: 'user' | 'advanced' | 'admin'
    language?: string
}

interface Item {
    id: number
    name: string
    description: string
}

export default function Game() {
    const { sceneImage, setScene } = useGameStore()
    const { i18n } = useTranslation()
    const [messages, setMessages] = useState<Message[]>([])
    const [typingDone, setTypingDone] = useState(false)
    const [input, setInput] = useState('')
    const [loading, setLoading] = useState(false)
    const [player, setPlayer] = useState<Player | null>(null)
    const [fastMode, setFastMode] = useState(false)
    const [showInventory, setShowInventory] = useState(false)
    const [showBlackjack, setShowBlackjack] = useState(false)
    const [inventory, setInventory] = useState<Item[]>([])
    const [currentCharacter, setCurrentCharacter] = useState<string | null>(null)
    const [characterAvatars, setCharacterAvatars] = useState<Record<string, string>>({})
    const [searchParams] = useSearchParams()

    const playerId = searchParams.get('player_id') ?? '1'

    useEffect(() => {
        const loadCharacters = async () => {
            try {
                const res = await api.get('/characters')
                setCharacterAvatars(res.data)
            } catch (e) { console.error(e) }
        }

        const loadHistory = async () => {
            try {
                const res = await api.get(`/player/${playerId}/history`)
                const data = res.data

                if (data.player) {
                    setPlayer(data.player)

                    // Sincronizar idioma del jugador
                    if (data.player.language) {
                        i18n.changeLanguage(data.player.language)
                        localStorage.setItem('language', data.player.language)
                    }

                    // Restaurar imagen de la escena actual
                    try {
                        const sceneRes = await api.get(`/scene/${data.player.location_scene_id}/text/${playerId}`)
                        if (sceneRes.data.image_url) {
                            setScene('', sceneRes.data.image_url)
                        }
                    } catch (e) { console.error(e) }
                }

                if (data.messages?.length > 0) {
                    setMessages(data.messages)
                    setTypingDone(true)
                    const lastMsg = data.messages[data.messages.length - 1]
                    if (!lastMsg.isPlayer && lastMsg.character) setCurrentCharacter(lastMsg.character)
                } else {
                    loadScene(1)
                }
            } catch (e) { loadScene(1) }
        }

        loadCharacters()
        loadHistory()
    }, [])

    const loadScene = async (sceneId: number) => {
        try {
            const res = await api.get(`/scene/${sceneId}/text/${playerId}`)
            setScene(res.data.text, res.data.image_url)
            setTypingDone(false)
            setCurrentCharacter(res.data.character ?? null)
            setMessages(prev => [...prev, {
                text: res.data.text,
                isPlayer: false,
                character: res.data.character ?? undefined
            }])
        } catch (e) { console.error(e) }
    }

    const loadInventory = async () => {
        try {
            const res = await api.get(`/player/${playerId}/inventory`)
            setInventory(res.data.items)
        } catch (e) { console.error(e) }
    }

    const handleLanguageChange = async (lang: string) => {
        i18n.changeLanguage(lang)
        localStorage.setItem('language', lang)
        try {
            await api.post(`/player/${playerId}/language`, { language: lang })
            window.location.reload()
        } catch (e) { console.error(e) }
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

            setCurrentCharacter(data.character ?? null)

            if (data.action === 'jugar' && player?.location_scene_id === 13) {
                setMessages(prev => [...prev, { text: data.text, isPlayer: false, character: data.character }])
                setTimeout(() => setShowBlackjack(true), fastMode ? 100 : data.text.length * 15 + 500)
                setLoading(false)
                return
            }

            if (data.next_scene) {
                if (data.text?.trim()) {
                    setMessages(prev => [...prev, { text: data.text, isPlayer: false, character: data.character }])
                }
                setTimeout(async () => {
                    const sceneRes = await api.get(`/scene/${data.next_scene}/text/${playerId}`)
                    setMessages(prev => [...prev, {
                        text: sceneRes.data.text,
                        isPlayer: false,
                        character: sceneRes.data.character ?? undefined
                    }])
                    setScene(sceneRes.data.text, sceneRes.data.image_url)
                    setCurrentCharacter(sceneRes.data.character ?? null)
                    setPlayer(prev => prev ? { ...prev, location_scene_id: data.next_scene } : prev)
                }, data.text?.trim() ? data.text.length * 15 + 1000 : 100)
            } else {
                setMessages(prev => [...prev, { text: data.text, isPlayer: false, character: data.character }])
                setScene(data.text, sceneImage)
            }

            if (data.player) setPlayer(data.player)

        } catch (e) { console.error(e) }
        finally { setLoading(false) }
    }

    const handleReset = async () => {
        if (!confirm('¿Resetear tu historia? Perderás todo el progreso.')) return
        try {
            await api.post(`/player/${playerId}/reset`, { requester_id: parseInt(playerId) })
            window.location.reload()
        } catch (e) { console.error(e) }
    }

    const lastNarratorMessage = [...messages].reverse().find(m => !m.isPlayer)
    const avatarToShow = lastNarratorMessage?.character ?? currentCharacter

    return (
        <div className="min-h-screen bg-black relative">
            <GameBackground sceneImage={sceneImage} />

            <CharacterAvatar avatarToShow={avatarToShow} characterAvatars={characterAvatars} />

            {/* Selector de idioma */}
            <div className="fixed top-4 left-4 z-50 flex gap-2">
                <button
                    onClick={() => handleLanguageChange('es')}
                    className={`px-3 py-1 text-xs rounded border transition ${
                        i18n.language === 'es'
                            ? 'border-white text-white bg-white/10'
                            : 'border-white/20 text-white/40 hover:border-white/40'
                    }`}
                >
                    🇪🇸
                </button>
                <button
                    onClick={() => handleLanguageChange('en')}
                    className={`px-3 py-1 text-xs rounded border transition ${
                        i18n.language === 'en'
                            ? 'border-white text-white bg-white/10'
                            : 'border-white/20 text-white/40 hover:border-white/40'
                    }`}
                >
                    🇬🇧
                </button>
            </div>

            {(player?.role === 'admin' || player?.role === 'advanced') && (
                <AdminControls
                    fastMode={fastMode}
                    onToggleFast={() => setFastMode(f => !f)}
                    onReset={handleReset}
                />
            )}

            <button
                onClick={() => { setShowInventory(v => !v); loadInventory() }}
                className="fixed bottom-6 left-4 z-50 w-12 h-12 flex items-center justify-center bg-black/60 border border-white/20 rounded-full hover:bg-white/10 transition text-2xl"
                title="Inventario"
            >
                🎒
            </button>

            {showInventory && (
                <Inventory inventory={inventory} onClose={() => setShowInventory(false)} />
            )}

            {showBlackjack && (
                <Blackjack
                    playerId={playerId}
                    onClose={() => { setShowBlackjack(false); setTypingDone(true) }}
                    onResult={(msg) => {
                        setShowBlackjack(false)
                        setTypingDone(false)
                        setMessages(prev => [...prev, { text: msg, isPlayer: false }])
                    }}
                />
            )}

            <div className="relative z-10 max-w-2xl mx-auto w-full px-6 py-12 min-h-screen flex flex-col">
                <MessageList
                    messages={messages}
                    typingDone={typingDone}
                    fastMode={fastMode}
                    onTypingDone={() => setTypingDone(true)}
                />

                {typingDone && (
                    <GameInput
                        input={input}
                        loading={loading}
                        onChange={setInput}
                        onSend={handleSend}
                    />
                )}
            </div>
        </div>
    )
}