import type { Stage } from '../context/UmrahContext'

const STAGES: Stage[] = [1, 2, 3, 4, 5]

interface StepperProps {
  currentStage: number
  onStepClick: (stage: Stage) => void
  labels: string[]
}

export function Stepper({ currentStage, onStepClick, labels }: StepperProps) {
  return (
    <div className="flex items-center w-full">
      {STAGES.map((stage, i) => {
        const label = labels[i] ?? String(stage)
        const done = currentStage > stage
        const active = currentStage === stage

        return (
          <div key={stage} className="flex items-center flex-1 min-w-0">
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
            {i < STAGES.length - 1 && (
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
