import { useState, useEffect } from 'react'
import { useUmrah, getTawafMetrics } from '../context/UmrahContext'
import { ChecklistItem } from '../components/ChecklistItem'
import { DuaBlock } from '../components/DuaBlock'
import { MetricsCard } from '../components/MetricsCard'
import { blackStoneDua, maqamIbrahimAyah, yemeniCornerDua } from '../data/duas'
import { getDuasForLap } from '../data/adhkar'
import { getStrings } from '../data/strings'

export function Stage3Tawaf() {
  const { state, dispatch, goToStage } = useUmrah()
  const S = getStrings(state.isArabic)
  const { tawafChecklist, tawafStarted, currentLap } = state

  const [showLapDhikr, setShowLapDhikr] = useState(false)
  const [maqamChecked, setMaqamChecked] = useState(false)

  // Reset collapsible dhikr on lap change
  useEffect(() => {
    setShowLapDhikr(false)
  }, [currentLap])

  const allChecked =
    tawafChecklist.wudu && tawafChecklist.locatedBlackStone && tawafChecklist.raisedHand

  const tawafComplete = currentLap === 8
  const lapReady = state.yemeniCornerChecked && state.blackStonePassChecked

  const lapDuas = tawafStarted && currentLap >= 1 && currentLap <= 7
    ? getDuasForLap(currentLap)
    : []

  const { metrics, total, average } = getTawafMetrics(state)

  return (
    <div
      className="min-h-dvh bg-parchment px-6 pt-6 pb-24 max-w-[480px] mx-auto"
      dir={state.isArabic ? 'rtl' : 'ltr'}
    >
      <header className="mb-8">
        <p className="font-sans text-xs text-gold uppercase tracking-widest mb-1">{S.stage3Number}</p>
        <h2 className="font-serif text-2xl text-ink">{S.stage3Title}</h2>
        <p className="font-sans text-sm text-muted mt-1 leading-relaxed">{S.stage3Subtitle}</p>
      </header>

      {/* ── Pre-Tawaf Checklist ── */}
      {!tawafStarted && (
        <section className="mb-8">
          <h3 className="font-serif text-base font-semibold text-ink mb-4">{S.beforeYouBegin}</h3>
          <div className="space-y-4">
            <ChecklistItem
              label={S.checkWudu}
              checked={tawafChecklist.wudu}
              onChange={(v) => dispatch({ type: 'SET_TAWAF_CHECKLIST', payload: { wudu: v } })}
            />
            <ChecklistItem
              label={S.checkBlackStone}
              checked={tawafChecklist.locatedBlackStone}
              onChange={(v) =>
                dispatch({ type: 'SET_TAWAF_CHECKLIST', payload: { locatedBlackStone: v } })
              }
            />
            <ChecklistItem
              label={S.checkRaisedHand}
              checked={tawafChecklist.raisedHand}
              onChange={(v) =>
                dispatch({ type: 'SET_TAWAF_CHECKLIST', payload: { raisedHand: v } })
              }
            />
          </div>

          {allChecked && (
            <div className="mt-6">
              <h3 className="font-serif text-base font-semibold text-ink mb-3">
                {S.blackStoneDuaTitle}
              </h3>
              <p className="font-sans text-sm text-muted mb-3 leading-relaxed">
                {S.blackStoneDuaBody}
              </p>
              <DuaBlock {...blackStoneDua} />
              <button
                onClick={() => dispatch({ type: 'START_TAWAF' })}
                className="mt-6 w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
              >
                {S.beginTawaf}
              </button>
            </div>
          )}
        </section>
      )}

      {/* ── Active Tawaf ── */}
      {tawafStarted && !tawafComplete && (
        <section className="mb-8">

          {/* 1. Black Stone checkpoint — top of each lap */}
          <div
            className="mb-2"
            style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-gold)', paddingInlineStart: '0.75rem' }}
          >
            <p className="font-sans text-[9px] text-muted uppercase tracking-widest mb-1">
              {S.blackStonePassTitle}
            </p>
            <p className="font-sans text-xs text-ink-light leading-relaxed mb-1">
              {S.blackStonePassBody}
            </p>
            <p
              lang="ar"
              dir="rtl"
              className="font-arabic text-xl text-ink mb-1"
              style={{ textAlign: 'right' }}
            >
              الله أكبر
            </p>
            {!state.isArabic && (
              <p className="font-sans text-xs text-muted italic">Allahu Akbar</p>
            )}
          </div>

          <ChecklistItem
            label={S.checkBlackStonePass}
            checked={state.blackStonePassChecked}
            onChange={(v) => dispatch({ type: 'SET_BLACK_STONE_PASS_CHECKED', payload: v })}
          />

          {/* 2. Lap counter */}
          <div className="text-center py-8 border border-parchment-dark mt-5 mb-5">
            <p className="font-sans text-xs text-muted uppercase tracking-widest mb-1">{S.currentLapLabel}</p>
            <div
              className="flex items-baseline justify-center gap-2"
              dir="ltr"
            >
              {state.isArabic ? (
                <>
                  <span className="font-serif text-7xl text-ink leading-none">
                    {['١','٢','٣','٤','٥','٦','٧'][currentLap - 1] ?? currentLap}
                  </span>
                  <span className="font-serif text-2xl text-muted leading-none">/ ٧</span>
                </>
              ) : (
                <>
                  <span className="font-serif text-7xl text-ink leading-none">{currentLap}</span>
                  <span className="font-serif text-2xl text-muted">/ 7</span>
                </>
              )}
            </div>
            {/* Lap dots */}
            <div className="flex justify-center gap-2 mt-4" dir="ltr">
              {Array.from({ length: 7 }, (_, i) => (
                <div
                  key={i}
                  className={`w-2 h-2 rounded-full ${i < currentLap - 1 ? 'bg-gold' : i === currentLap - 1 ? 'bg-ink' : 'bg-parchment-dark'}`}
                />
              ))}
            </div>
          </div>

          {/* 3. Yemeni corner instruction + checkbox */}
          <div
            className="mb-2"
            style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-gold)', paddingInlineStart: '0.75rem' }}
          >
            <p className="font-sans text-[9px] text-muted uppercase tracking-widest mb-1">
              {S.yemeniCornerTitle}
            </p>
            <p className="font-sans text-xs text-ink-light leading-relaxed mb-3">
              {S.yemeniCornerBody}
            </p>
            <DuaBlock {...yemeniCornerDua} compact />
          </div>

          <ChecklistItem
            label={S.checkYemeniCorner}
            checked={state.yemeniCornerChecked}
            onChange={(v) => dispatch({ type: 'SET_YEMENI_CORNER_CHECKED', payload: v })}
          />

          {/* 4. Collapsible recommended dhikr */}
          <div className="mt-4">
            {lapDuas.length > 0 && (
              <>
                <button
                  onClick={() => setShowLapDhikr(v => !v)}
                  className="w-full flex items-center justify-between py-2 text-left"
                >
                  <span className="font-sans text-xs text-muted tracking-wide">
                    {showLapDhikr ? S.hideDhikr : S.showDhikr(lapDuas.length)}
                  </span>
                  <span className="font-sans text-xs text-muted ml-2">{showLapDhikr ? '▲' : '▼'}</span>
                </button>

                {showLapDhikr && (
                  <div className="mt-2">
                    {lapDuas.map((dua, i) => (
                      <DuaBlock key={i} {...dua} compact />
                    ))}
                    <div
                      className="mt-2 mb-2"
                      style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-parchment-dark)', paddingInlineStart: '0.75rem' }}
                    >
                      <p className="font-sans text-xs text-muted leading-relaxed">{S.tawafAdhkarNote}</p>
                    </div>
                  </div>
                )}
              </>
            )}

            {lapDuas.length === 0 && (
              <div
                style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-parchment-dark)', paddingInlineStart: '0.75rem' }}
              >
                <p className="font-sans text-xs text-muted leading-relaxed">{S.tawafAdhkarNote}</p>
              </div>
            )}
          </div>

          {/* 5. Complete lap button */}
          <div className="mt-4 border-t border-parchment-dark pt-5">
            <button
              onClick={() => dispatch({ type: 'COMPLETE_LAP' })}
              disabled={!lapReady}
              className={`w-full py-4 bg-ink text-parchment font-sans text-sm tracking-widest uppercase transition-colors ${lapReady ? 'hover:bg-ink-light' : 'cursor-not-allowed'}`}
              style={lapReady ? undefined : { opacity: 0.35 }}
            >
              {S.completeLapButton(currentLap)}
            </button>
          </div>
        </section>
      )}

      {/* ── Tawaf complete ── */}
      {tawafComplete && (
        <section className="space-y-8">

          <div className="text-center py-6 border border-parchment-dark">
            <p lang="ar" dir="rtl" className="font-arabic text-2xl text-ink leading-loose text-center">
              الله يتقبل
            </p>
            <p className="font-sans text-sm text-muted mt-1">{S.tawafCompleteMessage}</p>
          </div>

          <MetricsCard
            title={S.tawafTimesTitle}
            metrics={metrics.map((m, i) => ({ ...m, label: S.lapLabel(i) }))}
            total={total}
            average={average}
            averageLabel={S.averageLabel}
            totalLabel={S.totalLabel}
          />

          {/* Maqam Ibrahim */}
          <div>
            <h3 className="font-serif text-base font-semibold text-ink mb-3">{S.maqamTitle}</h3>

            {/* Sunnah note */}
            <div
              className="mb-3"
              style={{ borderInlineStartWidth: '2px', borderInlineStartStyle: 'solid', borderInlineStartColor: 'var(--color-parchment-dark)', paddingInlineStart: '0.75rem' }}
            >
              <p className="font-sans text-xs text-muted leading-relaxed">{S.maqamSunnahNote}</p>
            </div>

            <DuaBlock {...maqamIbrahimAyah} />
            <p className="font-sans text-sm text-ink-light leading-relaxed mt-3">{S.maqamBody}</p>
            <ul className="mt-3 space-y-1.5 font-sans text-sm text-ink-light list-none">
              <li className="flex gap-2">
                <span className="text-gold">·</span>
                <span>{S.raka1Pre} <span className="font-medium text-ink">{S.raka1Surah}</span></span>
              </li>
              <li className="flex gap-2">
                <span className="text-gold">·</span>
                <span>{S.raka2Pre} <span className="font-medium text-ink">{S.raka2Surah}</span></span>
              </li>
            </ul>

            <div className="mt-4">
              <ChecklistItem
                label={S.checkMaqam}
                checked={maqamChecked}
                onChange={setMaqamChecked}
              />
            </div>

            <p className="font-sans text-sm text-ink-light leading-relaxed mt-4">{S.zamzamText}</p>
          </div>

          <button
            onClick={() => goToStage(4)}
            className="w-full py-3.5 bg-ink text-parchment font-sans text-sm tracking-widest uppercase hover:bg-ink-light transition-colors"
          >
            {S.proceedToSai}
          </button>
        </section>
      )}
    </div>
  )
}
