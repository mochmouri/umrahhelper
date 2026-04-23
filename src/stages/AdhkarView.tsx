import { useUmrah } from '../context/UmrahContext'
import { DuaBlock } from '../components/DuaBlock'
import { adhkarPool } from '../data/adhkar'
import { getStrings } from '../data/strings'

export function AdhkarView() {
  const { state } = useUmrah()
  const S = getStrings(state.isArabic)

  return (
    <div className="min-h-dvh bg-parchment px-6 pt-20 pb-24 max-w-[480px] mx-auto">
      <header className="mb-8">
        <h2 className="font-serif text-2xl text-ink">{S.adhkarNavTitle}</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">{S.adhkarSubtitle}</p>
      </header>
      <div>
        {adhkarPool.map((dua, i) => (
          <DuaBlock key={i} {...dua} />
        ))}
      </div>
    </div>
  )
}
