import type { Stage } from '../context/UmrahContext'

const STEPS: { label: string; stage: Stage }[] = [
  { label: 'Before Miqat', stage: 1 },
  { label: 'At Miqat', stage: 2 },
  { label: 'Tawaf', stage: 3 },
  { label: 'Saʿi', stage: 4 },
  { label: 'Tahleel', stage: 5 },
]

interface StepperProps {
  currentStage: number
  onStepClick: (stage: Stage) => void
}

export function Stepper({ currentStage, onStepClick }: StepperProps) {
  return (
    <div className="flex items-center w-full">
      {STEPS.map(({ label, stage }, i) => {
        const done = currentStage > stage
        const active = currentStage === stage

        return (
          <div key={label} className="flex items-center flex-1 min-w-0">
            <button
              onClick={() => onStepClick(stage)}
              className="flex flex-col items-center gap-1.5 w-full"
            >
              <div
                className={`w-2 h-2 rounded-full transition-colors ${
                  done ? 'bg-gold' : active ? 'bg-gold opacity-70' : 'bg-parchment-dark'
                }`}
              />
              <span
                className={`font-sans text-[10px] text-center leading-tight transition-colors ${
                  done || active ? 'text-ink' : 'text-muted'
                }`}
              >
                {label}
              </span>
            </button>
            {i < STEPS.length - 1 && (
              <div
                className={`h-px flex-shrink-0 w-3 transition-colors ${
                  done ? 'bg-gold' : 'bg-parchment-dark'
                }`}
              />
            )}
          </div>
        )
      })}
    </div>
  )
}
