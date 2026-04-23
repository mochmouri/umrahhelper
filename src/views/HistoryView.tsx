import { useState } from 'react'
import { useUmrah, formatDuration, buildShareText, type UmrahSession } from '../context/UmrahContext'
import { getStrings } from '../data/strings'

function sessionTotals(s: UmrahSession) {
  const tawafTotal = s.lapTimes.length > 0
    ? s.lapTimes[s.lapTimes.length - 1] - s.tawafStartTime
    : 0
  const saiTotal = s.roundTimes.length > 0
    ? s.roundTimes[s.roundTimes.length - 1] - s.saiStartTime
    : 0
  const umrahTotal = s.roundTimes.length === 7
    ? s.roundTimes[6] - s.umrahStartTime
    : 0
  return { tawafTotal, saiTotal, umrahTotal }
}

function formatDate(ts: number, isArabic: boolean): string {
  return new Date(ts).toLocaleDateString(isArabic ? 'ar-SA' : 'en-GB', {
    day: 'numeric', month: 'short', year: 'numeric',
  })
}

interface SessionCardProps {
  session: UmrahSession
  isArabic: boolean
  onDelete: () => void
}

function SessionCard({ session, isArabic, onDelete }: SessionCardProps) {
  const S = getStrings(isArabic)
  const [expanded, setExpanded] = useState(false)
  const [copied, setCopied] = useState(false)
  const [confirmDelete, setConfirmDelete] = useState(false)
  const { tawafTotal, saiTotal, umrahTotal } = sessionTotals(session)

  const lapDurations = session.lapTimes.map((t, i) => {
    const prev = i === 0 ? session.tawafStartTime : session.lapTimes[i - 1]
    return t - prev
  })
  const roundDurations = session.roundTimes.map((t, i) => {
    const prev = i === 0 ? session.saiStartTime : session.roundTimes[i - 1]
    return t - prev
  })
  const tawafAvg = lapDurations.length > 0 ? tawafTotal / lapDurations.length : 0
  const saiAvg = roundDurations.length > 0 ? saiTotal / roundDurations.length : 0

  const handleShare = async () => {
    const text = buildShareText(session)
    if (navigator.share) {
      try { await navigator.share({ title: 'My Umrah', text }) } catch { /* cancelled */ }
    } else {
      await navigator.clipboard.writeText(text)
      setCopied(true)
      setTimeout(() => setCopied(false), 2500)
    }
  }

  return (
    <div className="border border-parchment-dark" dir={isArabic ? 'rtl' : 'ltr'}>
      {/* Header row */}
      <button
        onClick={() => setExpanded(v => !v)}
        className="w-full flex items-center justify-between px-4 py-4 text-start"
      >
        <div>
          <p className="font-sans text-xs text-muted mb-0.5">{formatDate(session.completedAt, isArabic)}</p>
          <p className="font-serif text-base text-ink">{formatDuration(umrahTotal)}</p>
          <p className="font-sans text-xs text-muted mt-0.5">
            {S.tawafLabel} {formatDuration(tawafTotal)} · {S.saiLabel} {formatDuration(saiTotal)}
          </p>
        </div>
        <span className="font-sans text-xs text-muted">{expanded ? '▲' : '▼'}</span>
      </button>

      {/* Expanded breakdown */}
      {expanded && (
        <div className="border-t border-parchment-dark px-4 py-4 space-y-4">
          {/* Tawaf laps */}
          <div>
            <p className="font-sans text-xs text-muted uppercase tracking-widest mb-2">{S.tawafLapBreakdown}</p>
            <div className="space-y-1">
              {lapDurations.map((d, i) => (
                <div key={i} className="flex justify-between font-sans text-sm">
                  <span className="text-muted">{S.lapLabel(i)}</span>
                  <span className="text-ink tabular-nums">{formatDuration(d)}</span>
                </div>
              ))}
              <div className="border-t border-parchment-dark pt-1.5 mt-1.5 flex justify-between font-sans text-xs">
                <span className="text-muted">{S.averageLabel}</span>
                <span className="text-ink tabular-nums">{formatDuration(tawafAvg)}</span>
              </div>
            </div>
          </div>

          {/* Sa'i rounds */}
          <div>
            <p className="font-sans text-xs text-muted uppercase tracking-widest mb-2">{S.saiRoundBreakdown}</p>
            <div className="space-y-1">
              {roundDurations.map((d, i) => (
                <div key={i} className="flex justify-between font-sans text-sm">
                  <span className="text-muted">{S.roundLabel(i)}</span>
                  <span className="text-ink tabular-nums">{formatDuration(d)}</span>
                </div>
              ))}
              <div className="border-t border-parchment-dark pt-1.5 mt-1.5 flex justify-between font-sans text-xs">
                <span className="text-muted">{S.averageLabel}</span>
                <span className="text-ink tabular-nums">{formatDuration(saiAvg)}</span>
              </div>
            </div>
          </div>

          {/* Actions */}
          <div className="flex gap-2 pt-1">
            <button
              onClick={handleShare}
              className="flex-1 py-2.5 bg-ink text-parchment font-sans text-xs tracking-widest uppercase hover:bg-ink-light transition-colors"
            >
              {copied ? S.shareCopied : S.shareSummary}
            </button>
            {confirmDelete ? (
              <div className="flex gap-1">
                <button
                  onClick={() => setConfirmDelete(false)}
                  className="px-3 py-2.5 font-sans text-xs text-muted border border-parchment-dark hover:text-ink transition-colors"
                >
                  {S.cancelButton2}
                </button>
                <button
                  onClick={onDelete}
                  className="px-3 py-2.5 font-sans text-xs text-red-soft border border-red-soft/40 hover:bg-red-soft/10 transition-colors"
                >
                  {S.deleteConfirm}
                </button>
              </div>
            ) : (
              <button
                onClick={() => setConfirmDelete(true)}
                className="px-3 py-2.5 font-sans text-xs text-muted border border-parchment-dark hover:text-red-soft hover:border-red-soft/40 transition-colors"
              >
                {S.deleteEntry}
              </button>
            )}
          </div>
        </div>
      )}
    </div>
  )
}

export function HistoryView() {
  const { state, dispatch } = useUmrah()
  const S = getStrings(state.isArabic)

  return (
    <div
      className="min-h-dvh bg-parchment px-6 pt-20 pb-24 max-w-[480px] mx-auto"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >
      <header className="mb-8">
        <h2 className="font-serif text-2xl text-ink">{S.historyTitle}</h2>
      </header>

      {state.history.length === 0 ? (
        <div className="text-center py-16 space-y-2">
          <p className="font-serif text-base text-ink-light">{S.noUmrahsTitle}</p>
          <p className="font-sans text-sm text-muted">{S.noUmrahsBody}</p>
        </div>
      ) : (
        <div className="space-y-3">
          {state.history.map(session => (
            <SessionCard
              key={session.id}
              session={session}
              isArabic={state.isArabic}
              onDelete={() => dispatch({ type: 'DELETE_HISTORY', payload: session.id })}
            />
          ))}
        </div>
      )}
    </div>
  )
}
