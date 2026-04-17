import { useUmrah, getTawafMetrics } from '../context/UmrahContext'
import { ChecklistItem } from '../components/ChecklistItem'
import { DuaBlock } from '../components/DuaBlock'
import { MetricsCard } from '../components/MetricsCard'
import { blackStoneDua, maqamIbrahimAyah, yemeniCornerDua } from '../data/duas'
import { getDuasForLap } from '../data/adhkar'

export function Stage3Tawaf() {
  const { state, dispatch, goToStage } = useUmrah()
  const { tawafChecklist, tawafStarted, currentLap } = state

  const allChecked =
    tawafChecklist.wudu && tawafChecklist.locatedBlackStone && tawafChecklist.raisedHand

  const tawafComplete = currentLap === 8
  const { metrics, total, average } = getTawafMetrics(state)

  const lapDuas = tawafStarted && currentLap >= 1 && currentLap <= 7
    ? getDuasForLap(currentLap)
    : []

  return (
    <div className="min-h-dvh bg-parchment px-6 pt-28 pb-24 max-w-[480px] mx-auto">

      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">Stage 3</p>
        <h2 className="font-serif text-2xl text-ink">Tawaf</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">
          Seven anti-clockwise circuits around the Ka'bah, beginning and ending at the Black Stone.
        </p>
      </header>

      {/* Pre-Tawaf Checklist */}
      {!tawafStarted && (
        <section className="mb-8">
          <h3 className="font-serif text-base font-semibold text-ink mb-4">Before You Begin</h3>
          <div className="space-y-4">
            <ChecklistItem
              label="I am in a state of Wudu'"
              checked={tawafChecklist.wudu}
              onChange={(v) => dispatch({ type: 'SET_TAWAF_CHECKLIST', payload: { wudu: v } })}
            />
            <ChecklistItem
              label="I have located the Black Stone corner (look for the green light overhead)"
              checked={tawafChecklist.locatedBlackStone}
              onChange={(v) =>
                dispatch({ type: 'SET_TAWAF_CHECKLIST', payload: { locatedBlackStone: v } })
              }
            />
            <ChecklistItem
              label="I have kissed or raised my right hand towards the Black Stone"
              checked={tawafChecklist.raisedHand}
              onChange={(v) =>
                dispatch({ type: 'SET_TAWAF_CHECKLIST', payload: { raisedHand: v } })
              }
            />
          </div>

          {allChecked && (
            <div className="mt-6">
              <h3 className="font-serif text-base font-semibold text-ink mb-3">
                Dua at the Black Stone
              </h3>
              <p className="font-sans text-sm text-muted mb-3 leading-relaxed">
                Say this when you reach or face the Black Stone to begin each circuit.
              </p>
              <DuaBlock {...blackStoneDua} />
              <button
                onClick={() => dispatch({ type: 'START_TAWAF' })}
                className="mt-6 w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
              >
                Begin Tawaf
              </button>
            </div>
          )}
        </section>
      )}

      {/* Active Tawaf */}
      {tawafStarted && !tawafComplete && (
        <section className="mb-8">

          {/* Lap counter */}
          <div className="text-center py-8 border border-parchment-dark">
            <p className="font-sans text-xs text-muted uppercase tracking-widest mb-1">Current lap</p>
            <div className="flex items-baseline justify-center gap-2">
              <span className="font-serif text-7xl text-ink leading-none">{currentLap}</span>
              <span className="font-serif text-2xl text-muted">/ 7</span>
            </div>
            {/* Lap dots */}
            <div className="flex justify-center gap-2 mt-4">
              {Array.from({ length: 7 }, (_, i) => (
                <div
                  key={i}
                  className={`w-2 h-2 rounded-full ${i < currentLap - 1 ? 'bg-gold' : i === currentLap - 1 ? 'bg-ink' : 'bg-parchment-dark'}`}
                />
              ))}
            </div>
          </div>

          {/* Yemeni corner reminder */}
          <div className="mt-5 border-l-2 border-gold pl-4 py-1">
            <p className="font-sans text-xs text-muted uppercase tracking-wide mb-1">
              Yemeni corner reminder
            </p>
            <p className="font-sans text-sm text-ink-light leading-relaxed mb-3">
              When you pass the Yemeni corner (the one before the Black Stone), begin reciting:
            </p>
            <DuaBlock {...yemeniCornerDua} compact />
          </div>

          {/* Rotating adhkar */}
          {lapDuas.length > 0 && (
            <div className="mt-6">
              <p className="font-sans text-xs text-muted uppercase tracking-widest mb-3">
                Recommended dhikr — lap {currentLap}
              </p>
              <div className="space-y-0">
                {lapDuas.map((dua, i) => (
                  <DuaBlock key={i} {...dua} compact />
                ))}
              </div>
            </div>
          )}

          {/* Complete lap button */}
          <div className="mt-6 border-t border-parchment-dark pt-5">
            <p className="font-sans text-xs text-muted text-center mb-3">
              At the Black Stone, raise your hand and say <span className="text-ink font-medium">الله أكبر</span>, then tap when you have completed the circuit.
            </p>
            <button
              onClick={() => dispatch({ type: 'COMPLETE_LAP' })}
              className="w-full py-4 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
            >
              Complete Lap {currentLap}
            </button>
          </div>
        </section>
      )}

      {/* Tawaf complete */}
      {tawafComplete && (
        <section className="space-y-8">

          <div className="text-center py-6 border border-parchment-dark">
            <p lang="ar" dir="rtl" className="font-arabic text-2xl text-ink leading-loose">
              الله يتقبل
            </p>
            <p className="font-sans text-sm text-muted mt-1">Tawaf complete — may Allah accept it.</p>
          </div>

          {/* Metrics */}
          <MetricsCard title="Tawaf times" metrics={metrics} total={total} average={average} />

          {/* Maqam Ibrahim */}
          <div>
            <h3 className="font-serif text-base font-semibold text-ink mb-3">Maqam Ibrahim</h3>
            <DuaBlock {...maqamIbrahimAyah} />
            <p className="font-sans text-sm text-ink-light leading-relaxed mt-3">
              Pray two raka'ah behind Maqam Ibrahim — or anywhere behind it if it is crowded.
            </p>
            <ul className="mt-3 space-y-1.5 font-sans text-sm text-ink-light list-none">
              <li className="flex gap-2"><span className="text-gold">·</span> First raka'ah: Al-Fatiha, then <span className="font-medium text-ink">Al-Kafirun (109)</span></li>
              <li className="flex gap-2"><span className="text-gold">·</span> Second raka'ah: Al-Fatiha, then <span className="font-medium text-ink">Al-Ikhlas (112)</span></li>
            </ul>
            <p className="font-sans text-sm text-ink-light leading-relaxed mt-4">
              Then drink from <span className="font-medium text-ink">Zamzam</span>. Face the Ka'bah and make dua. This is Sunnah.
            </p>
          </div>

          <button
            onClick={() => goToStage(4)}
            className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
          >
            Proceed to Saʿi →
          </button>
        </section>
      )}
    </div>
  )
}
