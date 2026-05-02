import { TypeAnimation } from 'react-type-animation'

interface Props {
  text: string
  onDone: () => void
}

export default function TypeWriter({ text, onDone }: Props) {
  return (
    <TypeAnimation
      key={text}
      sequence={[text, 500, onDone]}
      speed={70}
      className="text-white font-mono text-lg leading-8 whitespace-pre-wrap"
      style={{ display: 'block' }}
      cursor={true}
    />
  )
}