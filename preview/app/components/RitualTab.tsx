'use client'

import { useState } from 'react'
import LockInScreen from './LockInScreen'
import './RitualTab.css'

const sports = [
  'Freeski Park',
  'Freeski Pipe',
  'Freeski Big Air',
  'Moguls',
  'Aerials',
  'Ski Racing',
  'BMX',
  'Trampoline',
]

const tricks = {
  'Freeski Park': ['180', '360', '540', 'Cork 7', 'Backflip', 'Double Flip'],
  'Freeski Pipe': ['Air to Fakie', '540 Air', 'Invert', 'McTwist'],
  'Freeski Big Air': ['Switch 7', 'Double Cork', '1080 Grab', 'Backflip 540'],
  'Moguls': ['Mogul Rhythm', 'Mogul Air', 'Zipper Line'],
  'Aerials': ['Back Tuck', 'Back Full', 'Barani', 'Double Back'],
  'Ski Racing': ['Gate Entry', 'GS Line', 'Rhythm Gate Set'],
  'BMX': ['360', 'Tailwhip', '360 Tailwhip', 'Flair'],
  'Trampoline': ['Back Tuck', 'Back Full', 'Double Back'],
}

const issues = {
  'Freeski Park': ['speed check', 'backing off at lip', 'late pop', 'under-commitment'],
  'Freeski Pipe': ['speed check', 'weak air grab', 'backing off'],
  'Moguls': ['defensive line', 'broken rhythm', 'hesitation'],
  'Aerials': ['fear of inversion', 'weak set', 'pulling out'],
  'Ski Racing': ['defensive skiing', 'late pressure', 'tight line'],
  'BMX': ['pulling out', 'freezing mid-line', 'bailing on spin'],
  'Trampoline': ['weak set', 'pulling out', 'inconsistent landings'],
}

export default function RitualTab() {
  const [selectedSport, setSelectedSport] = useState('Freeski Park')
  const [selectedTrick, setSelectedTrick] = useState('Cork 7')
  const [showLockIn, setShowLockIn] = useState(false)
  const [sessionActive, setSessionActive] = useState(false)

  const currentTricks = tricks[selectedSport as keyof typeof tricks] || []
  const currentIssue = issues[selectedSport as keyof typeof issues]?.[0] || 'commitment'

  const handleStartSession = () => {
    setSessionActive(true)
  }

  if (showLockIn && sessionActive) {
    return <LockInScreen onDismiss={() => setShowLockIn(false)} sport={selectedSport} trick={selectedTrick} />
  }

  if (sessionActive) {
    return (
      <div className="ritual-active-session">
        <div className="scroll-content">
          <div className="ritual-header">
            <div className="sport-label">ACTIVE SESSION</div>
            <h1 className="display-medium">{selectedSport}</h1>
          </div>

          <div className="ritual-section">
            <div className="trick-card stomp-surface">
              <div className="trick-name">{selectedTrick}</div>
              <div className="trick-category">Spins • Advanced</div>
            </div>
          </div>

          <div className="ritual-section">
            <div className="label">Current Issue</div>
            <div className="stomp-surface">
              <div className="issue-text">{currentIssue}</div>
            </div>
          </div>

          <div className="ritual-section">
            <div className="label">Your Commitment</div>
            <div className="stomp-glass-surface">
              <div className="commitment-text">No backing off. Send it with intention.</div>
            </div>
          </div>

          <div className="ritual-section">
            <div className="label">This Rep</div>
            <div className="stomp-surface">
              <div className="tip-text">Commit before the lip. Finish rotation. Trust the air.</div>
            </div>
          </div>

          <div className="stats-row">
            <div className="stat-card stomp-surface">
              <div className="stat-label">Reps</div>
              <div className="stat-value">0</div>
            </div>
            <div className="stat-card stomp-surface">
              <div className="stat-label">Success Rate</div>
              <div className="stat-value" style={{ color: 'var(--success)' }}>0%</div>
            </div>
          </div>

          <button className="stomp-button lock-in-button" onClick={() => setShowLockIn(true)}>
            LOCK IN
          </button>

          <button className="stomp-secondary-button" onClick={() => setSessionActive(false)}>
            END SESSION
          </button>
        </div>
      </div>
    )
  }

  return (
    <div className="ritual-setup">
      <div className="scroll-content">
        <div className="ritual-header">
          <div className="stomp-title">STOMP</div>
          <div className="stomp-subtitle">Lock in before you go</div>
        </div>

        <div className="ritual-section">
          <div className="label">Select Sport</div>
          <div className="sport-grid">
            {sports.map((sport) => (
              <button
                key={sport}
                className={`sport-button ${selectedSport === sport ? 'active' : ''}`}
                onClick={() => {
                  setSelectedSport(sport)
                  setSelectedTrick(tricks[sport as keyof typeof tricks][0])
                }}
              >
                {sport}
              </button>
            ))}
          </div>
        </div>

        <div className="ritual-section">
          <div className="label">Select Trick / Focus</div>
          <div className="tricks-list">
            {currentTricks.map((trick) => (
              <button
                key={trick}
                className={`trick-button ${selectedTrick === trick ? 'active' : ''}`}
                onClick={() => setSelectedTrick(trick)}
              >
                <div className="trick-info">
                  <div className="trick-name">{trick}</div>
                  <div className="trick-desc">Advanced technique</div>
                </div>
                {selectedTrick === trick && <div className="checkmark">✓</div>}
              </button>
            ))}
          </div>
        </div>

        <button className="stomp-button start-button" onClick={handleStartSession}>
          START SESSION
        </button>
      </div>
    </div>
  )
}
