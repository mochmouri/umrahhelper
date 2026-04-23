import { formatDuration, type LapMetric } from '../context/UmrahContext'

interface MetricsCardProps {
  title: string
  metrics: LapMetric[]
  total: number
  average: number
  averageLabel?: string
  totalLabel?: string
}

export function MetricsCard({ title, metrics, total, average, averageLabel = 'Average', totalLabel = 'Total' }: MetricsCardProps) {
  if (metrics.length === 0) return null

  return (
    <div className="border border-parchment-dark bg-parchment-dark/40 p-5 space-y-4">
      <h3 className="font-serif text-base font-semibold text-ink">{title}</h3>
      <div className="space-y-1.5">
        {metrics.map((m, i) => (
          <div key={i} className="flex justify-between font-sans text-sm">
            <span className="text-muted">{m.label}</span>
            <span className="text-ink tabular-nums">{formatDuration(m.duration)}</span>
          </div>
        ))}
      </div>
      <div className="border-t border-parchment-dark pt-3 space-y-1.5">
        <div className="flex justify-between font-sans text-sm">
          <span className="text-muted">{averageLabel}</span>
          <span className="text-ink tabular-nums">{formatDuration(average)}</span>
        </div>
        <div className="flex justify-between font-sans text-sm font-semibold">
          <span className="text-ink">{totalLabel}</span>
          <span className="text-ink tabular-nums">{formatDuration(total)}</span>
        </div>
      </div>
    </div>
  )
}
