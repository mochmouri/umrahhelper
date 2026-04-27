import { useState } from 'react'
import { useUmrah } from '../context/UmrahContext'
import { getStrings } from '../data/strings'

// ── Replace these with your real URLs ────────────────────────────────────────
const DONATION_URL = 'https://buy.stripe.com/eVq9AT6003aAbj2fCs1oI00'
const APP_URL = 'https://mochmouri.github.io/umrahhelper/'
const FORMSPREE_ENDPOINT = 'https://formspree.io/f/xrerwzle'
// ─────────────────────────────────────────────────────────────────────────────

type MessageType = 'question' | 'correction' | 'general'
type SendState = 'idle' | 'sending' | 'success' | 'error'

export function AboutView() {
  const { state } = useUmrah()
  const S = getStrings(state.isArabic)

  const [shareCopied, setShareCopied] = useState(false)
  const [msgType, setMsgType] = useState<MessageType>('general')
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [message, setMessage] = useState('')
  const [sendState, setSendState] = useState<SendState>('idle')

  const handleShare = async () => {
    if (navigator.share) {
      try { await navigator.share({ title: 'Umrah Guide', url: APP_URL }) } catch { /* cancelled */ }
    } else {
      await navigator.clipboard.writeText(APP_URL)
      setShareCopied(true)
      setTimeout(() => setShareCopied(false), 2500)
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!message.trim()) return
    setSendState('sending')
    try {
      const res = await fetch(FORMSPREE_ENDPOINT, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
        body: JSON.stringify({
          type: msgType,
          name: name || '(not provided)',
          email: email || '(not provided)',
          message,
        }),
      })
      if (res.ok) {
        setSendState('success')
        setName('')
        setEmail('')
        setMessage('')
        setMsgType('general')
      } else {
        setSendState('error')
      }
    } catch {
      setSendState('error')
    }
  }

  const inputClass = `w-full bg-transparent border border-parchment-dark px-3 py-2.5 font-sans text-sm text-ink placeholder:text-muted focus:outline-none focus:border-ink-light transition-colors`

  return (
    <div
      className="min-h-dvh bg-parchment px-6 pt-20 pb-28 max-w-[480px] mx-auto"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >

      {/* ── Intro ── */}
      <section className="mb-10">
        <h2 className="font-serif text-xl text-ink mb-3">{S.aboutIntroTitle}</h2>
        <p className="font-sans text-sm text-ink-light leading-relaxed">{S.aboutIntroBody}</p>
      </section>

      <div className="flex items-center gap-3 mb-10">
        <div className="flex-1 h-px bg-parchment-dark" />
        <span className="text-gold">✦</span>
        <div className="flex-1 h-px bg-parchment-dark" />
      </div>

      {/* ── Free / Donation ── */}
      <section className="mb-10">
        <h2 className="font-serif text-xl text-ink mb-3">{S.aboutFreeTitle}</h2>
        <p className="font-sans text-sm text-ink-light leading-relaxed mb-5">{S.aboutFreeBody}</p>
        <a
          href={DONATION_URL}
          target="_blank"
          rel="noopener noreferrer"
          className="inline-block w-full text-center py-3 border border-gold text-gold font-sans text-sm tracking-widest uppercase hover:bg-gold/10 transition-colors"
        >
          {S.aboutDonateButton}
        </a>
      </section>

      <div className="flex items-center gap-3 mb-10">
        <div className="flex-1 h-px bg-parchment-dark" />
        <span className="text-gold">✦</span>
        <div className="flex-1 h-px bg-parchment-dark" />
      </div>

      {/* ── Share ── */}
      <section className="mb-10">
        <h2 className="font-serif text-xl text-ink mb-3">{S.aboutShareTitle}</h2>
        <p className="font-sans text-sm text-ink-light leading-relaxed mb-5">{S.aboutShareBody}</p>
        <button
          onClick={handleShare}
          className="w-full py-3 border border-parchment-dark text-ink font-sans text-sm tracking-widest uppercase hover:border-ink-light transition-colors"
        >
          {shareCopied ? S.aboutShareCopied : S.aboutShareButton}
        </button>
        <p className="font-sans text-xs text-muted mt-2 text-center">{APP_URL}</p>
      </section>

      <div className="flex items-center gap-3 mb-10">
        <div className="flex-1 h-px bg-parchment-dark" />
        <span className="text-gold">✦</span>
        <div className="flex-1 h-px bg-parchment-dark" />
      </div>

      {/* ── Contact form ── */}
      <section>
        <h2 className="font-serif text-xl text-ink mb-3">{S.aboutContactTitle}</h2>
        <p className="font-sans text-sm text-ink-light leading-relaxed mb-6">{S.aboutContactBody}</p>

        {sendState === 'success' ? (
          <div className="border border-parchment-dark bg-parchment-dark/40 px-5 py-6 text-center">
            <p className="font-sans text-sm text-ink">{S.aboutContactSuccess}</p>
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4">

            {/* Message type */}
            <div>
              <p className="font-sans text-xs text-muted uppercase tracking-wide mb-2">{S.aboutContactType}</p>
              <div className="flex gap-2">
                {(['question', 'correction', 'general'] as MessageType[]).map(t => (
                  <button
                    key={t}
                    type="button"
                    onClick={() => setMsgType(t)}
                    className={`flex-1 py-2 font-sans text-xs border transition-colors ${
                      msgType === t
                        ? 'border-ink text-ink bg-ink/5'
                        : 'border-parchment-dark text-muted hover:border-ink-light'
                    }`}
                  >
                    {t === 'question' ? S.aboutTypeQuestion : t === 'correction' ? S.aboutTypeCorrection : S.aboutTypeGeneral}
                  </button>
                ))}
              </div>
            </div>

            <input
              type="text"
              value={name}
              onChange={e => setName(e.target.value)}
              placeholder={S.aboutContactName}
              className={inputClass}
            />

            <input
              type="email"
              value={email}
              onChange={e => setEmail(e.target.value)}
              placeholder={S.aboutContactEmail}
              className={inputClass}
            />

            <textarea
              value={message}
              onChange={e => setMessage(e.target.value)}
              placeholder={S.aboutContactMessage}
              rows={5}
              required
              className={`${inputClass} resize-none`}
            />

            {sendState === 'error' && (
              <p className="font-sans text-xs text-red-soft">{S.aboutContactError}</p>
            )}

            <button
              type="submit"
              disabled={sendState === 'sending' || !message.trim()}
              className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
            >
              {sendState === 'sending' ? S.aboutContactSending : S.aboutContactSend}
            </button>
          </form>
        )}
      </section>
    </div>
  )
}
