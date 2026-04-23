import { useState } from 'react'
import { useUmrah, getTawafMetrics, getSaiMetrics, formatDuration, buildShareText, type UmrahSession } from '../context/UmrahContext'
import { MetricsCard } from '../components/MetricsCard'
import { getStrings } from '../data/strings'

async function shareSession(session: UmrahSession, onCopied: () => void) {
  const text = buildShareText(session)
  if (navigator.share) {
    try { await navigator.share({ title: 'My Umrah', text }) } catch { /* cancelled */ }
  } else {
    await navigator.clipboard.writeText(text)
    onCopied()
  }
}

export function Stage5Tahleel() {
  const { state, dispatch, goToStage } = useUmrah()
  const S = getStrings(state.isArabic)
  const [copied, setCopied] = useState(false)

  const { total: tawafTotal, metrics: tawafMetrics, average: tawafAvg } = getTawafMetrics(state)
  const { total: saiTotal, metrics: saiMetrics, average: saiAvg } = getSaiMetrics(state)
  const umrahTotal =
    state.umrahStartTime && state.roundTimes.length === 7
      ? state.roundTimes[6] - state.umrahStartTime
      : null

  const currentSession: UmrahSession | null =
    state.umrahStartTime && state.tawafStartTime && state.saiStartTime && state.roundTimes.length === 7
      ? {
          id: 'current',
          completedAt: Date.now(),
          umrahStartTime: state.umrahStartTime,
          tawafStartTime: state.tawafStartTime,
          lapTimes: state.lapTimes,
          saiStartTime: state.saiStartTime,
          roundTimes: state.roundTimes,
        }
      : null

  const handleStartOver = () => {
    if (window.confirm(S.startOverMessage)) {
      dispatch({ type: 'SAVE_AND_RESET' })
      goToStage(0)
    }
  }

  const handleShare = () => {
    if (!currentSession) return
    shareSession(currentSession, () => {
      setCopied(true)
      setTimeout(() => setCopied(false), 2500)
    })
  }

  return (
    <div
      className="min-h-dvh bg-parchment px-6 pt-6 pb-24 max-w-[480px] mx-auto"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >
      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">{S.stage5Number}</p>
        <h2 className="font-serif text-2xl text-ink">{S.stage5Title}</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">{S.stage5Subtitle}</p>
      </header>

      {/* Hair cutting instructions */}
      <section className="mb-8 space-y-4">
        <h3 className="font-serif text-base font-semibold text-ink mb-3">{S.hairCuttingTitle}</h3>
        <div className="space-y-3">
          <div className="flex gap-3">
            <span className="text-gold font-serif text-lg leading-none mt-0.5">♂</span>
            <div>
              <p className="font-sans text-sm font-medium text-ink">{S.menLabel}</p>
              <p className="font-sans text-sm text-ink-light leading-relaxed">{S.menText}</p>
            </div>
          </div>
          <div className="flex gap-3">
            <span className="text-gold font-serif text-lg leading-none mt-0.5">♀</span>
            <div>
              <p className="font-sans text-sm font-medium text-ink">{S.womenLabel}</p>
              <p className="font-sans text-sm text-ink-light leading-relaxed">{S.womenText}</p>
            </div>
          </div>
        </div>
        <div
          style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-gold)', paddingInlineStart: '1rem' }}
        >
          <p className="font-sans text-sm text-ink-light leading-relaxed">{S.ihramLiftedNote}</p>
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
        <p lang="ar" dir="rtl" className="font-arabic text-4xl text-ink leading-loose text-center">
          الله يتقبل
        </p>
        <p className="font-serif text-base italic text-ink-light">{S.congratsSubtitle}</p>
        <p className="font-sans text-sm text-muted leading-relaxed">{S.congratsBody}</p>
      </section>

      {/* Summary metrics */}
      {umrahTotal && (
        <section className="mb-8 space-y-4">
          <h3 className="font-serif text-base font-semibold text-ink">{S.summaryTitle}</h3>

          <div className="border border-parchment-dark bg-parchment-dark/40 p-5 space-y-2">
            {tawafTotal > 0 && (
              <div className="flex justify-between font-sans text-sm">
                <span className="text-muted">{S.tawafLabel}</span>
                <span className="text-ink tabular-nums">{formatDuration(tawafTotal)}</span>
              </div>
            )}
            {saiTotal > 0 && (
              <div className="flex justify-between font-sans text-sm">
                <span className="text-muted">{S.saiLabel}</span>
                <span className="text-ink tabular-nums">{formatDuration(saiTotal)}</span>
              </div>
            )}
            <div className="border-t border-parchment-dark pt-2 flex justify-between font-sans text-sm font-semibold">
              <span className="text-ink">{S.totalUmrahLabel}</span>
              <span className="text-ink tabular-nums">{formatDuration(umrahTotal)}</span>
            </div>
          </div>

          {state.lapTimes.length === 7 && (
            <MetricsCard
              title={S.tawafLapBreakdown}
              metrics={tawafMetrics.map((m, i) => ({ ...m, label: S.lapLabel(i) }))}
              total={tawafTotal}
              average={tawafAvg}
              averageLabel={S.averageLabel}
              totalLabel={S.totalLabel}
            />
          )}
          {state.roundTimes.length === 7 && (
            <MetricsCard
              title={S.saiRoundBreakdown}
              metrics={saiMetrics.map((m, i) => ({ ...m, label: S.roundLabel(i) }))}
              total={saiTotal}
              average={saiAvg}
              averageLabel={S.averageLabel}
              totalLabel={S.totalLabel}
            />
          )}
        </section>
      )}

      {/* Actions */}
      <div className="space-y-3">
        {currentSession && (
          <button
            onClick={handleShare}
            className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
          >
            {copied ? S.shareCopied : S.shareSummary}
          </button>
        )}
        <button
          onClick={handleStartOver}
          className="w-full py-3.5 border border-parchment-dark text-muted font-sans text-sm tracking-widest uppercase hover:border-ink-light hover:text-ink transition-colors"
        >
          {S.startOverButton}
        </button>
      </div>
    </div>
  )
}
