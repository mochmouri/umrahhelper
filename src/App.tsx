import { useEffect, useCallback } from 'react'
import { UmrahProvider, useUmrah, type Stage } from './context/UmrahContext'
import { useSwipe } from './hooks/useSwipe'
import { ProgressBar } from './components/ProgressBar'
import { Stage0Welcome } from './stages/Stage0Welcome'
import { Stage1BeforeMiqat } from './stages/Stage1BeforeMiqat'
import { Stage2AtMiqat } from './stages/Stage2AtMiqat'
import { Stage3Tawaf } from './stages/Stage3Tawaf'
import { Stage4Sai } from './stages/Stage4Sai'
import { Stage5Tahleel } from './stages/Stage5Tahleel'

const MAX_STAGE = 5

function AppInner() {
  const { state, goToStage } = useUmrah()

  const navigateNext = useCallback(() => {
    if (state.stage < MAX_STAGE) goToStage((state.stage + 1) as Stage)
  }, [state.stage, goToStage])

  const navigatePrev = useCallback(() => {
    if (state.stage <= 0) return
    const target = (state.stage - 1) as Stage
    if (state.stage > 1) {
      if (window.confirm('Go back to the previous step? Your progress is saved.')) {
        goToStage(target)
      }
    } else {
      goToStage(target)
    }
  }, [state.stage, goToStage])

  // Keyboard navigation
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'ArrowRight') navigateNext()
      if (e.key === 'ArrowLeft') navigatePrev()
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [navigateNext, navigatePrev])

  // Swipe navigation
  useSwipe({ onSwipeLeft: navigateNext, onSwipeRight: navigatePrev })

  const stage = state.stage

  return (
    <div className="min-h-dvh bg-parchment">
      <ProgressBar />
      {stage === 0 && <Stage0Welcome />}
      {stage === 1 && <Stage1BeforeMiqat />}
      {stage === 2 && <Stage2AtMiqat />}
      {stage === 3 && <Stage3Tawaf />}
      {stage === 4 && <Stage4Sai />}
      {stage === 5 && <Stage5Tahleel />}
    </div>
  )
}

export default function App() {
  return (
    <UmrahProvider>
      <AppInner />
    </UmrahProvider>
  )
}
