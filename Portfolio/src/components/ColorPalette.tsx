import { useState, useEffect, memo } from 'react';
import './ColorPalette.css';

interface ColorTheme {
  name: string;
  primary: string;
  primaryDark: string;
  primaryLight: string;
  glow: string;
  glowStrong: string;
}

const colorThemes: ColorTheme[] = [
  {
    name: 'Blue',
    primary: '#3b82f6',
    primaryDark: '#2563eb',
    primaryLight: '#60a5fa',
    glow: 'rgba(59, 130, 246, 0.4)',
    glowStrong: 'rgba(59, 130, 246, 0.6)'
  },
  {
    name: 'Red',
    primary: '#ef4444',
    primaryDark: '#dc2626',
    primaryLight: '#f87171',
    glow: 'rgba(239, 68, 68, 0.4)',
    glowStrong: 'rgba(239, 68, 68, 0.6)'
  },
  {
    name: 'Pink',
    primary: '#ec4899',
    primaryDark: '#db2777',
    primaryLight: '#f9a8d4',
    glow: 'rgba(236, 72, 153, 0.4)',
    glowStrong: 'rgba(236, 72, 153, 0.6)'
  },
  {
    name: 'Purple',
    primary: '#a855f7',
    primaryDark: '#9333ea',
    primaryLight: '#c084fc',
    glow: 'rgba(168, 85, 247, 0.4)',
    glowStrong: 'rgba(168, 85, 247, 0.6)'
  },
  {
    name: 'Green',
    primary: '#10b981',
    primaryDark: '#059669',
    primaryLight: '#34d399',
    glow: 'rgba(16, 185, 129, 0.4)',
    glowStrong: 'rgba(16, 185, 129, 0.6)'
  },
  {
    name: 'Orange',
    primary: '#f97316',
    primaryDark: '#ea580c',
    primaryLight: '#fb923c',
    glow: 'rgba(249, 115, 22, 0.4)',
    glowStrong: 'rgba(249, 115, 22, 0.6)'
  },
  {
    name: 'Yellow',
    primary: '#eab308',
    primaryDark: '#ca8a04',
    primaryLight: '#facc15',
    glow: 'rgba(234, 179, 8, 0.4)',
    glowStrong: 'rgba(234, 179, 8, 0.6)'
  },
  {
    name: 'Cyan',
    primary: '#06b6d4',
    primaryDark: '#0891b2',
    primaryLight: '#22d3ee',
    glow: 'rgba(6, 182, 212, 0.4)',
    glowStrong: 'rgba(6, 182, 212, 0.6)'
  }
];

const ColorPalette = memo(() => {
  const [activeColor, setActiveColor] = useState(0);
  const [isOpen, setIsOpen] = useState(false);

  useEffect(() => {
    // Load saved color preference
    const savedColor = localStorage.getItem('portfolioColorTheme');
    if (savedColor) {
      const colorIndex = colorThemes.findIndex(theme => theme.name === savedColor);
      if (colorIndex !== -1) {
        setActiveColor(colorIndex);
        applyColorTheme(colorThemes[colorIndex]);
      }
    }
  }, []);

  const applyColorTheme = (theme: ColorTheme) => {
    const root = document.documentElement;
    root.style.setProperty('--primary', theme.primary);
    root.style.setProperty('--primary-dark', theme.primaryDark);
    root.style.setProperty('--primary-light', theme.primaryLight);
    root.style.setProperty('--secondary', theme.primary);
    root.style.setProperty('--accent', theme.primaryLight);
    root.style.setProperty('--purple', theme.primary);
    root.style.setProperty('--pink', theme.primaryLight);
    root.style.setProperty('--text-secondary', theme.primary);
    root.style.setProperty('--card-border', `${theme.primary}4d`);
    root.style.setProperty('--border-color', `${theme.primary}1a`);
    root.style.setProperty('--glow', theme.glow);
    root.style.setProperty('--glow-strong', theme.glowStrong);
    root.style.setProperty('--glow-purple', theme.glow);
    root.style.setProperty('--mesh-1', `${theme.primary}14`);
    root.style.setProperty('--mesh-2', `${theme.primary}0f`);
    root.style.setProperty('--mesh-3', `${theme.primary}0a`);
  };

  const handleColorChange = (index: number) => {
    setActiveColor(index);
    const theme = colorThemes[index];
    applyColorTheme(theme);
    localStorage.setItem('portfolioColorTheme', theme.name);
  };

  return (
    <div className="color-palette-container">
      <button 
        className={`palette-toggle ${isOpen ? 'open' : ''}`}
        onClick={() => setIsOpen(!isOpen)}
        aria-label="Toggle color palette"
        title="Change Theme Color"
      >
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M12 2v4M12 18v4M4.93 4.93l2.83 2.83M16.24 16.24l2.83 2.83M2 12h4M18 12h4M4.93 19.07l2.83-2.83M16.24 7.76l2.83-2.83"/>
          <circle cx="12" cy="12" r="5" fill="currentColor" opacity="0.3"/>
        </svg>
      </button>
      
      <div className={`color-palette ${isOpen ? 'open' : ''}`}>
        {colorThemes.map((theme, index) => (
          <button
            key={theme.name}
            className={`color-option ${activeColor === index ? 'active' : ''}`}
            onClick={() => handleColorChange(index)}
            style={{ backgroundColor: theme.primary }}
            aria-label={`Switch to ${theme.name} theme`}
            title={theme.name}
          >
            {activeColor === index && (
              <svg width="12" height="10" viewBox="0 0 12 10" fill="white">
                <path d="M1 5l3 3l7-7" stroke="white" strokeWidth="2" fill="none"/>
              </svg>
            )}
          </button>
        ))}
      </div>
    </div>
  );
});

ColorPalette.displayName = 'ColorPalette';

export default ColorPalette;
