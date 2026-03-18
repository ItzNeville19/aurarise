'use client'

import { useState } from 'react'
import RitualTab from './components/RitualTab'
import SessionTab from './components/SessionTab'
import ProgressTab from './components/ProgressTab'
import LibraryTab from './components/LibraryTab'
import SettingsTab from './components/SettingsTab'
import './app.css'

export default function Home() {
  const [activeTab, setActiveTab] = useState('ritual')

  const tabs = [
    { id: 'ritual', label: 'Ritual', icon: '🔥' },
    { id: 'session', label: 'Session', icon: '🎯' },
    { id: 'progress', label: 'Progress', icon: '📈' },
    { id: 'library', label: 'Library', icon: '📚' },
    { id: 'settings', label: 'Settings', icon: '⚙️' },
  ]

  return (
    <div className="app-container">
      {/* Content Area */}
      <div className="content-area">
        {activeTab === 'ritual' && <RitualTab />}
        {activeTab === 'session' && <SessionTab />}
        {activeTab === 'progress' && <ProgressTab />}
        {activeTab === 'library' && <LibraryTab />}
        {activeTab === 'settings' && <SettingsTab />}
      </div>

      {/* Tab Bar */}
      <div className="tab-bar">
        <div className="tab-divider"></div>
        <div className="tabs-container">
          {tabs.map((tab) => (
            <button
              key={tab.id}
              className={`tab-item ${activeTab === tab.id ? 'active' : ''}`}
              onClick={() => setActiveTab(tab.id)}
            >
              <div className="tab-icon">{tab.icon}</div>
              <div className="tab-label">{tab.label}</div>
            </button>
          ))}
        </div>
      </div>
    </div>
  )
}
