import { useEffect, useCallback, useRef, useState } from 'react'
import { UmrahProvider, useUmrah, type Stage } from './context/UmrahContext'
import { useSwipe } from './hooks/useSwipe'
import { ProgressBar } from './components/ProgressBar'
import { Stage0Welcome } from './stages/Stage0Welcome'
import { Stage1BeforeMiqat } from './stages/Stage1BeforeMiqat'
import { Stage2AtMiqat } from './stages/Stage2AtMiqat'
import { Stage3Tawaf } from './stages/Stage3Tawaf'
import { Stage4Sai } from './stages/Stage4Sai'
import { Stage5Tahleel } from './stages/Stage5Tahleel'
import { AdhkarView } from './stages/AdhkarView'
import { HistoryView } from './views/HistoryView'
import { getStrings } from './data/strings'

const MAX_STAGE = 5
const TEXT_SCALE_STEPS = [0.85, 1.0, 1.2]
type Tab = 'guide' | 'history' | 'adhkar'

function AppInner() {
  const { state, dispatch, goToStage } = useUmrah()
  const S = getStrings(state.isArabic)
  const [showBackConfirm, setShowBackConfirm] = useState(false)
  const [currentTab, setCurrentTab] = useState<Tab>('guide')
  const scrollRef = useRef<HTMLDivElement>(null)

  const scrollKey = `${state.stage}-${state.currentLap}-${state.currentRound}-${state.tawafStarted ? 1 : 0}-${state.currentLap === 8 ? 1 : 0}-${state.saiStarted ? 1 : 0}-${state.currentRound === 8 ? 1 : 0}`

  useEffect(() => {
    if (scrollRef.current) scrollRef.current.scrollTop = 0
  }, [scrollKey])

  useEffect(() => {
    if (state.isDarkMode) {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
  }, [state.isDarkMode])

  useEffect(() => {
    document.documentElement.dir = state.isArabic ? 'rtl' : 'ltr'
    document.documentElement.lang = state.isArabic ? 'ar' : 'en'
  }, [state.isArabic])

  // Fix: set root font size so rem-based Tailwind classes scale
  useEffect(() => {
    document.documentElement.style.fontSize = `${state.textScale * 100}%`
  }, [state.textScale])

  const cycleTextScale = () => {
    const idx = TEXT_SCALE_STEPS.findIndex(s => Math.abs(s - state.textScale) < 0.05)
    dispatch({ type: 'SET_TEXT_SCALE', payload: TEXT_SCALE_STEPS[(idx + 1) % TEXT_SCALE_STEPS.length] })
  }

  const navigateNext = useCallback(() => {
    if (state.stage < MAX_STAGE) goToStage((state.stage + 1) as Stage)
  }, [state.stage, goToStage])

  const navigatePrev = useCallback(() => {
    if (state.stage <= 0) return
    if (state.stage > 1) {
      setShowBackConfirm(true)
    } else {
      goToStage((state.stage - 1) as Stage)
    }
  }, [state.stage, goToStage])

  const confirmBack = () => {
    goToStage((state.stage - 1) as Stage)
    setShowBackConfirm(false)
  }

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (currentTab !== 'guide') return
      const isRTL = state.isArabic
      if (e.key === 'ArrowRight') isRTL ? navigatePrev() : navigateNext()
      if (e.key === 'ArrowLeft') isRTL ? navigateNext() : navigatePrev()
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [navigateNext, navigatePrev, state.isArabic, currentTab])

  useSwipe({
    onSwipeLeft: state.isArabic ? navigatePrev : navigateNext,
    onSwipeRight: state.isArabic ? navigateNext : navigatePrev,
  })

  const stage = state.stage
  const ts = state.textScale
  const overlayClass = state.isArabic ? 'left-2' : 'right-2'

  const tabBar = (
    <div
      className="fixed bottom-0 inset-x-0 z-40 flex border-t border-parchment-dark bg-parchment"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >
      {(['guide', 'history', 'adhkar'] as Tab[]).map(tab => (
        <button
          key={tab}
          onClick={() => setCurrentTab(tab)}
          className={`flex-1 py-3 font-sans text-xs tracking-wide transition-colors ${
            currentTab === tab ? 'text-ink border-t-2 border-ink -mt-px' : 'text-muted hover:text-ink'
          }`}
        >
          {tab === 'guide' ? S.tabGuide : tab === 'history' ? S.tabHistory : S.tabAdhkar}
        </button>
      ))}
    </div>
  )

  return (
    <div className="min-h-dvh bg-parchment">
      {/* Overlay controls */}
      <div className={`fixed top-2 ${overlayClass} z-50 flex gap-1`}>
        <button
          onClick={cycleTextScale}
          className="w-8 h-7 flex items-center justify-center bg-parchment-dark/70 text-muted hover:text-ink transition-colors"
          style={{ fontSize: ts < 0.95 ? '9px' : ts > 1.1 ? '14px' : '11px' }}
        >
          Aa
        </button>
        <button
          onClick={() => dispatch({ type: 'SET_DARK_MODE', payload: !state.isDarkMode })}
          className="w-8 h-7 flex items-center justify-center bg-parchment-dark/70 text-muted hover:text-ink transition-colors text-xs"
        >
          {state.isDarkMode ? '☀' : '☽'}
        </button>
        <button
          onClick={() => dispatch({ type: 'SET_ARABIC', payload: !state.isArabic })}
          className="h-7 px-2 flex items-center justify-center bg-parchment-dark/70 text-muted hover:text-ink transition-colors text-xs"
        >
          {state.isArabic ? 'EN' : 'عربي'}
        </button>
      </div>

      {/* Tab content */}
      {currentTab === 'history' && <HistoryView />}
      {currentTab === 'adhkar' && <AdhkarView />}
      {currentTab === 'guide' && (
        stage === 0 ? (
          // Welcome screen — no back button, just tab bar
          <div className="pb-14">
            <Stage0Welcome />
          </div>
        ) : (
          <div className="flex flex-col min-h-dvh">
            <ProgressBar />
            <div ref={scrollRef} className="flex-1 overflow-y-auto">
              {stage === 1 && <Stage1BeforeMiqat />}
              {stage === 2 && <Stage2AtMiqat />}
              {stage === 3 && <Stage3Tawaf />}
              {stage === 4 && <Stage4Sai />}
              {stage === 5 && <Stage5Tahleel />}
            </div>
            {/* Back button sits above the tab bar */}
            <div className="text-center py-3 border-t border-parchment-dark bg-parchment pb-[calc(0.75rem+3.5rem)]">
              <button
                onClick={navigatePrev}
                className="font-sans text-xs text-muted hover:text-ink transition-colors py-1 px-3"
              >
                {S.backButton}
              </button>
            </div>
          </div>
        )
      )}

      {tabBar}

      {/* Back confirm dialog */}
      {showBackConfirm && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-ink/40">
          <div
            className="bg-parchment max-w-xs w-full mx-4 p-6 shadow-lg"
            dir={state.isArabic ? 'rtl' : 'ltr'}
          >
            <h3 className="font-serif text-base font-semibold text-ink mb-2">{S.goBackTitle}</h3>
            <p className="font-sans text-sm text-muted mb-5">{S.goBackMessage}</p>
            <div className="flex gap-3 justify-end">
              <button
                onClick={() => setShowBackConfirm(false)}
                className="font-sans text-sm text-muted px-4 py-2 hover:text-ink transition-colors"
              >
                {S.goBackStay}
              </button>
              <button
                onClick={confirmBack}
                className="font-sans text-sm text-red-soft px-4 py-2 border border-red-soft/40 hover:bg-red-soft/10 transition-colors"
              >
                {S.goBackConfirm}
              </button>
            </div>
          </div>
        </div>
      )}
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
