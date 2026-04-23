import type { Dua } from '../data/duas'

interface DuaBlockProps extends Dua {
  compact?: boolean
}

export function DuaBlock({ arabic, transliteration, meaning, source, compact = false }: DuaBlockProps) {
  return (
    <div className={`space-y-3 ${compact ? 'py-3' : 'py-5'} border-b border-parchment-dark last:border-0`}>
      {/* Arabic: always right-aligned, RTL */}
      <p
        lang="ar"
        dir="rtl"
        className={`font-arabic leading-loose text-ink text-right w-full ${compact ? 'text-xl' : 'text-2xl'}`}
        style={{ textAlign: 'right', direction: 'rtl', unicodeBidi: 'isolate' }}
      >
        {arabic}
      </p>
      {/* Transliteration: always left-to-right */}
      <p
        dir="ltr"
        className="font-sans text-xs text-muted italic leading-relaxed text-left"
        style={{ textAlign: 'left', direction: 'ltr', unicodeBidi: 'isolate' }}
      >
        {transliteration}
      </p>
      {/* Meaning: always left-to-right */}
      <p
        dir="ltr"
        className="font-sans text-sm text-ink-light leading-relaxed text-left"
        style={{ textAlign: 'left', direction: 'ltr', unicodeBidi: 'isolate' }}
      >
        {meaning}
      </p>
      {source && (
        <p
          dir="ltr"
          className="font-sans text-xs text-muted text-left"
          style={{ textAlign: 'left', direction: 'ltr', unicodeBidi: 'isolate' }}
        >
          — {source}
        </p>
      )}
    </div>
  )
}
