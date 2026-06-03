import { useState } from 'react'
import api from '../api/client'

interface Card {
    suit: '♠' | '♥' | '♦' | '♣'
    value: string
    numericValue: number
}

interface Props {
    playerId: string
    onClose: () => void
    onResult: (message: string) => void
}

const SUITS: Card['suit'][] = ['♠', '♥', '♦', '♣']
const VALUES = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

function createDeck(): Card[] {
    const deck: Card[] = []
    for (const suit of SUITS) {
        for (const value of VALUES) {
            const numericValue = value === 'A' ? 11
                : ['J', 'Q', 'K'].includes(value) ? 10
                    : parseInt(value)
            deck.push({ suit, value, numericValue })
        }
    }
    return deck.sort(() => Math.random() - 0.5)
}

function getHandValue(hand: Card[]): number {
    let total = hand.reduce((sum, card) => sum + card.numericValue, 0)
    let aces = hand.filter(c => c.value === 'A').length
    while (total > 21 && aces > 0) {
        total -= 10
        aces--
    }
    return total
}

function CardComponent({ card, hidden = false, index = 0 }: { card: Card, hidden?: boolean, index?: number }) {
    const isRed = card.suit === '♥' || card.suit === '♦'

    const style = {
        animationDelay: `${index * 120}ms`,
    }

    if (hidden) {
        return (
            <div
                className="card-hidden"
                style={style}
            >
                <div className="card-back-pattern" />
            </div>
        )
    }

    return (
        <div className="card-face" style={style}>
            <div className={`card-corner top-left ${isRed ? 'red' : 'black'}`}>
                <span className="card-value">{card.value}</span>
                <span className="card-suit-small">{card.suit}</span>
            </div>
            <span className={`card-suit-center ${isRed ? 'red' : 'black'}`}>{card.suit}</span>
            <div className={`card-corner bottom-right ${isRed ? 'red' : 'black'}`}>
                <span className="card-value">{card.value}</span>
                <span className="card-suit-small">{card.suit}</span>
            </div>
        </div>
    )
}

export default function Blackjack({ playerId, onClose, onResult }: Props) {
    const [deck, setDeck] = useState<Card[]>([])
    const [playerHand, setPlayerHand] = useState<Card[]>([])
    const [dealerHand, setDealerHand] = useState<Card[]>([])
    const [gameState, setGameState] = useState<'betting' | 'playing' | 'dealer' | 'finished'>('betting')
    const [bet, setBet] = useState(10)
    const [chips, setChips] = useState(100)
    const [message, setMessage] = useState('')
    const [result, setResult] = useState<'win' | 'lose' | 'draw' | null>(null)
    const [, setLoading] = useState(false)

    const startGame = () => {
        if (bet > chips) return
        const newDeck = createDeck()
        const pHand = [newDeck[0], newDeck[2]]
        const dHand = [newDeck[1], newDeck[3]]
        setDeck(newDeck.slice(4))
        setPlayerHand(pHand)
        setDealerHand(dHand)
        setGameState('playing')
        setMessage('')
        setResult(null)

        if (getHandValue(pHand) === 21) {
            setMessage('¡Blackjack!')
            endGame('win', newDeck.slice(4), pHand, dHand, true)
        }
    }

    const hit = () => {
        const newCard = deck[0]
        const newHand = [...playerHand, newCard]
        const newDeck = deck.slice(1)
        setPlayerHand(newHand)
        setDeck(newDeck)

        const value = getHandValue(newHand)
        if (value > 21) {
            setMessage('Te has pasado de 21.')
            endGame('lose', newDeck, newHand, dealerHand)
        } else if (value === 21) {
            stand(newDeck, newHand)
        }
    }

    const stand = (currentDeck = deck, currentPlayerHand = playerHand) => {
        setGameState('dealer')
        let dHand = [...dealerHand]
        let d = currentDeck

        while (getHandValue(dHand) < 17) {
            dHand = [...dHand, d[0]]
            d = d.slice(1)
        }

        setDealerHand(dHand)
        setDeck(d)

        const playerVal = getHandValue(currentPlayerHand)
        const dealerVal = getHandValue(dHand)

        let r: 'win' | 'lose' | 'draw'
        if (dealerVal > 21 || playerVal > dealerVal) {
            r = 'win'
            setMessage(`Ganas — Tú: ${playerVal} · Banca: ${dealerVal}`)
        } else if (playerVal < dealerVal) {
            r = 'lose'
            setMessage(`Pierdes — Tú: ${playerVal} · Banca: ${dealerVal}`)
        } else {
            r = 'draw'
            setMessage(`Empate — Ambos: ${playerVal}`)
        }

        endGame(r, d, currentPlayerHand, dHand)
    }

    const endGame = async (
        r: 'win' | 'lose' | 'draw',
        _deck: Card[],
        _pHand: Card[],
        _dHand: Card[],
        isBlackjack = false
    ) => {
        setResult(r)
        setGameState('finished')

        const winnings = r === 'win' ? (isBlackjack ? Math.floor(bet * 2.5) : bet)
            : r === 'lose' ? -bet : 0
        setChips(prev => prev + winnings)

        setLoading(true)
        try {
            const res = await api.post('/game/minigame/result', {
                player_id: parseInt(playerId),
                game: 'blackjack',
                result: r,
                score: winnings,
            })
            if (res.data.message) {
                onResult(res.data.message)
            }
        } catch (e) {
            console.error(e)
        } finally {
            setLoading(false)
        }
    }

    const playerValue = getHandValue(playerHand)
    const dealerValue = gameState === 'finished' || gameState === 'dealer'
        ? getHandValue(dealerHand)
        : dealerHand[0]?.numericValue ?? 0

    return (
        <>
            <style>{`
                @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Cinzel+Decorative:wght@400;700&display=swap');

                .bj-overlay {
                    position: fixed;
                    inset: 0;
                    z-index: 50;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    background: rgba(0,0,0,0.85);
                    backdrop-filter: blur(6px);
                    font-family: 'Cinzel', serif;
                }

                .bj-table {
                    position: relative;
                    width: min(820px, 96vw);
                    background: radial-gradient(ellipse at 50% 40%, #1a4a2e 0%, #0d2d1a 55%, #071a0e 100%);
                    border-radius: 200px / 80px;
                    border: 6px solid #8b6914;
                    box-shadow:
                        0 0 0 2px #c9a227,
                        0 0 0 10px #5a3e0a,
                        0 0 60px rgba(0,0,0,0.8),
                        inset 0 2px 40px rgba(0,0,0,0.4);
                    padding: 48px 60px 52px;
                    overflow: hidden;
                }

                .bj-table::before {
                    content: '';
                    position: absolute;
                    inset: 12px;
                    border-radius: 190px / 68px;
                    border: 1px solid rgba(201,162,39,0.2);
                    pointer-events: none;
                }

                /* Línea decorativa del tapete */
                .bj-table::after {
                    content: 'BLACKJACK PAYS 3 TO 2';
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    font-family: 'Cinzel Decorative', serif;
                    font-size: 10px;
                    letter-spacing: 4px;
                    color: rgba(201,162,39,0.18);
                    white-space: nowrap;
                    pointer-events: none;
                }

                .bj-close {
                    position: absolute;
                    top: 20px;
                    right: 28px;
                    background: none;
                    border: none;
                    color: rgba(201,162,39,0.5);
                    font-size: 18px;
                    cursor: pointer;
                    transition: color 0.2s;
                    font-family: 'Cinzel', serif;
                    z-index: 10;
                }
                .bj-close:hover { color: #c9a227; }

                .bj-chips-display {
                    position: absolute;
                    top: 20px;
                    left: 28px;
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    z-index: 10;
                }

                .chip-icon {
                    width: 32px;
                    height: 32px;
                    border-radius: 50%;
                    background: radial-gradient(circle at 35% 35%, #e8c94a, #c9a227 50%, #8b6914);
                    border: 2px solid #f0d060;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 14px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.4);
                }

                .chips-count {
                    color: #c9a227;
                    font-size: 13px;
                    font-weight: 600;
                    letter-spacing: 1px;
                }

                /* Zona del crupier */
                .dealer-zone {
                    text-align: center;
                    margin-bottom: 8px;
                }

                .zone-label {
                    font-family: 'Cinzel Decorative', serif;
                    font-size: 9px;
                    letter-spacing: 4px;
                    color: rgba(201,162,39,0.5);
                    margin-bottom: 16px;
                    display: block;
                }

                .score-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    background: rgba(0,0,0,0.4);
                    border: 1px solid rgba(201,162,39,0.3);
                    border-radius: 20px;
                    padding: 3px 14px;
                    color: #c9a227;
                    font-size: 12px;
                    letter-spacing: 2px;
                    margin-bottom: 14px;
                }

                /* Divisor central */
                .table-divider {
                    width: 100%;
                    height: 1px;
                    background: linear-gradient(90deg, transparent, rgba(201,162,39,0.25), transparent);
                    margin: 20px 0;
                    position: relative;
                }

                /* Cards area */
                .cards-row {
                    display: flex;
                    justify-content: center;
                    gap: 10px;
                    min-height: 110px;
                    align-items: center;
                    flex-wrap: wrap;
                }

                /* Carta boca abajo */
                @keyframes dealCard {
                    from { opacity: 0; transform: translateY(-20px) scale(0.9) rotate(-3deg); }
                    to   { opacity: 1; transform: translateY(0) scale(1) rotate(0deg); }
                }

                .card-hidden {
                    width: 72px;
                    height: 100px;
                    border-radius: 8px;
                    background: linear-gradient(135deg, #1a2a6e 0%, #0d1540 100%);
                    border: 2px solid rgba(255,255,255,0.15);
                    box-shadow: 3px 4px 12px rgba(0,0,0,0.5);
                    position: relative;
                    overflow: hidden;
                    animation: dealCard 0.3s ease-out both;
                }

                .card-back-pattern {
                    position: absolute;
                    inset: 6px;
                    border: 1px solid rgba(255,255,255,0.1);
                    border-radius: 4px;
                    background-image:
                        repeating-linear-gradient(45deg, rgba(255,255,255,0.04) 0px, rgba(255,255,255,0.04) 1px, transparent 1px, transparent 8px),
                        repeating-linear-gradient(-45deg, rgba(255,255,255,0.04) 0px, rgba(255,255,255,0.04) 1px, transparent 1px, transparent 8px);
                }

                /* Carta boca arriba */
                .card-face {
                    width: 72px;
                    height: 100px;
                    border-radius: 8px;
                    background: #fefefe;
                    border: 1px solid rgba(0,0,0,0.12);
                    box-shadow: 3px 4px 12px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.8);
                    position: relative;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    animation: dealCard 0.3s ease-out both;
                }

                .card-corner {
                    position: absolute;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    line-height: 1;
                    gap: 1px;
                }
                .card-corner.top-left { top: 5px; left: 6px; }
                .card-corner.bottom-right { bottom: 5px; right: 6px; transform: rotate(180deg); }

                .card-value {
                    font-family: 'Cinzel', serif;
                    font-size: 13px;
                    font-weight: 700;
                    display: block;
                }
                .card-suit-small {
                    font-size: 10px;
                    display: block;
                }
                .card-suit-center {
                    font-size: 28px;
                    line-height: 1;
                }
                .red  { color: #c0392b; }
                .black { color: #1a1a1a; }

                /* Zona del jugador */
                .player-zone {
                    text-align: center;
                    margin-top: 8px;
                }

                /* Mensaje resultado */
                .result-message {
                    text-align: center;
                    font-family: 'Cinzel Decorative', serif;
                    font-size: 13px;
                    letter-spacing: 2px;
                    padding: 10px 0 2px;
                    min-height: 36px;
                }
                .result-win  { color: #4ade80; text-shadow: 0 0 20px rgba(74,222,128,0.5); }
                .result-lose { color: #f87171; text-shadow: 0 0 20px rgba(248,113,113,0.5); }
                .result-draw { color: rgba(201,162,39,0.9); }
                .result-info { color: rgba(201,162,39,0.6); font-size: 11px; }

                /* ─── Controles ─── */
                .controls {
                    display: flex;
                    justify-content: center;
                    gap: 12px;
                    margin-top: 24px;
                    flex-wrap: wrap;
                }

                /* Chips de apuesta */
                .bet-chips {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 16px;
                    margin-bottom: 20px;
                }

                .bet-chip {
                    width: 60px;
                    height: 60px;
                    border-radius: 50%;
                    border: none;
                    cursor: pointer;
                    font-family: 'Cinzel', serif;
                    font-size: 13px;
                    font-weight: 700;
                    transition: transform 0.15s, box-shadow 0.15s;
                    position: relative;
                    box-shadow: 0 4px 12px rgba(0,0,0,0.4), inset 0 1px 0 rgba(255,255,255,0.2);
                }
                .bet-chip:hover { transform: translateY(-3px); box-shadow: 0 7px 20px rgba(0,0,0,0.5); }

                .bet-chip-10  { background: radial-gradient(circle at 35% 35%, #e74c3c, #922b21); color: white; }
                .bet-chip-25  { background: radial-gradient(circle at 35% 35%, #3498db, #1a5276); color: white; }
                .bet-chip-50  { background: radial-gradient(circle at 35% 35%, #2ecc71, #1a6b3a); color: white; }

                .bet-chip.selected {
                    transform: translateY(-6px);
                    outline: 3px solid #c9a227;
                    outline-offset: 3px;
                    box-shadow: 0 8px 24px rgba(201,162,39,0.4);
                }

                .chip-notch {
                    position: absolute;
                    width: 100%;
                    height: 100%;
                    border-radius: 50%;
                    border: 4px dashed rgba(255,255,255,0.2);
                    top: 0; left: 0;
                    box-sizing: border-box;
                }

                /* Apuesta actual */
                .current-bet {
                    text-align: center;
                    color: rgba(201,162,39,0.7);
                    font-size: 11px;
                    letter-spacing: 3px;
                    margin-bottom: 8px;
                }

                /* Botones de acción */
                .btn-action {
                    padding: 12px 36px;
                    border-radius: 4px;
                    border: 1px solid rgba(201,162,39,0.5);
                    background: rgba(0,0,0,0.35);
                    color: #c9a227;
                    font-family: 'Cinzel', serif;
                    font-size: 12px;
                    letter-spacing: 2px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.2s;
                    text-transform: uppercase;
                }
                .btn-action:hover {
                    background: rgba(201,162,39,0.15);
                    border-color: #c9a227;
                    box-shadow: 0 0 16px rgba(201,162,39,0.2);
                }
                .btn-action:disabled {
                    opacity: 0.35;
                    cursor: not-allowed;
                }
                .btn-action.primary {
                    background: linear-gradient(135deg, rgba(201,162,39,0.25), rgba(139,105,20,0.25));
                    border-color: #c9a227;
                }
                .btn-action.primary:hover {
                    background: linear-gradient(135deg, rgba(201,162,39,0.4), rgba(139,105,20,0.35));
                }
                .btn-action.danger {
                    border-color: rgba(248,113,113,0.4);
                    color: #f87171;
                }
                .btn-action.danger:hover {
                    background: rgba(248,113,113,0.1);
                    border-color: #f87171;
                }
            `}</style>

            <div className="bj-overlay">
                <div className="bj-table">

                    {/* Chips y cierre */}
                    <div className="bj-chips-display">
                        <div className="chip-icon">🪙</div>
                        <span className="chips-count">{chips} fichas</span>
                    </div>
                    <button className="bj-close" onClick={onClose}>✕</button>

                    {/* ── Zona Crupier ── */}
                    <div className="dealer-zone">
                        <span className="zone-label">C R U P I E R</span>
                        {(gameState === 'finished' || gameState === 'dealer') && (
                            <div className="score-badge">{dealerValue}</div>
                        )}
                        <div className="cards-row">
                            {gameState === 'betting' ? (
                                <span style={{ color: 'rgba(201,162,39,0.2)', fontSize: 13, letterSpacing: 3 }}>— — —</span>
                            ) : (
                                dealerHand.map((card, i) => (
                                    <CardComponent
                                        key={i}
                                        card={card}
                                        hidden={gameState === 'playing' && i === 1}
                                        index={i}
                                    />
                                ))
                            )}
                        </div>
                    </div>

                    {/* Divisor */}
                    <div className="table-divider" />

                    {/* ── Zona Jugador ── */}
                    <div className="player-zone">
                        <div className="cards-row">
                            {gameState === 'betting' ? (
                                <span style={{ color: 'rgba(201,162,39,0.2)', fontSize: 13, letterSpacing: 3 }}>— — —</span>
                            ) : (
                                playerHand.map((card, i) => (
                                    <CardComponent key={i} card={card} index={i} />
                                ))
                            )}
                        </div>
                        {gameState !== 'betting' && (
                            <div className="score-badge" style={{ marginTop: 14 }}>{playerValue}</div>
                        )}
                        <span className="zone-label" style={{ marginTop: 4 }}>J U G A D O R</span>
                    </div>

                    {/* Mensaje */}
                    <div className={`result-message ${
                        result === 'win' ? 'result-win'
                        : result === 'lose' ? 'result-lose'
                        : result === 'draw' ? 'result-draw'
                        : 'result-info'
                    }`}>
                        {message}
                    </div>

                    {/* ── Controles ── */}
                    {gameState === 'betting' && (
                        <div>
                            <p className="current-bet">APUESTA · {bet} fichas</p>
                            <div className="bet-chips">
                                {([10, 25, 50] as const).map(b => (
                                    <button
                                        key={b}
                                        onClick={() => setBet(b)}
                                        className={`bet-chip bet-chip-${b} ${bet === b ? 'selected' : ''}`}
                                    >
                                        <div className="chip-notch" />
                                        {b}
                                    </button>
                                ))}
                            </div>
                            <div className="controls">
                                <button
                                    onClick={startGame}
                                    disabled={bet > chips}
                                    className="btn-action primary"
                                >
                                    Repartir
                                </button>
                            </div>
                        </div>
                    )}

                    {gameState === 'playing' && (
                        <div className="controls">
                            <button onClick={hit} className="btn-action primary">Pedir carta</button>
                            <button onClick={() => stand()} className="btn-action">Plantarse</button>
                        </div>
                    )}

                    {gameState === 'finished' && (
                        <div className="controls">
                            <button
                                onClick={() => {
                                    setGameState('betting')
                                    setPlayerHand([])
                                    setDealerHand([])
                                    setMessage('')
                                    setResult(null)
                                }}
                                disabled={chips <= 0}
                                className="btn-action primary"
                            >
                                {chips <= 0 ? 'Sin fichas' : 'Nueva mano'}
                            </button>
                            <button onClick={onClose} className="btn-action danger">Salir</button>
                        </div>
                    )}

                </div>
            </div>
        </>
    )
}
