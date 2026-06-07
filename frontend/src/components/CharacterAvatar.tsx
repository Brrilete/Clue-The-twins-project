interface Props {
    avatarToShow: string | null
    characterAvatars: Record<string, string>
}

export default function CharacterAvatar({ avatarToShow, characterAvatars }: Props) {
    if (!avatarToShow || !characterAvatars[avatarToShow]) return null

    const isLeft = avatarToShow === 'presoI'

    return (
        <div
            className={`fixed bottom-0 z-40 pointer-events-none ${isLeft ? 'left-0' : 'right-0'}`}
            style={{ width: '25vw', height: '67vh' }}
        >
            <img
                src={characterAvatars[avatarToShow]}
                alt="personaje"
                className="w-full h-full object-contain object-bottom"
                style={{ filter: 'drop-shadow(-4px 0px 16px rgba(0,0,0,0.9))' }}
            />
        </div>
    )
}
