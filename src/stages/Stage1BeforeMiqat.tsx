import { useUmrah } from '../context/UmrahContext'
import { getStrings } from '../data/strings'

export function Stage1BeforeMiqat() {
  const { state, goToStage } = useUmrah()
  const S = getStrings(state.isArabic)

  return (
    <div
      className="min-h-dvh bg-parchment px-6 pt-6 pb-24 max-w-[480px] mx-auto"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >
      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">{S.stage1Number}</p>
        <h2 className="font-serif text-2xl text-ink">{S.stage1Title}</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">{S.stage1Subtitle}</p>
      </header>

      {/* Saudia note */}
      <div
        className="border-parchment-dark pl-4 mb-8"
        style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-gold)', paddingInlineStart: '1rem' }}
      >
        <p className="font-sans text-sm text-ink-light leading-relaxed">
          {S.saudiaNote}
        </p>
      </div>

      {/* Do's & Don'ts */}
      <section className="mb-10">
        <h3 className="font-serif text-base font-semibold text-ink mb-4">{S.dosAndDontsTitle}</h3>
        <div className="space-y-3">
          {S.dosAndDonts.map((item, i) => (
            <div key={i} className="flex items-start gap-3">
              <div
                className={`flex-shrink-0 mt-0.5 w-5 h-5 flex items-center justify-center text-xs font-bold ${
                  item.isDo ? 'text-green-soft' : 'text-red-soft'
                }`}
                aria-label={item.isDo ? 'Do' : "Don't"}
              >
                {item.isDo ? '✓' : '✕'}
              </div>
              <p
                className={`font-sans text-sm leading-relaxed ${
                  item.isDo ? 'text-ink' : 'text-ink-light'
                }`}
              >
                {item.text}
              </p>
            </div>
          ))}
        </div>
      </section>

      {/* Divider */}
      <div className="flex items-center gap-3 mb-8">
        <div className="flex-1 h-px bg-parchment-dark" />
        <span className="text-gold text-sm">✦</span>
        <div className="flex-1 h-px bg-parchment-dark" />
      </div>

      {/* What's next */}
      <div className="space-y-3">
        <p className="font-sans text-sm text-ink-light leading-relaxed">
          {S.stage1BodyText}
        </p>
        <button
          onClick={() => goToStage(2)}
          className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
        >
          {S.continueToMiqat}
        </button>
      </div>
    </div>
  )
}
