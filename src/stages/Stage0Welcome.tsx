import { useUmrah, type Stage } from '../context/UmrahContext'
import { Stepper } from '../components/Stepper'
import { getStrings } from '../data/strings'

export function Stage0Welcome() {
  const { state, goToStage } = useUmrah()
  const S = getStrings(state.isArabic)

  const handleStepClick = (stage: Stage) => {
    if (stage <= state.stage + 1) {
      goToStage(stage)
    } else {
      if (window.confirm(S.jumpAheadMessage)) {
        goToStage(stage)
      }
    }
  }

  return (
    <div
      className="min-h-dvh bg-parchment flex flex-col items-center justify-center px-6 py-16"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >
      <div className="w-full max-w-[480px] mx-auto space-y-8 text-center">

        {/* Arabic title — always centered */}
        <div className="space-y-2">
          <h1
            lang="ar"
            dir="rtl"
            className="font-arabic text-5xl leading-loose text-ink text-center"
          >
            دَلِيلُ الْعُمْرَة
          </h1>
          <p className="font-serif text-lg italic text-ink-light">
            {S.welcomeSubtitle}
          </p>
        </div>

        {/* Divider */}
        <div className="flex items-center gap-3">
          <div className="flex-1 h-px bg-parchment-dark" />
          <span className="text-gold text-lg">✦</span>
          <div className="flex-1 h-px bg-parchment-dark" />
        </div>

        {/* Description */}
        <p
          className="font-sans text-sm text-ink-light leading-relaxed"
          style={{ textAlign: state.isArabic ? 'right' : 'left' }}
        >
          {S.welcomeBody}
        </p>

        {/* Trust signals */}
        <p className="font-sans text-xs text-muted tracking-wide text-center">
          {S.welcomeTrustNote}
        </p>

        {/* Begin button */}
        <button
          onClick={() => goToStage(1)}
          className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
        >
          {S.beginButton}
        </button>

        {/* Stepper */}
        <div className="pt-2">
          <p className="font-sans text-xs text-muted mb-4 text-center">{S.orJumpToStep}</p>
          <Stepper currentStage={state.stage} onStepClick={handleStepClick} labels={S.stageLabels} />
        </div>

      </div>
    </div>
  )
}
