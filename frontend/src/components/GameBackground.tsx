interface Props {
    sceneImage: string | null
}

export default function GameBackground({ sceneImage }: Props) {
    return (
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
    )
}
