import { useUmrah } from '../context/UmrahContext'

interface DoItem {
  text: string
  type: 'do' | 'dont'
}

const DOS_AND_DONTS: DoItem[] = [
  { text: 'Make Ghusl (full body wash) before entering Ihram', type: 'do' },
  { text: 'Men: wear two white unstitched sheets (izaar + rida\')', type: 'do' },
  { text: 'Women: wear modest, loose clothing — any colour', type: 'do' },
  { text: 'Make your Niyyah when you reach the Miqat', type: 'do' },
  { text: 'Clip nails and trim hair before — not permissible after Niyyah', type: 'do' },
  { text: 'No perfume or scented products — after Niyyah', type: 'dont' },
  { text: "Men: no stitched clothing — after Niyyah", type: 'dont' },
  { text: 'No cutting of hair or nails — after Niyyah', type: 'dont' },
  { text: 'No sexual relations — after Niyyah', type: 'dont' },
  { text: 'No hunting or disturbing wildlife', type: 'dont' },
]

export function Stage1BeforeMiqat() {
  const { goToStage } = useUmrah()

  return (
    <div className="min-h-dvh bg-parchment px-6 pt-28 pb-24 max-w-[480px] mx-auto">

      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">Stage 1</p>
        <h2 className="font-serif text-2xl text-ink">Before Miqat</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">
          Prepare your body, your garments, and your intention.
        </p>
      </header>

      {/* Saudia note */}
      <div className="border-l-2 border-gold pl-4 mb-8">
        <p className="font-sans text-sm text-ink-light leading-relaxed">
          <span className="font-medium text-ink">Travelling on Saudia?</span> The cabin crew will announce when you are crossing the Miqat. Be ready in Ihram before boarding, or at least before the announcement.
        </p>
      </div>

      {/* Do's & Don'ts */}
      <section className="mb-10">
        <h3 className="font-serif text-base font-semibold text-ink mb-4">Do's &amp; Don'ts</h3>
        <div className="space-y-3">
          {DOS_AND_DONTS.map((item, i) => (
            <div key={i} className="flex items-start gap-3">
              <div
                className={`flex-shrink-0 mt-0.5 w-5 h-5 flex items-center justify-center text-xs font-bold ${
                  item.type === 'do' ? 'text-green-soft' : 'text-red-soft'
                }`}
                aria-label={item.type === 'do' ? 'Do' : "Don't"}
              >
                {item.type === 'do' ? '✓' : '✕'}
              </div>
              <p
                className={`font-sans text-sm leading-relaxed ${
                  item.type === 'do' ? 'text-ink' : 'text-ink-light'
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
          Once you have made Ghusl and prepared your garments, proceed to the Miqat. You will make your Niyyah and begin reciting the Talbiyah there.
        </p>
        <button
          onClick={() => goToStage(2)}
          className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
        >
          Continue to Miqat →
        </button>
      </div>

    </div>
  )
}
