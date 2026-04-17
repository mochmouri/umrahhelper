import { useEffect, useRef } from 'react'

interface UseSwipeOptions {
  onSwipeLeft?: () => void
  onSwipeRight?: () => void
  minDelta?: number
}

export function useSwipe({ onSwipeLeft, onSwipeRight, minDelta = 50 }: UseSwipeOptions) {
  const startXRef = useRef<number | null>(null)
  const startYRef = useRef<number | null>(null)

  useEffect(() => {
    const onDown = (e: PointerEvent) => {
      startXRef.current = e.clientX
      startYRef.current = e.clientY
    }

    const onUp = (e: PointerEvent) => {
      if (startXRef.current === null || startYRef.current === null) return
      const dx = e.clientX - startXRef.current
      const dy = e.clientY - startYRef.current
      startXRef.current = null
      startYRef.current = null

      // Ignore if mostly vertical (scrolling)
      if (Math.abs(dy) > Math.abs(dx)) return
      if (Math.abs(dx) < minDelta) return

      if (dx < 0) onSwipeLeft?.()
      else onSwipeRight?.()
    }

    window.addEventListener('pointerdown', onDown)
    window.addEventListener('pointerup', onUp)
    return () => {
      window.removeEventListener('pointerdown', onDown)
      window.removeEventListener('pointerup', onUp)
    }
  }, [onSwipeLeft, onSwipeRight, minDelta])
}
