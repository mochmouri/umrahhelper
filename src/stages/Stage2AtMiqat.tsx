import { useUmrah } from '../context/UmrahContext'
import { DuaBlock } from '../components/DuaBlock'
import { niyyah, talbiyah, enteringMosque } from '../data/duas'

export function Stage2AtMiqat() {
  const { state, dispatch, goToStage } = useUmrah()

  return (
    <div className="min-h-dvh bg-parchment px-6 pt-28 pb-24 max-w-[480px] mx-auto">

      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">Stage 2</p>
        <h2 className="font-serif text-2xl text-ink">At the Miqat</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">
          The moment you make Niyyah, Ihram begins.
        </p>
      </header>

      {/* Niyyah */}
      <section className="mb-8">
        <h3 className="font-serif text-base font-semibold text-ink mb-1">Niyyah — The Intention</h3>
        <p className="font-sans text-sm text-muted mb-4 leading-relaxed">
          Face the Qibla, put on your Ihram garments if not already wearing them, and make this intention with your heart. Say it aloud.
        </p>
        <DuaBlock {...niyyah} />
      </section>

      {/* Talbiyah */}
      <section className="mb-8">
        <h3 className="font-serif text-base font-semibold text-ink mb-1">Talbiyah</h3>
        <p className="font-sans text-sm text-muted mb-4 leading-relaxed">
          Begin reciting the Talbiyah immediately after Niyyah. Continue reciting it — loudly for men, softly for women — until you begin Tawaf.
        </p>
        <DuaBlock {...talbiyah} />

        {/* Toggle */}
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
          {state.talbiyahStarted ? '✓ I have started reciting' : 'Mark as started'}
        </button>
      </section>

      {/* Entering the Mosque */}
      <section className="mb-8">
        <h3 className="font-serif text-base font-semibold text-ink mb-1">Entering Al-Masjid Al-Haraam</h3>
        <p className="font-sans text-sm text-muted mb-4 leading-relaxed">
          Enter with your <span className="text-ink font-medium">right foot first</span>. Say this dua as you step inside. When you first see the Ka'bah, pause — this is a moment when duas are answered.
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
        <p className="font-sans text-xs text-muted text-center mb-4">
          Mark the Talbiyah as started before proceeding.
        </p>
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
        Proceed to Tawaf →
      </button>

    </div>
  )
}
