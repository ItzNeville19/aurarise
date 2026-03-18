'use client'

import './SessionTab.css'

export default function SessionTab() {
  return (
    <div className="session-tab">
      <div className="scroll-content">
        <div className="section-header">
          <div className="label">Active Session</div>
          <h2 className="heading-large">No Active Session</h2>
        </div>

        <div className="empty-state">
          <div className="empty-icon">🎯</div>
          <div className="empty-title">No active session</div>
          <div className="empty-subtitle">Start a session from the Ritual tab to begin tracking</div>
        </div>

        <button className="stomp-button" style={{ marginTop: '32px' }}>
          GO TO RITUAL
        </button>

        <div className="info-card stomp-surface">
          <div className="info-title">How STOMP Works</div>
          <div className="info-text">
            1. Select your sport and trick in Ritual tab<br/>
            2. Press LOCK IN to start commitment<br/>
            3. Perform your rep<br/>
            4. Log outcome (sent, bailed, missed, etc)<br/>
            5. View progress and patterns
          </div>
        </div>
      </div>
    </div>
  )
}
