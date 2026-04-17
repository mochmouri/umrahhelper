import { useUmrah, type Stage } from '../context/UmrahContext'
import { Stepper } from '../components/Stepper'

export function Stage0Welcome() {
  const { state, goToStage } = useUmrah()

  const handleStepClick = (stage: Stage) => {
    if (stage <= state.stage + 1) {
      goToStage(stage)
    } else {
      if (window.confirm(`You haven't reached this step yet. Jump ahead anyway?`)) {
        goToStage(stage)
      }
    }
  }

  return (
    <div className="min-h-dvh bg-parchment flex flex-col items-center justify-center px-6 py-16">
      <div className="w-full max-w-[480px] mx-auto space-y-8 text-center">

        {/* Arabic title */}
        <div className="space-y-2">
          <h1
            lang="ar"
            dir="rtl"
            className="font-arabic text-5xl leading-loose text-ink"
          >
            دَلِيلُ الْعُمْرَة
          </h1>
          <p className="font-serif text-lg italic text-ink-light">
            A step-by-step companion for your Umrah
          </p>
        </div>

        {/* Divider */}
        <div className="flex items-center gap-3">
          <div className="flex-1 h-px bg-parchment-dark" />
          <span className="text-gold text-lg">✦</span>
          <div className="flex-1 h-px bg-parchment-dark" />
        </div>

        {/* Description */}
        <p className="font-sans text-sm text-ink-light leading-relaxed text-left">
          Umrah is the lesser pilgrimage to Makkah — a voluntary act of worship that may be performed at any time of the year. Though shorter than Hajj, it carries immense spiritual weight and is a profound opportunity for renewal and closeness to Allah. This guide walks you through each step, from putting on Ihram to the final cut of the hair, so your heart can remain in worship rather than in logistics.
        </p>

        {/* Begin button */}
        <button
          onClick={() => goToStage(1)}
          className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
        >
          Begin
        </button>

        {/* Stepper */}
        <div className="pt-2">
          <p className="font-sans text-xs text-muted mb-4 text-center">or jump to a step</p>
          <Stepper currentStage={state.stage} onStepClick={handleStepClick} />
        </div>

      </div>
    </div>
  )
}
