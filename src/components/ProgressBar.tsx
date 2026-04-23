import { useUmrah } from '../context/UmrahContext'
import { getStrings } from '../data/strings'

export function ProgressBar() {
  const { state } = useUmrah()
  const S = getStrings(state.isArabic)
  if (state.stage === 0) return null

  return (
    <div className="sticky top-0 z-40 bg-parchment border-b border-parchment-dark">
      <div className="max-w-[480px] mx-auto px-5 py-3 flex gap-1.5 items-center">
        {S.stageLabels.map((label, i) => {
          const s = i + 1
          const active = state.stage === s
          const done = state.stage > s
          return (
            <div key={label} className="flex-1 flex flex-col gap-1">
              <div
                className={`h-0.5 w-full transition-colors duration-300 ${
                  done ? 'bg-gold' : active ? 'bg-gold opacity-50' : 'bg-parchment-dark'
                }`}
              />
              <span
                className={`font-sans text-[9px] tracking-wide uppercase text-center transition-colors ${
                  done || active ? 'text-gold' : 'text-muted opacity-60'
                }`}
              >
                {label}
              </span>
            </div>
          )
        })}
      </div>
    </div>
  )
}
