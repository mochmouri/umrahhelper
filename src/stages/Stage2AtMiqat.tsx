import { useUmrah } from '../context/UmrahContext'
import { DuaBlock } from '../components/DuaBlock'
import { niyyah, talbiyah, enteringMosque } from '../data/duas'
import { getStrings } from '../data/strings'

export function Stage2AtMiqat() {
  const { state, dispatch, goToStage } = useUmrah()
  const S = getStrings(state.isArabic)

  return (
    <div
      className="min-h-dvh bg-parchment px-6 pt-6 pb-24 max-w-[480px] mx-auto"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >
      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">{S.stage2Number}</p>
        <h2 className="font-serif text-2xl text-ink">{S.stage2Title}</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">{S.stage2Subtitle}</p>
      </header>

      {/* Niyyah */}
      <section className="mb-8">
        <h3 className="font-serif text-base font-semibold text-ink mb-1">{S.niyyahTitle}</h3>
        <p className="font-sans text-sm text-muted mb-4 leading-relaxed">{S.niyyahBody}</p>
        <DuaBlock {...niyyah} />
        <div
          className="mt-4 border-parchment-dark"
          style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', paddingInlineStart: '1rem' }}
        >
          {state.isArabic ? (
            <p className="font-sans text-xs text-muted leading-relaxed">{S.niyyahNoteArabic}</p>
          ) : (
            <p className="font-sans text-xs text-muted leading-relaxed">
              {S.niyyahNotePre}<span className="italic">{S.niyyahNoteItalic}</span>{S.niyyahNotePost}
            </p>
          )}
        </div>
      </section>

      {/* Talbiyah */}
      <section className="mb-8">
        <h3 className="font-serif text-base font-semibold text-ink mb-1">{S.talbiyahTitle}</h3>
        <p className="font-sans text-sm text-muted mb-4 leading-relaxed">{S.talbiyahBody}</p>
        <DuaBlock {...talbiyah} />
        <button
          onClick={() =>
            dispatch({ type: 'SET_TALBIYAH_STARTED', payload: !state.talbiyahStarted })
          }
          className={`mt-5 w-full py-3 border font-sans text-sm transition-colors ${
            state.talbiyahStarted
              ? 'border-gold text-gold bg-gold/10'
              : 'border-parchment-dark text-ink-light bg-transparent hover:border-ink-light'
          }`}
        >
          {state.talbiyahStarted ? S.talbiyahStarted : S.talbiyahMarkStarted}
        </button>
      </section>

      {/* Entering the Mosque */}
      <section className="mb-8">
        <h3 className="font-serif text-base font-semibold text-ink mb-1">{S.mosqueTitle}</h3>
        <p className="font-sans text-sm text-muted mb-4 leading-relaxed">
          {S.mosquePre}<span className="text-ink font-medium">{S.mosqueBold}</span>{S.mosquePost}
        </p>
        <DuaBlock {...enteringMosque} />
      </section>

      {/* Continue */}
      <div className="flex items-center gap-3 mb-6">
        <div className="flex-1 h-px bg-parchment-dark" />
        <span className="text-gold text-sm">✦</span>
        <div className="flex-1 h-px bg-parchment-dark" />
      </div>

      {!state.talbiyahStarted && (
        <p className="font-sans text-xs text-muted text-center mb-4">{S.talbiyahReminder}</p>
      )}

      <button
        onClick={() => goToStage(3)}
        className={`w-full py-3.5 font-sans text-sm tracking-widest uppercase transition-colors ${
          state.talbiyahStarted
            ? 'bg-ink text-parchment hover:bg-ink-light'
            : 'bg-parchment-dark text-muted cursor-not-allowed'
        }`}
        disabled={!state.talbiyahStarted}
      >
        {S.proceedToTawaf}
      </button>
    </div>
  )
}
