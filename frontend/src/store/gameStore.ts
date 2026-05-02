import { create } from 'zustand'

interface Player {
  id: number
  name: string
  sanity: number
  suspicion: number
  location_scene_id: number
  role: 'user' | 'advanced' | 'admin'
}

interface GameState {
  player: Player | null
  sceneText: string
  sceneImage: string | null
  token: string | null
  setPlayer: (player: Player) => void
  setScene: (text: string, image: string | null) => void
  setToken: (token: string) => void
}

export const useGameStore = create<GameState>((set) => ({
  player: null,
  sceneText: '',
  sceneImage: null,
  token: null,
  setPlayer: (player) => set({ player }),
  setScene: (text, image) => set({ sceneText: text, sceneImage: image }),
  setToken: (token) => set({ token }),
}))