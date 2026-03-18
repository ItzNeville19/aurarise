# STOMP - Architecture & Design

## Project Overview

STOMP is a premium iOS app for action-sport athletes. It's a ritual, session, and progression system that helps athletes lock in, commit with clarity, and learn their patterns over time.

**Core Philosophy**: Real, premium, custom, launch-ready, psychologically sharp, worth paying for.

## Supported Sports

- Freeski Park
- Freeski Pipe
- Freeski Big Air
- Moguls
- Aerials
- Ski Racing
- BMX
- Trampoline

Each sport has custom language, issue types, cues, and trick/skill libraries.

## Information Architecture

### Main Tabs

1. **Ritual** - The emotional center. Where users lock in before a rep.
2. **Session** - Track active session and log reps in real-time.
3. **Progress** - View metrics, streaks, and performance history.
4. **Library** - Searchable, categorized trick/skill database.
5. **Settings** - Preferences, subscription, app settings.

## Core Data Models

### Sport
- Defines rep names (trick, run, skill, line, pass)
- Common issues specific to sport
- Sample cues

### Trick
- Name, description, category, progression level
- How-to cue, common failure, mental block
- Structured for each sport with ~35 total tricks

### Session
- Active session with sport, trick, and list of reps
- Tracks success rate, rep count
- Persisted to UserDefaults

### Rep
- Single attempt with outcome (success, bail, miss, partial, fail)
- Commitment flag, optional note, optional issue tag
- Timestamp

### AppState
- Centralized state management (MVVM)
- Manages sessions, streaks, progress metrics
- Persistence via UserDefaults

## Design System

### Colors
- **Background**: Near-black (#0D0D12)
- **Surface**: Dark grays for cards and surfaces
- **Accent**: Vibrant orange (#FF5600)
- **Text**: White primary, gray secondary/tertiary

### Typography
- Display sizes for ritual moments (72pt, 56pt, 44pt)
- Heading sizes for sections
- Body sizes for content
- Monospace for numbers and streaks

### Spacing
- Consistent 4pt, 8pt, 16pt, 24pt, 32pt, 48pt system
- Breathing room on all major elements
- Premium use of negative space

### Components
- Reusable stompSurface() modifier for cards
- stompGlassSurface() for glass morphism
- stompButton() and stompSecondaryButton() for actions
- Consistent border radius (8pt, 12pt, 16pt, 20pt)

## Psychology & Retention Layer

### Commitment Device
- Pre-rep LOCK IN screen is the commitment moment
- User must hold for 2 seconds to fully commit
- Creates psychological investment

### Accountability Memory
- App tracks patterns across sessions
- Calls out repeat issues and bailed reps
- "You backed off 3 times in a row" language

### Contextual Tips
- Every rep gets a smart tip based on:
  - Sport and trick
  - Previous outcome
  - Recent issues
  - Session progress
- Tips feel human, sharp, useful, specific

### Streaks & Metrics
- Commit streak: consecutive reps where user locked in
- Success streak: consecutive successful reps
- Consistency score: blend of commitment + success
- Variable reinforcement to keep users returning

## Feature Implementation Details

### Ritual Tab
- Premium dark interface with near-black background
- Shows: sport, active trick, current issue, commitment cue, accountability line, next-rep tip
- LOCK IN button with 2-second hold gesture
- No clutter, maximum focus

### LOCK IN Full-Screen
- Absolute black background (maximum intensity)
- Huge typography (sport, trick, cue)
- Hold-to-commit interaction with progress ring
- Outcome selection (success/bail/miss/partial/fail)
- Post-rep logging with optional note and issue tagging

### Session Mode
- Real-time rep counter
- Success rate percentage
- Rep history with outcomes
- Quick log button for rapid logging
- End session to save history

### Progress Tab
- Commitment rate percentage
- Success rate percentage
- Consistency score
- Separate streaks display
- Recent session history with summaries
- All metrics feel premium and useful

### Library Tab
- Searchable trick database
- Filter by sport and category
- Each trick shows: name, description, category, progression level, cue, common failure, mental block
- ~35 total tricks across all 8 sports
- Premium feel with no fluff

### Settings Tab
- Premium status and upgrade/manage buttons
- App preferences (theme, haptics, notifications)
- Data stats (total sessions, total reps)
- About section

## Premium / Paywall

### Free Tier
- Limited to 5 active focuses/tricks
- Limited session history (last 10 sessions)
- Basic trick library (top tricks only)
- Basic tips without context

### Premium Features
- Unlimited tricks and focuses
- Full session history
- Complete trick library
- Advanced contextual tips
- Accountability memory with patterns
- Premium analytics and insights
- Advanced streaks tracking

### RevenueCat Integration
- Paywall UI with monthly/annual plans
- Entitlement checks before premium features
- Restore purchases capability
- Premium pricing: $9.99/month or $79.99/year

## File Structure

```
Sources/
  App/
    StompApp.swift
  Core/
    Models/
      Sport.swift
      Trick.swift
      Session.swift
      AppState.swift
    Theme/
      Theme.swift
    Services/
      TipService.swift
  Features/
    Root/
      RootView.swift
    Ritual/
      RitualView.swift
      LockInFullScreen.swift
    Session/
      SessionView.swift
    Progress/
      ProgressView.swift
    Library/
      LibraryView.swift
    Settings/
      SettingsView.swift
    Paywall/
      PaywallView.swift
```

## Key Implementation Notes

### MVVM Architecture
- AppState is the single source of truth
- Views observe AppState for reactivity
- Mutations are explicit methods on AppState

### No Third-Party Dependencies
- Pure SwiftUI implementation
- UserDefaults for persistence
- Ready for RevenueCat integration (no code changes needed)

### Haptics & Motion
- Ready for Haptics.swift service
- Motion disabled by default (can be added)
- Foundation for premium polish pass

### Onboarding
- Not yet implemented
- Should show after app installation
- Explain ritual flow and LOCK IN
- Introduce streaks and progress

### Content Management
- Trick library is hardcoded seed data in Trick.swift
- Can be migrated to JSON or server later
- Each sport has ~4-6 tricks currently
- Can expand with additional content

## Next Steps for Polish

1. Copy refinement - make all language sharper, more human
2. Motion enhancements - smooth transitions, subtle animations
3. Haptics integration - tactile feedback for commits, streaks, outcomes
4. Onboarding flow - visual introduction to the ritual
5. Advanced analytics - per-trick performance, sport trends
6. Accountability memory UI - show repeat patterns and insights
7. Advanced paywall copy - athlete-focused, value-driven messaging
8. Testing - unit tests, preview testing, comprehensive UI testing
