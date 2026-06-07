import { useRef } from 'react'
import TypeWriter from './TypeWriter'

interface Message {
    text: string
    isPlayer: boolean
    character?: string
}

interface Props {
    messages: Message[]
    typingDone: boolean
    fastMode: boolean
    onTypingDone: () => void
}

export default function MessageList({ messages, typingDone, fastMode, onTypingDone }: Props) {
    const bottomRef = useRef<HTMLDivElement>(null)

    return (
        <div className="flex-1 flex flex-col gap-6">
            {messages.map((msg, i) => (
                <div key={i}>
                    {msg.isPlayer ? (
                        <p className="text-white/40 font-mono text-sm">{msg.text}</p>
                    ) : i === messages.length - 1 && !typingDone ? (
                        fastMode ? (
                            <p
                                className="text-white font-mono text-lg leading-8 whitespace-pre-wrap"
                                ref={el => { if (el) onTypingDone() }}
                            >
                                {msg.text}
                            </p>
                        ) : (
                            <TypeWriter text={msg.text} onDone={onTypingDone} />
                        )
                    ) : (
                        <p className="text-white font-mono text-lg leading-8 whitespace-pre-wrap">{msg.text}</p>
                    )}
                </div>
            ))}
            <div ref={bottomRef} />
        </div>
    )
}
