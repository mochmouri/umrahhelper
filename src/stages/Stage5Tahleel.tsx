import { useUmrah, getTawafMetrics, getSaiMetrics, formatDuration } from '../context/UmrahContext'
import { MetricsCard } from '../components/MetricsCard'

export function Stage5Tahleel() {
  const { state, dispatch, goToStage } = useUmrah()

  const { total: tawafTotal } = getTawafMetrics(state)
  const { total: saiTotal } = getSaiMetrics(state)
  const umrahTotal =
    state.umrahStartTime && state.roundTimes.length === 7
      ? state.roundTimes[6] - state.umrahStartTime
      : null

  return (
    <div className="min-h-dvh bg-parchment px-6 pt-28 pb-24 max-w-[480px] mx-auto">

      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">Stage 5</p>
        <h2 className="font-serif text-2xl text-ink">Tahleel</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">
          The final act — cutting the hair — marks the end of Ihram.
        </p>
      </header>

      {/* Hair cutting instructions */}
      <section className="mb-8 space-y-4">
        <h3 className="font-serif text-base font-semibold text-ink mb-3">Hair cutting</h3>
        <div className="space-y-3">
          <div className="flex gap-3">
            <span className="text-gold font-serif text-lg leading-none mt-0.5">♂</span>
            <div>
              <p className="font-sans text-sm font-medium text-ink">Men</p>
              <p className="font-sans text-sm text-ink-light leading-relaxed">
                The minimum is to cut a fingertip's length of hair from all parts of the head. The preferable act is to shave all the hair off (Halq). This is more virtuous than trimming (Taqseer).
              </p>
            </div>
          </div>
          <div className="flex gap-3">
            <span className="text-gold font-serif text-lg leading-none mt-0.5">♀</span>
            <div>
              <p className="font-sans text-sm font-medium text-ink">Women</p>
              <p className="font-sans text-sm text-ink-light leading-relaxed">
                Gather a lock of hair and cut a fingertip's length from its end. Do not shave.
              </p>
            </div>
          </div>
        </div>
        <div className="border-l-2 border-gold pl-4">
          <p className="font-sans text-sm text-ink-light leading-relaxed">
            After cutting, Ihram is lifted. All restrictions are now removed.
          </p>
        </div>
      </section>

      {/* Divider */}
      <div className="flex items-center gap-3 mb-8">
        <div className="flex-1 h-px bg-parchment-dark" />
        <span className="text-gold text-lg">✦</span>
        <div className="flex-1 h-px bg-parchment-dark" />
      </div>

      {/* Congratulations */}
      <section className="text-center mb-8 space-y-3">
        <p lang="ar" dir="rtl" className="font-arabic text-4xl text-ink leading-loose">
          الله يتقبل
        </p>
        <p className="font-serif text-base italic text-ink-light">
          May Allah accept your Umrah.
        </p>
        <p className="font-sans text-sm text-muted leading-relaxed">
          You have completed your Umrah. May it be a source of forgiveness, mercy, and nearness to Allah.
        </p>
      </section>

      {/* Summary metrics */}
      {umrahTotal && (
        <section className="mb-8 space-y-4">
          <h3 className="font-serif text-base font-semibold text-ink">Summary</h3>

          <div className="border border-parchment-dark bg-parchment-dark/40 p-5 space-y-2">
            {tawafTotal > 0 && (
              <div className="flex justify-between font-sans text-sm">
                <span className="text-muted">Tawaf</span>
                <span className="text-ink tabular-nums">{formatDuration(tawafTotal)}</span>
              </div>
            )}
            {saiTotal > 0 && (
              <div className="flex justify-between font-sans text-sm">
                <span className="text-muted">Saʿi</span>
                <span className="text-ink tabular-nums">{formatDuration(saiTotal)}</span>
              </div>
            )}
            <div className="border-t border-parchment-dark pt-2 flex justify-between font-sans text-sm font-semibold">
              <span className="text-ink">Total Umrah</span>
              <span className="text-ink tabular-nums">{formatDuration(umrahTotal)}</span>
            </div>
          </div>

          {/* Per-lap breakdowns */}
          {state.lapTimes.length === 7 && (
            <MetricsCard
              title="Tawaf — lap breakdown"
              metrics={getTawafMetrics(state).metrics}
              total={tawafTotal}
              average={getTawafMetrics(state).average}
            />
          )}
          {state.roundTimes.length === 7 && (
            <MetricsCard
              title="Saʿi — round breakdown"
              metrics={getSaiMetrics(state).metrics}
              total={saiTotal}
              average={getSaiMetrics(state).average}
            />
          )}
        </section>
      )}

      {/* Start over */}
      <button
        onClick={() => {
          if (window.confirm('This will reset all progress. Are you sure?')) {
            dispatch({ type: 'RESET' })
            goToStage(0)
          }
        }}
        className="w-full py-3.5 border border-parchment-dark text-muted font-sans text-sm tracking-widest uppercase hover:border-ink-light hover:text-ink transition-colors"
      >
        Start Over
      </button>

    </div>
  )
}
