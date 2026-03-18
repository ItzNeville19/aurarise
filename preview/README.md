# STOMP - Web Preview

A browser-based preview of the STOMP iOS app built with Next.js.

## Quick Start

### Install Dependencies
```bash
npm install
```

### Run Development Server
```bash
npm run dev
```

### Open in Browser
```
http://localhost:3000
```

## Features to Try

### 🔥 Ritual Tab
1. Select a sport (Freeski Park, BMX, Moguls, etc.)
2. Select a trick (Cork 7, 360, etc.)
3. Click "START SESSION"
4. Click "LOCK IN" button
5. **Hold for 2 seconds** (watch the progress ring fill)
6. Select outcome (Sent, Partial, Missed, Bailed, Failed)
7. Click "CONTINUE"

### 📚 Library Tab
- **Search**: Type to find tricks
- **Filter by Sport**: Click sport chips to filter
- **Filter by Category**: Click category chips to filter
- **View Details**: Each trick shows cue, common failure, and mental block

### 📈 Progress Tab
- View commitment rate, success rate, consistency score
- See commit and success streaks
- View recent session history

### ⚙️ Settings Tab
- Premium status and upgrade options
- App preferences
- Data statistics

## Design Details

- **Colors**: Dark theme with orange accent (#FF5600)
- **Typography**: Premium hierarchy with large display text
- **Components**: Reusable cards, buttons, chips
- **Responsive**: Works on desktop, tablet, mobile

## Technical Stack

- **Next.js 14**: React framework
- **TypeScript**: Type safety
- **CSS Modules**: Component styling
- **No dependencies**: Pure React and Next.js

## File Structure

```
preview/
├── app/
│   ├── layout.tsx           # Root layout
│   ├── page.tsx             # Main app with tabs
│   ├── globals.css          # Design system
│   ├── app.css              # Layout styles
│   └── components/
│       ├── RitualTab.tsx
│       ├── SessionTab.tsx
│       ├── ProgressTab.tsx
│       ├── LibraryTab.tsx
│       ├── SettingsTab.tsx
│       ├── LockInScreen.tsx
│       └── [component].css
├── package.json
├── next.config.js
└── tsconfig.json
```

## Building

```bash
npm run build
npm start
```

---

**This is a preview only.** The full SwiftUI iOS app is in the parent directory with all backend logic, persistence, and RevenueCat integration ready.
