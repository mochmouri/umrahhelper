# Initial build — 2026-04-17

## What was done

Full Vite + React + TypeScript + Tailwind CSS v4 SPA for the Umrah Guide project. Six screens (stages 0–5), state in a React context with localStorage persistence, swipe and keyboard navigation.

### Stages
- **0 — Welcome**: Arabic title, description, Begin button, clickable stepper
- **1 — Before Miqat**: Do's & Don'ts grid, Saudia note
- **2 — At Miqat**: Niyyah dua, Talbiyah dua + toggle, Entering Mosque dua, gates Tawaf stage on toggle
- **3 — Tawaf**: 3-item checklist, Black Stone dua, 7-lap counter with progress dots, rotating adhkar from جوامع الدعاء pool (2 per lap), Yemeni corner reminder, Maqam Ibrahim section, metrics card
- **4 — Saʿi**: Safa ayah, opening dhikr, 7-round counter, endpoint dhikr reminder, metrics card
- **5 — Tahleel**: Hair-cutting instructions, congratulations block, full summary metrics, Start Over

### Architecture decisions
- **Tailwind v4** was installed by the scaffolder (not v3). Used `@tailwindcss/vite` plugin and `@theme {}` CSS block instead of `tailwind.config.js`. Custom tokens: `--color-gold`, `--color-parchment`, `--font-arabic`, etc.
- **Stage split**: The spec's single "Stage 1 — Before Miqat" was split into two screens (BeforeMiqat + AtMiqat) to match the stepper items and give 5 named stages (1–5) on the progress bar.
- **Gating**: At Miqat stage gates the Tawaf button behind the Talbiyah toggle. Tawaf gates the lap counter behind the 3-item checklist. Both pieces of state are persisted.
- **Swipe handler** ignores vertical-dominant drags to avoid interfering with scrolling; uses `pointerdown/pointerup` rather than touch events so it works on both touch and mouse.
- **Adhkar rotation**: pool of 21 duas from جوامع الدعاء, 2 shown per lap, index = `((lap-1)*2) % poolLength`.

## What was considered but rejected

- **Routing library (React Router)**: not needed — stage index in context is sufficient for a linear 6-screen flow.
- **Animation between stages**: skipped to keep bundle small and avoid complexity. Could be added with a simple CSS slide using a key-based transition.
- **Tailwind v3 downgrade**: staying on v4 — it's what the scaffolder installed and the API difference is minor (CSS-based config instead of JS).
- **Storing all state in URL**: would break on refresh without further encoding, and adds no UX benefit for this kind of private companion app.

## To deploy to GitHub Pages

1. Create a GitHub repo named `umrahhelper`
2. `npm run build`
3. Push the `dist/` folder to the `gh-pages` branch (or use the `gh-pages` npm package)

The `base: '/umrahhelper/'` is already set in `vite.config.ts`.
