'use client'

import { useState, useEffect } from 'react'
import './LockInScreen.css'

interface LockInScreenProps {
  onDismiss: () => void
  sport: string
  trick: string
}

export default function LockInScreen({ onDismiss, sport, trick }: LockInScreenProps) {
  const [phase, setPhase] = useState<'hold' | 'outcome'>('hold')
  const [holdProgress, setHoldProgress] = useState(0)
  const [isHolding, setIsHolding] = useState(false)
  const [selectedOutcome, setSelectedOutcome] = useState<string | null>(null)

  const holdDuration = 2000

  useEffect(() => {
    if (!isHolding) return

    let animationId: number
    let startTime = Date.now()

    const animate = () => {
      const elapsed = Date.now() - startTime
      const progress = Math.min(elapsed / holdDuration, 1)
      setHoldProgress(progress)

      if (progress < 1) {
        animationId = requestAnimationFrame(animate)
      } else {
        setPhase('outcome')
      }
    }

    animationId = requestAnimationFrame(animate)
    return () => cancelAnimationFrame(animationId)
  }, [isHolding])

  const handleMouseDown = () => {
    setIsHolding(true)
  }

  const handleMouseUp = () => {
    setIsHolding(false)
    if (holdProgress < 1) {
      setHoldProgress(0)
    }
  }

  const outcomes = [
    { label: 'Sent', emoji: '✓', value: 'success', color: 'var(--success)' },
    { label: 'Partial', emoji: '~', value: 'partial', color: 'var(--warning)' },
    { label: 'Missed', emoji: '–', value: 'miss', color: 'var(--text-secondary)' },
    { label: 'Bailed', emoji: '✗', value: 'bail', color: 'var(--failure)' },
    { label: 'Failed', emoji: '!', value: 'fail', color: 'var(--failure)' },
  ]

  return (
    <div className="lock-in-screen">
      <button className="close-button" onClick={onDismiss}>
        ✕
      </button>

      {phase === 'hold' && (
        <div className="lock-in-content">
          <div className="lock-in-text-section">
            <div className="sport-label">{sport}</div>
            <div className="trick-title">{trick}</div>
            <div className="cue-text">No backing off.</div>
          </div>

          <div className="hold-container">
            <div className="hold-circle" onMouseDown={handleMouseDown} onMouseUp={handleMouseUp} onMouseLeave={handleMouseUp}>
              <svg className="progress-ring" viewBox="0 0 200 200">
                <circle
                  cx="100"
                  cy="100"
                  r="90"
                  fill="none"
                  stroke="var(--surface-secondary)"
                  strokeWidth="3"
                />
                <circle
                  cx="100"
                  cy="100"
                  r="90"
                  fill="none"
                  stroke="var(--accent)"
                  strokeWidth="3"
                  strokeDasharray={`${565 * holdProgress} 565`}
                  strokeLinecap="round"
                  style={{ transform: 'rotate(-90deg)', transformOrigin: '50% 50%' }}
                />
              </svg>
              <div className="hold-text">
                <div className="hold-label">HOLD</div>
                <div className="hold-action">LOCK IN</div>
              </div>
            </div>
          </div>

          <div className="hold-instruction">Hold for 2 seconds</div>
        </div>
      )}

      {phase === 'outcome' && (
        <div className="outcome-content">
          <div className="outcome-header">What happened?</div>

          <div className="outcome-buttons">
            {outcomes.map((outcome) => (
              <button
                key={outcome.value}
                className={`outcome-button ${selectedOutcome === outcome.value ? 'active' : ''}`}
                onClick={() => setSelectedOutcome(outcome.value)}
              >
                <div className="outcome-emoji" style={{ color: outcome.color }}>
                  {outcome.emoji}
                </div>
                <div className="outcome-label">{outcome.label}</div>
                {selectedOutcome === outcome.value && <div className="outcome-check">✓</div>}
              </button>
            ))}
          </div>

          {selectedOutcome && (
            <button className="stomp-button continue-button" onClick={onDismiss}>
              CONTINUE
            </button>
          )}
        </div>
      )}
    </div>
  )
}
