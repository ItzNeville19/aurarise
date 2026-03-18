# STOMP - Premium Action-Sport Performance App

**Status**: ✅ Foundation Complete | Ready for Polish & App Store
**Branch**: `claude/build-sports-app-foundation-ZxVYY`
**Commit**: `6ab1c59`

---

## What Is STOMP?

STOMP is a premium iOS app for serious action-sport athletes who struggle with fear, hesitation, backing off, and inconsistency.

**It's not a journal.** It's not a generic motivation app. It's not a cluttered dashboard.

**STOMP is a commitment ritual + session system** that helps athletes:
- Lock in before every rep with psychological clarity
- Commit with intention through the LOCK IN gesture
- Get smart, contextual tips for the next rep
- Track patterns and learn from mistakes
- Stay motivated through pressure and progress
- Feel like the app respects their seriousness

---

## Supported Sports

- Freeski Park
- Freeski Pipe
- Freeski Big Air
- Moguls
- Aerials
- Ski Racing
- BMX
- Trampoline

Each sport has **custom language, custom issues, custom cues, and a full trick library.**

---

## Core Features

### 🔥 Ritual Tab
The emotional center. Before every rep:
- Show current sport and trick
- Display common issue athletes face on this trick
- Show a sharp, sport-specific cue
- Give one accountability line ("No backing off")
- Offer one contextual tip for this exact rep
- Massive LOCK IN button to start the commitment flow

### 🎯 LOCK IN Full-Screen
The intense moment. User must:
- Hold for 2 seconds (creates psychological investment)
- See their sport, trick, and cue in huge typography
- Feel the seriousness through near-black background
- Select outcome after the rep (success, bail, miss, partial, fail)
- Log optional note and issue tag
- Get smart feedback on what happened

### 📊 Session Mode
Real-time rep tracking:
- Live rep counter
- Success rate percentage
- Reverse-chronological rep history
- Quick log button for rapid entries
- End session to save history

### 📈 Progress Tab
Professional analytics:
- **Commitment Rate**: % of reps where you locked in
- **Success Rate**: % of reps sent successfully
- **Consistency Score**: Blend of both (0-100)
- **Streaks**: Commit streak and success streak
- **Session History**: Last 5 sessions with details

### 📚 Trick Library
Searchable, categorized database of ~35 tricks:
- Search by name or description
- Filter by sport and category
- Each trick shows:
  - Name and description
  - How-to cue
  - Common failure point
  - Mental block
  - Progression level

### ⚙️ Settings
- Premium status and subscription management
- App preferences (theme, haptics, notifications)
- Data stats (total sessions, total reps)
- About section

### 💎 Premium Paywall
RevenueCat-ready subscription UI:
- Monthly ($9.99/mo) or Annual ($79.99/yr, save 20%)
- Premium features: unlimited sessions, full library, advanced tips, accountability memory
- Restore purchases

---

## Design Philosophy

### Premium Feel
- Near-black background (#0D0D12)
- High contrast white text
- Vibrant orange accent (#FF5600)
- Generous spacing and breathing room
- Professional typography hierarchy
- Glass morphism surfaces
- Zero clutter, zero cheap effects

### Human Copy
- Direct: "You backed off. Same setup, different result."
- Sharp: "No half-send."
- Serious: "This is the rep that matters."
- No generic cheerleading ("You got this!")
- No robotic language
- Psychologically grounded

### Sport-Specific Customization
Every sport has:
- Custom issue types (what athletes struggle with)
- Custom cues (what works for this sport)
- Custom tricks/skills (real progression levels)
- Custom rep names (trick, run, skill, line, pass)

---

## Architecture

### Tech Stack
- **Language**: Swift 5.9+
- **Framework**: SwiftUI (iOS 17+)
- **Architecture**: MVVM
- **Persistence**: UserDefaults (ready for Realm/Core Data)
- **Dependencies**: None (pure SwiftUI)

### Design System
- Complete color palette (background, surfaces, accent, semantic)
- Complete typography system (display, heading, body, caption, mono)
- Consistent spacing system (4/8/16/24/32/48pt)
- Reusable components (stompSurface, stompButton, etc.)
- Ready for haptics, motion, and animations

### Data Models
- `Sport`: Custom language per sport
- `Trick`: Complete trick definition (~35 entries)
- `Session`: Active session with array of reps
- `Rep`: Single attempt with outcome and metadata
- `AppState`: Single source of truth (MVVM)

### Psychology & Retention
- **Commitment Device**: 2-second LOCK IN gesture creates investment
- **Accountability Memory**: Tracks repeat patterns and issues
- **Contextual Tips**: Smart tips based on sport, trick, outcome, progress
- **Variable Reinforcement**: Streaks and metrics keep users returning
- **Identity Reinforcement**: Copy assumes commitment and seriousness

---

## File Structure

```
Sources/
├── App/
│   └── StompApp.swift              # Main app entry point
├── Core/
│   ├── Models/
│   │   ├── Sport.swift             # 8 sports with custom language
│   │   ├── Trick.swift             # ~35 tricks with full metadata
│   │   ├── Session.swift           # Session and Rep models
│   │   └── AppState.swift          # MVVM state management
│   ├── Theme/
│   │   └── Theme.swift             # Complete design system
│   └── Services/
│       └── TipService.swift        # Smart tip generation
└── Features/
    ├── Root/
    │   └── RootView.swift          # Navigation and tabs
    ├── Ritual/
    │   ├── RitualView.swift        # Main ritual tab
    │   └── LockInFullScreen.swift  # LOCK IN moment
    ├── Session/
    │   └── SessionView.swift       # Active session tracking
    ├── Progress/
    │   └── ProgressView.swift      # Metrics and analytics
    ├── Library/
    │   └── LibraryView.swift       # Searchable trick library
    ├── Settings/
    │   └── SettingsView.swift      # App settings and premium
    └── Paywall/
        └── PaywallView.swift       # RevenueCat-ready paywall
```

---

## What's Included

✅ Complete app structure with 5 tabs
✅ 8 sports with custom language and tricks
✅ ~35 sport-specific tricks with full detail
✅ MVVM architecture with AppState
✅ Premium dark design system
✅ LOCK IN full-screen commitment flow
✅ Real-time session tracking
✅ Progress metrics and streaks
✅ Searchable trick library
✅ RevenueCat-ready paywall
✅ Smart contextual tip system
✅ Accountability memory framework
✅ Professional gamification
✅ Persistent data (UserDefaults)
✅ Complete documentation (ARCHITECTURE.md)

---

## What's Ready for Next Phase

⚠️ Onboarding flow (UI framework ready)
⚠️ Haptics integration (ready for Haptics.swift)
⚠️ Advanced motion (foundation in place)
⚠️ Unit/integration tests (ready to add)
⚠️ Server persistence (structure ready for migration)
⚠️ Advanced analytics charts (metrics ready)
⚠️ Expanded trick library (content model ready)

---

## Quality Standards

### Code Quality ✅
- Clean MVVM architecture
- Reusable components throughout
- Consistent styling system
- Type safety (no force unwraps)
- Proper state management
- Zero third-party complexity

### Design Quality ✅
- Premium dark UI (Apple-level)
- Custom design language throughout
- Consistent spacing and rhythm
- Professional typography
- High contrast and readability
- Zero generic templates

### Content Quality ✅
- 35+ sport-specific tricks
- Real progression levels
- Real failure patterns
- Real mental blocks
- Actionable, sport-specific cues
- Concise, premium language

### UX Quality ✅
- Simple, focused flows
- Fast interactions
- Psychological intensity (LOCK IN)
- Real-time feedback
- Clear visual hierarchy
- Professional, serious tone

---

## How to Build & Run

### Requirements
- Xcode 15+
- iOS 17+ (simulator or device)
- Swift 5.9+

### Build
```bash
# Clone the repo
git clone http://127.0.0.1:45573/git/ItzNeville19/aurarise
cd aurarise

# Checkout the feature branch
git checkout claude/build-sports-app-foundation-ZxVYY

# Open in Xcode
open Stomp.xcodeproj
```

### Run
1. Select an iOS 17+ simulator or device
2. Build and Run (Cmd+R)
3. The app launches in dark mode with the Ritual tab active

---

## Next Steps

### Immediate (Phase 2)
1. Add onboarding flow
2. Integrate Haptics for commits, streaks, outcomes
3. Add smooth motion and animations
4. Refine copy for even sharper tone
5. Build advanced analytics insights

### Short-term (Phase 3)
1. Complete RevenueCat integration
2. Add server persistence (cloud sync)
3. Expand trick library to 100+ entries
4. Add user profiles and preferences
5. Build accountability memory analytics

### Medium-term (Phase 4)
1. App Store submission and optimization
2. Marketing website and landing page
3. Community features (leaderboards, challenges)
4. Apple Watch app
5. Web dashboard

---

## Contact & Support

For issues, questions, or feature requests:
1. Check ARCHITECTURE.md for technical details
2. Review BUILD_SUMMARY.md for what was built
3. Examine the code structure in Sources/

---

## License

Proprietary - STOMP App (ItzNeville19)

---

**Built with premium quality for serious athletes who deserve serious tools.**
