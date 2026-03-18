'use client'

import './ProgressTab.css'

export default function ProgressTab() {
  return (
    <div className="progress-tab">
      <div className="scroll-content">
        <div className="section-header">
          <div className="label">Performance</div>
          <h2 className="heading-large">Your Progress</h2>
        </div>

        <div className="metric-grid">
          <div className="metric-card stomp-surface">
            <div className="metric-label">Commitment Rate</div>
            <div className="metric-value" style={{ color: 'var(--accent)' }}>0%</div>
            <div className="metric-subtitle">Reps where you locked in</div>
          </div>

          <div className="metric-card stomp-surface">
            <div className="metric-label">Success Rate</div>
            <div className="metric-value" style={{ color: 'var(--success)' }}>0%</div>
            <div className="metric-subtitle">Reps sent successfully</div>
          </div>

          <div className="metric-card stomp-surface">
            <div className="metric-label">Consistency Score</div>
            <div className="metric-value" style={{ color: 'var(--accent-light)' }}>0</div>
            <div className="metric-subtitle">Commitment + Success</div>
          </div>
        </div>

        <div className="streaks-section">
          <div className="label">Streaks</div>

          <div className="streak-row">
            <div className="streak-card stomp-surface">
              <div className="streak-icon">🔥</div>
              <div className="streak-label">Commit Streak</div>
              <div className="streak-value">0</div>
            </div>

            <div className="streak-card stomp-surface">
              <div className="streak-icon">✓</div>
              <div className="streak-label">Success Streak</div>
              <div className="streak-value">0</div>
            </div>
          </div>
        </div>

        <div className="sessions-section">
          <div className="label">Recent Sessions</div>

          <div className="no-sessions stomp-surface">
            <div style={{ color: 'var(--text-secondary)' }}>No sessions yet</div>
            <div style={{ fontSize: '12px', color: 'var(--text-tertiary)', marginTop: '8px' }}>
              Start tracking from Ritual tab
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
