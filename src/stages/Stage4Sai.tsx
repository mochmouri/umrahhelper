import { useUmrah, getSaiMetrics } from '../context/UmrahContext'
import { DuaBlock } from '../components/DuaBlock'
import { MetricsCard } from '../components/MetricsCard'
import { safaAyah, safaDhikr } from '../data/duas'
import { getStrings } from '../data/strings'

export function Stage4Sai() {
  const { state, dispatch, goToStage } = useUmrah()
  const S = getStrings(state.isArabic)
  const { saiStarted, currentRound } = state

  const saiComplete = currentRound === 8
  const { metrics, total, average } = getSaiMetrics(state)

  const completedRounds = state.roundTimes.length
  const showEndpointDhikr = saiStarted && !saiComplete && completedRounds > 0 && completedRounds < 7

  return (
    <div
      className="min-h-dvh bg-parchment px-6 pt-6 pb-24 max-w-[480px] mx-auto"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >
      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">{S.stage4Number}</p>
        <h2 className="font-serif text-2xl text-ink">{S.stage4Title}</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">{S.stage4Subtitle}</p>
      </header>

      {/* ── At Safa — initial ── */}
      {!saiStarted && (
        <section className="space-y-6 mb-8">

          {/* Wudu note */}
          <div
            style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-parchment-dark)', paddingInlineStart: '0.75rem' }}
          >
            <p className="font-sans text-xs text-muted leading-relaxed">{S.saiWuduNote}</p>
          </div>

          <div>
            <h3 className="font-serif text-base font-semibold text-ink mb-3">{S.atSafaTitle}</h3>
            <DuaBlock {...safaAyah} />
          </div>

          <div>
            <p className="font-sans text-sm text-muted leading-relaxed mb-3">
              {S.safaPre}
              <span lang="ar" dir="rtl" className="font-arabic text-base text-ink">الحمد لله</span>
              {S.safaPost}
              <span className="font-medium text-ink">{S.safaThreeTimes}</span>:
            </p>
            <DuaBlock {...safaDhikr} />
          </div>

          <button
            onClick={() => dispatch({ type: 'START_SAI' })}
            className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
          >
            {S.beginSai}
          </button>
        </section>
      )}

      {/* ── Active Saʿi ── */}
      {saiStarted && !saiComplete && (
        <section className="mb-8 space-y-6">

          {/* 1. Endpoint dhikr (shown after completing rounds 1–6) */}
          {showEndpointDhikr && (
            <div
              style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-gold)', paddingInlineStart: '0.75rem', paddingTop: '0.25rem', paddingBottom: '0.25rem' }}
            >
              <p className="font-sans text-[9px] text-muted uppercase tracking-widest mb-1">
                {S.atCurrentEndpoint}
              </p>
              <p className="font-sans text-sm text-ink-light mb-3 leading-relaxed">
                {`${S.endpointLabels[completedRounds - 1]}${S.endpointDhikrBody}`}
              </p>
              <DuaBlock {...safaDhikr} compact />
            </div>
          )}

          {/* 2. Round counter */}
          <div className="text-center py-8 border border-parchment-dark">
            <p className="font-sans text-xs text-muted uppercase tracking-widest mb-1">{S.roundCounterLabel}</p>
            <div
              className="flex items-baseline justify-center gap-2"
              dir="ltr"
            >
              {state.isArabic ? (
                <>
                  <span className="font-serif text-2xl text-muted">٧ /</span>
                  <span className="font-serif text-7xl text-ink leading-none">
                    {['١','٢','٣','٤','٥','٦','٧'][currentRound - 1] ?? currentRound}
                  </span>
                </>
              ) : (
                <>
                  <span className="font-serif text-7xl text-ink leading-none">{currentRound}</span>
                  <span className="font-serif text-2xl text-muted">/ 7</span>
                </>
              )}
            </div>
            <p className="font-sans text-sm text-ink-light mt-3 font-medium">
              {S.roundLabels[currentRound - 1]}
            </p>
            {/* Round dots */}
            <div className="flex justify-center gap-2 mt-4" dir="ltr">
              {Array.from({ length: 7 }, (_, i) => (
                <div
                  key={i}
                  className={`w-2 h-2 rounded-full ${i < currentRound - 1 ? 'bg-gold' : i === currentRound - 1 ? 'bg-ink' : 'bg-parchment-dark'}`}
                />
              ))}
            </div>
          </div>

          {/* 3. Green lights / jogging note */}
          <div className="border border-gold/40 bg-gold/5 px-4 py-3">
            <p className="font-sans text-xs text-ink-light leading-relaxed">{S.saiJoggingNote}</p>
          </div>

          {/* 4. General adhkar note */}
          <div
            style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-parchment-dark)', paddingInlineStart: '0.75rem' }}
          >
            <p className="font-sans text-xs text-muted leading-relaxed">{S.saiAdhkarNote}</p>
          </div>

          {/* 5. Complete round */}
          <div className="border-t border-parchment-dark pt-5">
            <button
              onClick={() => dispatch({ type: 'COMPLETE_ROUND' })}
              className="w-full py-4 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
            >
              {S.completeRoundButton(currentRound)}
            </button>
          </div>
        </section>
      )}

      {/* ── Saʿi complete ── */}
      {saiComplete && (
        <section className="space-y-8">

          <div className="text-center py-6 border border-parchment-dark">
            <p lang="ar" dir="rtl" className="font-arabic text-2xl text-ink leading-loose text-center">
              الله يتقبل
            </p>
            <p className="font-sans text-sm text-muted mt-1">{S.saiCompleteMessage}</p>
          </div>

          <MetricsCard
            title={S.saiTimesTitle}
            metrics={metrics.map((m, i) => ({ ...m, label: S.roundLabel(i) }))}
            total={total}
            average={average}
            averageLabel={S.averageLabel}
            totalLabel={S.totalLabel}
          />

          <button
            onClick={() => goToStage(5)}
            className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
          >
            {S.proceedToTahleel}
          </button>
        </section>
      )}
    </div>
  )
}
