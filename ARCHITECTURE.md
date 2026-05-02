# Architecture

A step-by-step Umrah guide available as a React web app and a native iOS app. Both share the same content, bilingual string system, and feature set, but are built independently — no shared code between them.

---

## Platforms

### Web — `src/`
- **React 19 + TypeScript + Vite**
- **Tailwind CSS v4** for styling
- Deployed to GitHub Pages (`gh-pages` branch) via `npx gh-pages -d dist`
- No backend, no authentication, no analytics

### iOS — `ios/`
- **SwiftUI + SwiftData, iOS 17+**
- **Xcode project** at `ios/UmrahHelper.xcodeproj`
- State managed via `@Observable` `UmrahState` class
- No backend, no authentication, no analytics

---

## Design principles

- **No data collection.** Nothing is sent to a server. All state is local (localStorage on web, in-memory + SwiftData on iOS).
- **No account required.** Open and use immediately.
- **Offline-first.** The iOS app works entirely offline. The web app requires an initial load but functions without signal thereafter (PWA planned).
- **Bilingual.** Every string is defined in both Arabic and English. The user toggles language at any time. Arabic mode switches the layout direction to RTL.

---

## Web app structure

### State — `src/context/UmrahContext.tsx`
Single context holding all app state:
- Navigation: `stage` (0–5), `tawafStarted`, `saiStarted`, etc.
- Timing: `umrahStartTime`, `lapTimes[]`, `roundTimes[]`
- Preferences: `isArabic`, `isDarkMode`, `textScale`
- History: `history: UmrahSession[]` — completed sessions, persisted to `localStorage` under key `umrah-guide-v2`

State is reset via `RESET` (preserves preferences and history) or `SAVE_AND_RESET` (saves current session to history first).

### Routing
No router. Navigation is a single `stage` integer (0–5) in context. `goToStage()` validates transitions and scrolls to top.

### Strings — `src/data/strings.ts`
`getStrings(isArabic: boolean)` returns a typed `Strings` object. All UI text comes from here — no hardcoded English or Arabic anywhere in components. Numeral formatting (`toEasternArabic`) is applied inline for Arabic mode.

### Duas — `src/data/duas.ts`
Typed `Dua` objects `{ arabic, transliteration, meaning, source? }`. Sources are cited only where attribution is certain (e.g. Talbiyah: Bukhari & Muslim; Safa dhikr: Muslim; Quran ayat cite verse).

### Fonts
- **Playfair Display** — serif headings
- **DM Sans** — body/UI text
- **Amiri** — all Arabic text (`font-arabic` class)
All loaded from Google Fonts.

### Dark mode
Toggled by adding/removing `html.dark` class. CSS variables for all colours are overridden in `html.dark {}` in `index.css`.

### Tab bar
Four tabs: Guide / History / Adhkar / About. Implemented as `currentTab` state in `App.tsx` — no router. Keyboard arrow keys and swipe gestures navigate the Guide tab only.

---

## iOS app structure

### State — `ios/UmrahHelper/Context/UmrahState.swift`
`@Observable` class. Same logical state as the web app. Passed down as a `let` prop to all child views (no environment injection — explicit passing keeps the data flow clear).

### Navigation
`ContentView.swift` hosts a `TabView` (Guide / History / Adhkar / About). Within the Guide tab, `state.stage` drives which `StageN` view is shown. Swipe gestures and a back button handle stage transitions.

### Strings — `ios/UmrahHelper/Data/AppStrings.swift`
`AppStrings(isArabic: Bool)` struct with computed `var` properties. Mirrors `strings.ts` exactly. Accessed via `state.strings` in every view.

### Duas — `ios/UmrahHelper/Data/Duas.swift`
`Dua` struct with the same fields as the web. Same sourcing policy.

### Fonts
- **System serif** (`design: .serif`) — headings
- **System default** — body/UI
- **Amiri-Regular.ttf** — bundled in `Resources/Fonts/`, registered via `Info.plist` under `UIAppFonts`. Used in `DuaBlock` via `Font.custom("Amiri-Regular", size:)`.

### Theme — `ios/UmrahHelper/App/Theme.swift`
Colour definitions as `Color` extensions using `UIColor` adaptive initialiser (responds to `UIUserInterfaceStyle`). Dark mode is driven by `.preferredColorScheme(state.isDarkMode ? .dark : .light)` on the root `TabView`. Custom view modifiers: `primaryButton()`, `ghostButton()`. Shared components: `StageHeader`, `SectionDivider`, `GoldBorderNote`, `DuaBlock`, `ChecklistItem`, `MetricsCard`.

### Haptics
`UIImpactFeedbackGenerator` is triggered on key actions:
- `.light` — beginning Tawaf or Sa'i
- `.medium` — completing a lap or round

### App icon
Two 1024×1024 PNGs in `Assets.xcassets/AppIcon.appiconset`:
- `AppIcon-light.png` — white background, gold Kaaba (default)
- `AppIcon-dark.png` — black background, gold Kaaba (iOS 18+ dark mode)

---

## Content structure (both platforms)

| Stage | Screen | Key interactions |
|-------|--------|-----------------|
| 0 | Welcome | Language/dark/text-scale toggles; jump-to-step stepper |
| 1 | Before Miqat | Checklist (wudu, clothing, niyyah); Talbiyah dua |
| 2 | At Miqat | Niyyah; Talbiyah reminder |
| 3 | Tawaf | Black Stone checkbox → lap counter → Yemeni corner checkbox → collapsible dhikr → Complete Lap; Maqam Ibrahim after completion |
| 4 | Sa'i | Safa ayah + dhikr → round counter → green lights dua → Complete Round; metrics on completion |
| 5 | Tahleel | Hair cutting instructions; Congratulations; session metrics; Share summary |

**History tab** — lists all saved sessions with lap/round breakdowns. Sessions can be expanded, shared as text, or deleted.

**Adhkar tab** — standalone collection of general Islamic remembrances, independent of the Umrah flow.

**About tab** — intro (anonymous creator, motivation); donation link (Stripe); share button; Formspree contact form (question / correction / general).

---

## Third-party services

| Service | Purpose | Notes |
|---------|---------|-------|
| Stripe Payment Link | Donations | External URL — bypasses Apple's 30% in-app purchase fee |
| Formspree | Contact form submissions | POSTed as JSON; forwarded to email; no backend needed |
| Google Fonts | Web typography | Playfair Display, DM Sans, Amiri |
| GitHub Pages | Web hosting | Deployed manually: `npm run build && npx gh-pages -d dist` |
