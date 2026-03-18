'use client'

import { useState } from 'react'
import './LibraryTab.css'

const tricks = [
  {
    name: 'Cork 7',
    sport: 'Freeski Park',
    category: 'Inverted',
    description: 'Flip into 180 rotation',
    cue: 'Drive knees up, spot the cork',
    failure: 'Weak launch, poor flip entry',
    block: 'Fear of inversion',
    level: 'intermediate',
  },
  {
    name: '360',
    sport: 'Freeski Park',
    category: 'Spins',
    description: 'Full rotation in air',
    cue: 'Pop hard, commit rotation early',
    failure: 'Under-rotation, backing out',
    block: 'Fear of overspin',
    level: 'intermediate',
  },
  {
    name: 'Backflip',
    sport: 'Freeski Park',
    category: 'Inverted',
    description: 'Full rotation backwards',
    cue: 'Pop straight up, tuck knees',
    failure: 'Under-rotation, late flip',
    block: 'Loss of reference',
    level: 'intermediate',
  },
  {
    name: 'BMX 360',
    sport: 'BMX',
    category: 'Spins',
    description: 'Full rotation on the bike',
    cue: 'Pop and commit rotation',
    failure: 'Under-rotation, bailing',
    block: 'Spin commitment',
    level: 'intermediate',
  },
  {
    name: 'Tailwhip',
    sport: 'BMX',
    category: 'Tricks',
    description: 'Whip frame under feet, catch',
    cue: 'Quick whip and catch',
    failure: 'Losing bike position',
    block: 'Timing precision',
    level: 'intermediate',
  },
  {
    name: 'Back Tuck',
    sport: 'Aerials',
    category: 'Inverted',
    description: 'Backward flip with tight body',
    cue: 'Tight tuck from takeoff',
    failure: 'Opening up too early',
    block: 'Inversion fear',
    level: 'beginner',
  },
  {
    name: 'Gate Entry',
    sport: 'Ski Racing',
    category: 'Technique',
    description: 'Clean approach and turn',
    cue: 'Early pressure, trust the edge',
    failure: 'Late pressure, defensive',
    block: 'Line commitment',
    level: 'beginner',
  },
  {
    name: 'Mogul Rhythm',
    sport: 'Moguls',
    category: 'Line Work',
    description: 'Consistent absorption',
    cue: 'Attack each bump, stay centered',
    failure: 'Defensive line, tight rhythm',
    block: 'Trust the rhythm',
    level: 'intermediate',
  },
]

export default function LibraryTab() {
  const [search, setSearch] = useState('')
  const [selectedSport, setSelectedSport] = useState<string | null>(null)
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)

  const sports = [...new Set(tricks.map((t) => t.sport))].sort()
  const categories = [...new Set(tricks.map((t) => t.category))].sort()

  const filtered = tricks.filter((trick) => {
    const matchesSearch = !search || trick.name.toLowerCase().includes(search.toLowerCase()) || trick.description.toLowerCase().includes(search.toLowerCase())
    const matchesSport = !selectedSport || trick.sport === selectedSport
    const matchesCategory = !selectedCategory || trick.category === selectedCategory
    return matchesSearch && matchesSport && matchesCategory
  })

  return (
    <div className="library-tab">
      <div className="scroll-content">
        <div className="section-header">
          <div className="label">Trick Library</div>
          <h2 className="heading-large">Learn Your Skills</h2>
        </div>

        {/* Search */}
        <div className="search-box stomp-surface">
          <input
            type="text"
            placeholder="Search tricks..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="search-input"
          />
        </div>

        {/* Sport Filter */}
        <div className="filter-section">
          <div className="label">Sport</div>
          <div className="filter-chips">
            {sports.map((sport) => (
              <button
                key={sport}
                className={`chip ${selectedSport === sport ? 'active' : ''}`}
                onClick={() => setSelectedSport(selectedSport === sport ? null : sport)}
              >
                {sport}
              </button>
            ))}
          </div>
        </div>

        {/* Category Filter */}
        <div className="filter-section">
          <div className="label">Category</div>
          <div className="filter-chips">
            {categories.map((category) => (
              <button
                key={category}
                className={`chip ${selectedCategory === category ? 'active' : ''}`}
                onClick={() => setSelectedCategory(selectedCategory === category ? null : category)}
              >
                {category}
              </button>
            ))}
          </div>
        </div>

        {/* Tricks List */}
        <div className="tricks-list">
          <div className="list-label">{filtered.length} tricks</div>
          {filtered.map((trick) => (
            <div key={trick.name} className="trick-card stomp-surface">
              <div className="trick-header">
                <div>
                  <div className="trick-title">{trick.name}</div>
                  <div className="trick-desc">{trick.description}</div>
                </div>
                <div className="trick-meta">
                  <div className="trick-category">{trick.category}</div>
                  <div className="trick-level">{trick.level}</div>
                </div>
              </div>

              <div className="trick-divider"></div>

              <div className="trick-details">
                <div className="detail-row">
                  <span className="detail-label">Cue:</span>
                  <span className="detail-text" style={{ color: 'var(--accent-light)' }}>{trick.cue}</span>
                </div>
                <div className="detail-row">
                  <span className="detail-label">Failure:</span>
                  <span className="detail-text">{trick.failure}</span>
                </div>
                <div className="detail-row">
                  <span className="detail-label">Block:</span>
                  <span className="detail-text" style={{ color: 'var(--warning)' }}>{trick.block}</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
