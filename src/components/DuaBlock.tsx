import type { Dua } from '../data/duas'

interface DuaBlockProps extends Dua {
  compact?: boolean
}

export function DuaBlock({ arabic, transliteration, meaning, source, compact = false }: DuaBlockProps) {
  return (
    <div className={`space-y-3 ${compact ? 'py-3' : 'py-5'} border-b border-parchment-dark last:border-0`}>
      <p
        lang="ar"
        className={`font-arabic leading-loose text-ink text-right ${compact ? 'text-xl' : 'text-2xl'}`}
        dir="rtl"
      >
        {arabic}
      </p>
      <p className="font-sans text-xs text-muted italic leading-relaxed">
        {transliteration}
      </p>
      <p className="font-sans text-sm text-ink-light leading-relaxed">
        {meaning}
      </p>
      {source && (
        <p className="font-sans text-xs text-muted">— {source}</p>
      )}
    </div>
  )
}
