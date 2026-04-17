import { useUmrah, getSaiMetrics } from '../context/UmrahContext'
import { DuaBlock } from '../components/DuaBlock'
import { MetricsCard } from '../components/MetricsCard'
import { safaAyah, safaDhikr } from '../data/duas'

const ROUND_LABELS = [
  'Safa → Marwa',
  'Marwa → Safa',
  'Safa → Marwa',
  'Marwa → Safa',
  'Safa → Marwa',
  'Marwa → Safa',
  'Safa → Marwa',
]

const ENDPOINT_LABELS = [
  'You have reached Marwa.',
  'You have returned to Safa.',
  'You have reached Marwa.',
  'You have returned to Safa.',
  'You have reached Marwa.',
  'You have returned to Safa.',
  'You have reached Marwa — Saʿi is complete.',
]

export function Stage4Sai() {
  const { state, dispatch, goToStage } = useUmrah()
  const { saiStarted, currentRound } = state

  const saiComplete = currentRound === 8
  const { metrics, total, average } = getSaiMetrics(state)

  // At end points (after completing a round), show the Safa/Marwa dhikr
  const completedRounds = state.roundTimes.length
  const showEndpointDhikr = saiStarted && !saiComplete && completedRounds > 0 && completedRounds < 7

  return (
    <div className="min-h-dvh bg-parchment px-6 pt-28 pb-24 max-w-[480px] mx-auto">

      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">Stage 4</p>
        <h2 className="font-serif text-2xl text-ink">Saʿi</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">
          Seven rounds between Safa and Marwa. One round = one direction. Begin at Safa.
        </p>
      </header>

      {/* At Safa — initial */}
      {!saiStarted && (
        <section className="space-y-6 mb-8">
          <div>
            <h3 className="font-serif text-base font-semibold text-ink mb-3">At Safa</h3>
            <DuaBlock {...safaAyah} />
          </div>

          <div>
            <p className="font-sans text-sm text-muted leading-relaxed mb-3">
              Face the Ka'bah. Raise your hands. Say <span className="text-ink font-medium">الحمد لله</span>. Make personal dua. Then recite this <span className="font-medium text-ink">three times</span>:
            </p>
            <DuaBlock {...safaDhikr} />
          </div>

          <button
            onClick={() => dispatch({ type: 'START_SAI' })}
            className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
          >
            Begin Saʿi
          </button>
        </section>
      )}

      {/* Active Saʿi */}
      {saiStarted && !saiComplete && (
        <section className="mb-8 space-y-6">

          {/* Round counter */}
          <div className="text-center py-8 border border-parchment-dark">
            <p className="font-sans text-xs text-muted uppercase tracking-widest mb-1">Round</p>
            <div className="flex items-baseline justify-center gap-2">
              <span className="font-serif text-7xl text-ink leading-none">{currentRound}</span>
              <span className="font-serif text-2xl text-muted">/ 7</span>
            </div>
            <p className="font-sans text-sm text-ink-light mt-3 font-medium">
              {ROUND_LABELS[currentRound - 1]}
            </p>
            {/* Round dots */}
            <div className="flex justify-center gap-2 mt-4">
              {Array.from({ length: 7 }, (_, i) => (
                <div
                  key={i}
                  className={`w-2 h-2 rounded-full ${i < currentRound - 1 ? 'bg-gold' : i === currentRound - 1 ? 'bg-ink' : 'bg-parchment-dark'}`}
                />
              ))}
            </div>
          </div>

          {/* Endpoint dhikr reminder */}
          {showEndpointDhikr && (
            <div className="border-l-2 border-gold pl-4 py-1">
              <p className="font-sans text-xs text-muted uppercase tracking-wide mb-1">
                At your current endpoint
              </p>
              <p className="font-sans text-sm text-ink-light mb-3 leading-relaxed">
                {ENDPOINT_LABELS[completedRounds - 1]} Face the Ka'bah and recite (×3):
              </p>
              <DuaBlock {...safaDhikr} compact />
            </div>
          )}

          {/* Complete round */}
          <div className="border-t border-parchment-dark pt-5">
            <button
              onClick={() => dispatch({ type: 'COMPLETE_ROUND' })}
              className="w-full py-4 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
            >
              Complete Round {currentRound}
            </button>
          </div>
        </section>
      )}

      {/* Saʿi complete */}
      {saiComplete && (
        <section className="space-y-8">

          <div className="text-center py-6 border border-parchment-dark">
            <p lang="ar" dir="rtl" className="font-arabic text-2xl text-ink leading-loose">
              الله يتقبل
            </p>
            <p className="font-sans text-sm text-muted mt-1">Saʿi complete — may Allah accept it.</p>
          </div>

          <MetricsCard title="Saʿi times" metrics={metrics} total={total} average={average} />

          <button
            onClick={() => goToStage(5)}
            className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
          >
            Proceed to Tahleel →
          </button>
        </section>
      )}
    </div>
  )
}
