'use client'

import './SettingsTab.css'

export default function SettingsTab() {
  return (
    <div className="settings-tab">
      <div className="scroll-content">
        <div className="section-header">
          <div className="label">Settings</div>
          <h2 className="heading-large">Customize Your Experience</h2>
        </div>

        {/* Premium Section */}
        <div className="settings-section">
          <div className="section-title">Premium</div>

          <div className="settings-card stomp-surface">
            <div className="setting-row">
              <div className="setting-label">Premium Status</div>
              <div className="setting-value">Free</div>
            </div>

            <button className="stomp-button" style={{ width: '100%', marginTop: '16px' }}>
              UPGRADE TO PREMIUM
            </button>
          </div>
        </div>

        {/* App Settings */}
        <div className="settings-section">
          <div className="section-title">App</div>

          <div className="settings-card stomp-surface">
            <div className="setting-row">
              <div className="setting-label">Theme</div>
              <div className="setting-value">Dark Mode</div>
            </div>
            <div className="divider"></div>
            <div className="setting-row">
              <div className="setting-label">Haptics</div>
              <div className="setting-value">Enabled</div>
            </div>
            <div className="divider"></div>
            <div className="setting-row">
              <div className="setting-label">Notifications</div>
              <div className="setting-value">Enabled</div>
            </div>
          </div>
        </div>

        {/* Data */}
        <div className="settings-section">
          <div className="section-title">Data</div>

          <div className="settings-card stomp-surface">
            <div className="setting-row">
              <div className="setting-label">Total Sessions</div>
              <div className="setting-value">0</div>
            </div>
            <div className="divider"></div>
            <div className="setting-row">
              <div className="setting-label">Total Reps</div>
              <div className="setting-value">0</div>
            </div>
          </div>
        </div>

        {/* About */}
        <div className="settings-section">
          <div className="section-title">About</div>

          <div className="settings-card stomp-surface">
            <div className="setting-row">
              <div className="setting-label">App Version</div>
              <div className="setting-value">1.0.0</div>
            </div>
            <div className="divider"></div>
            <div className="setting-row">
              <div className="setting-label">Build</div>
              <div className="setting-value">1</div>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="settings-footer">
          <div className="footer-text">Built for serious athletes</div>
        </div>
      </div>
    </div>
  )
}
