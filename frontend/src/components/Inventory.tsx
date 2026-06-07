import { useState } from 'react'

interface Item {
    id: number
    name: string
    description: string
}

interface Props {
    inventory: Item[]
    onClose: () => void
}

function getItemIcon(id: number): string {
    const icons: Record<number, string> = {
        1: '📄', 2: '🔫', 3: '✈️', 4: '📸', 5: '🗝️', 6: '🧾', 7: '📝',
    }
    return icons[id] ?? '📦'
}

export default function Inventory({ inventory, onClose }: Props) {
    const [selectedItem, setSelectedItem] = useState<Item | null>(null)

    return (
        <div className="fixed bottom-24 left-4 z-50 w-80 bg-black/95 border border-white/20 rounded-xl overflow-hidden shadow-2xl">
            <div className="flex items-center justify-between px-4 py-3 border-b border-white/10">
                <span className="text-white font-mono text-sm font-bold">🎒 Inventario</span>
                <button onClick={onClose} className="text-white/40 hover:text-white transition text-sm">✕</button>
            </div>
            <div className="flex h-52">
                <div className="w-1/2 border-r border-white/10 overflow-y-auto">
                    {inventory.length === 0 ? (
                        <p className="text-white/30 text-xs p-4 font-mono text-center mt-4">Sin objetos</p>
                    ) : (
                        inventory.map(item => (
                            <button
                                key={item.id}
                                onClick={() => setSelectedItem(item)}
                                className={`w-full flex flex-col items-center gap-1 p-3 hover:bg-white/10 transition border-b border-white/5 ${selectedItem?.id === item.id ? 'bg-white/10' : ''}`}
                            >
                                <span className="text-2xl">{getItemIcon(item.id)}</span>
                                <span className="text-white/60 text-xs font-mono text-center leading-tight">{item.name}</span>
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
                        <p className="text-white/20 font-mono text-xs mt-4 text-center">Pulsa un objeto para ver su descripción</p>
                    )}
                </div>
            </div>
        </div>
    )
}
