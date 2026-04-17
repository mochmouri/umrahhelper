import React, { createContext, useContext, useReducer, useEffect } from 'react'

// Stages: 0=Welcome, 1=BeforeMiqat, 2=AtMiqat, 3=Tawaf, 4=Sai, 5=Tahleel
export type Stage = 0 | 1 | 2 | 3 | 4 | 5

export interface UmrahState {
  stage: Stage
  talbiyahStarted: boolean
  tawafChecklist: {
    wudu: boolean
    locatedBlackStone: boolean
    raisedHand: boolean
  }
  tawafStarted: boolean
  tawafStartTime: number | null
  lapTimes: number[]      // timestamp on each lap completion (length = laps done)
  currentLap: number      // 0 = not started, 1–7 = active lap, 8 = all done
  saiStarted: boolean
  saiStartTime: number | null
  roundTimes: number[]    // timestamp on each round completion
  currentRound: number    // 0 = not started, 1–7 = active round, 8 = all done
  umrahStartTime: number | null
}

export type Action =
  | { type: 'SET_STAGE'; payload: Stage }
  | { type: 'SET_TALBIYAH_STARTED'; payload: boolean }
  | { type: 'SET_TAWAF_CHECKLIST'; payload: Partial<UmrahState['tawafChecklist']> }
  | { type: 'START_TAWAF' }
  | { type: 'COMPLETE_LAP' }
  | { type: 'START_SAI' }
  | { type: 'COMPLETE_ROUND' }
  | { type: 'RESET' }

const initialState: UmrahState = {
  stage: 0,
  talbiyahStarted: false,
  tawafChecklist: { wudu: false, locatedBlackStone: false, raisedHand: false },
  tawafStarted: false,
  tawafStartTime: null,
  lapTimes: [],
  currentLap: 0,
  saiStarted: false,
  saiStartTime: null,
  roundTimes: [],
  currentRound: 0,
  umrahStartTime: null,
}

function reducer(state: UmrahState, action: Action): UmrahState {
  switch (action.type) {
    case 'SET_STAGE': {
      const next: UmrahState = { ...state, stage: action.payload }
      if (action.payload >= 1 && state.umrahStartTime === null) {
        next.umrahStartTime = Date.now()
      }
      return next
    }
    case 'SET_TALBIYAH_STARTED':
      return { ...state, talbiyahStarted: action.payload }
    case 'SET_TAWAF_CHECKLIST':
      return {
        ...state,
        tawafChecklist: { ...state.tawafChecklist, ...action.payload },
      }
    case 'START_TAWAF':
      return {
        ...state,
        tawafStarted: true,
        tawafStartTime: Date.now(),
        currentLap: 1,
      }
    case 'COMPLETE_LAP': {
      const lapTimes = [...state.lapTimes, Date.now()]
      return {
        ...state,
        lapTimes,
        currentLap: Math.min(state.currentLap + 1, 8),
      }
    }
    case 'START_SAI':
      return {
        ...state,
        saiStarted: true,
        saiStartTime: Date.now(),
        currentRound: 1,
      }
    case 'COMPLETE_ROUND': {
      const roundTimes = [...state.roundTimes, Date.now()]
      return {
        ...state,
        roundTimes,
        currentRound: Math.min(state.currentRound + 1, 8),
      }
    }
    case 'RESET':
      return { ...initialState }
    default:
      return state
  }
}

interface UmrahContextType {
  state: UmrahState
  dispatch: React.Dispatch<Action>
  goToStage: (stage: Stage, force?: boolean) => void
}

const UmrahContext = createContext<UmrahContextType | null>(null)

const STORAGE_KEY = 'umrah-guide-v1'

export function UmrahProvider({ children }: { children: React.ReactNode }) {
  const [state, dispatch] = useReducer(reducer, initialState, (init) => {
    try {
      const saved = localStorage.getItem(STORAGE_KEY)
      return saved ? (JSON.parse(saved) as UmrahState) : init
    } catch {
      return init
    }
  })

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(state))
  }, [state])

  const goToStage = (stage: Stage) => {
    dispatch({ type: 'SET_STAGE', payload: stage })
  }

  return (
    <UmrahContext.Provider value={{ state, dispatch, goToStage }}>
      {children}
    </UmrahContext.Provider>
  )
}

export function useUmrah() {
  const ctx = useContext(UmrahContext)
  if (!ctx) throw new Error('useUmrah must be used within UmrahProvider')
  return ctx
}

// ── Derived metric helpers ────────────────────────────────────────────────────

export function formatDuration(ms: number): string {
  const s = Math.floor(ms / 1000)
  const m = Math.floor(s / 60)
  const sec = s % 60
  if (m > 0) return `${m}m ${sec}s`
  return `${sec}s`
}

export interface LapMetric {
  label: string
  duration: number
}

export function getTawafMetrics(state: UmrahState): {
  metrics: LapMetric[]
  total: number
  average: number
} {
  if (!state.tawafStartTime || state.lapTimes.length === 0) {
    return { metrics: [], total: 0, average: 0 }
  }
  const metrics: LapMetric[] = state.lapTimes.map((t, i) => {
    const prev = i === 0 ? state.tawafStartTime! : state.lapTimes[i - 1]
    return { label: `Lap ${i + 1}`, duration: t - prev }
  })
  const total = state.lapTimes[state.lapTimes.length - 1] - state.tawafStartTime
  return { metrics, total, average: total / metrics.length }
}

export function getSaiMetrics(state: UmrahState): {
  metrics: LapMetric[]
  total: number
  average: number
} {
  if (!state.saiStartTime || state.roundTimes.length === 0) {
    return { metrics: [], total: 0, average: 0 }
  }
  const labels = ['Safa→Marwa', 'Marwa→Safa', 'Safa→Marwa', 'Marwa→Safa', 'Safa→Marwa', 'Marwa→Safa', 'Safa→Marwa']
  const metrics: LapMetric[] = state.roundTimes.map((t, i) => {
    const prev = i === 0 ? state.saiStartTime! : state.roundTimes[i - 1]
    return { label: `Round ${i + 1} (${labels[i]})`, duration: t - prev }
  })
  const total = state.roundTimes[state.roundTimes.length - 1] - state.saiStartTime
  return { metrics, total, average: total / metrics.length }
}
