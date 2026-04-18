# Umrah Helper — iOS

SwiftUI app for iPhone and iPad. Mirrors the web guide at `/` with a native iOS experience and local session history via SwiftData.

## Requirements

| Tool | Version |
|------|---------|
| Xcode | 15 or later |
| iOS deployment target | 17.0+ |
| macOS (to build) | 13.5 Ventura or later |

## Opening the project

1. Clone the repo (if you haven't already):
   ```bash
   git clone https://github.com/mochmouri/umrahhelper.git
   cd umrahhelper/ios
   ```

2. Open in Xcode:
   ```bash
   open UmrahHelper.xcodeproj
   ```
   Or double-click `UmrahHelper.xcodeproj` in Finder.

## Running on a physical device (free Apple ID)

A free Apple Developer account (your regular Apple ID) lets you install the app on your own device via Xcode. You do **not** need a paid account for this.

1. Connect your iPhone or iPad via USB.
2. In Xcode, click the device selector at the top and choose your device.
3. Sign in with your Apple ID: **Xcode → Settings → Accounts → add your Apple ID**.
4. In the project navigator, select the **UmrahHelper** target. Under **Signing & Capabilities**, tick **Automatically manage signing** and select your Personal Team.
5. Press **⌘R** to build and run.
6. On your device, go to **Settings → General → VPN & Device Management** and trust your developer certificate.

> Free accounts require re-signing every 7 days. The $99/yr Apple Developer Program removes this limit and unlocks App Store distribution.

## Submitting to the App Store

1. Enrol at [developer.apple.com](https://developer.apple.com) ($99/yr).
2. In Xcode, set your **Team** to your paid developer account under Signing & Capabilities.
3. Archive the app: **Product → Archive**.
4. In the Organiser, click **Distribute App → App Store Connect → Upload**.
5. Complete the App Store listing at [appstoreconnect.apple.com](https://appstoreconnect.apple.com).

## Project structure

```
ios/
  UmrahHelper.xcodeproj/     Xcode project file
  UmrahHelper/
    App/
      UmrahHelperApp.swift   Entry point, SwiftData container
      ContentView.swift      Tab bar + stage router + swipe navigation
      Theme.swift            Colour tokens, shared view modifiers
    Context/
      UmrahState.swift       @Observable state class, UserDefaults persistence
    Data/
      Duas.swift             All named dua constants
      Adhkar.swift           Rotating adhkar pool + getDuasForLap()
      UmrahSession.swift     SwiftData model for completed sessions
    Stages/
      Stage0Welcome.swift    Welcome screen with stepper
      Stage1BeforeMiqat.swift  Do's & Don'ts, Saudia note
      Stage2AtMiqat.swift    Niyyah, Talbiyah toggle, Mosque dua
      Stage3Tawaf.swift      Checklist, lap counter, adhkar, metrics
      Stage4Sai.swift        Round counter, endpoint dhikr, metrics
      Stage5Tahleel.swift    Hair cutting, congratulations, summary, history save
    Components/
      UmrahProgressBar.swift 5-segment gold progress bar
      DuaBlock.swift         Arabic + transliteration + meaning block
      ChecklistItem.swift    Square checkbox
      MetricsCard.swift      Per-lap/round timing breakdown
    History/
      HistoryView.swift      List of past sessions
      SessionDetailView.swift Full breakdown for one session
    Assets.xcassets/
```

## Design notes

- Parchment background `#FAF7F2`, ink `#1A1A1A`, gold `#C9A84C` — matching the web app.
- Headings use the iOS system serif (New York / Georgia).
- Arabic text uses the built-in system font (San Francisco handles Arabic natively). For a more calligraphic look, bundle Amiri Regular ([download](https://fonts.google.com/specimen/Amiri)), add it to the target, declare it in Info.plist under `Fonts provided by application`, then change the `font` in `DuaBlock.swift` to `Font.custom("Amiri-Regular", size: arabicSize)`.
- Swipe left/right to navigate between stages. SwiftUI's native `DragGesture` naturally prioritises button taps, so there is no tap/swipe conflict.
- Session history is stored locally via SwiftData — no account or internet required.
