import { useEffect, useState, useCallback, useMemo, memo } from 'react'
import './App.css'
import HeroSection from './components/HeroSection'
import SkillsSection from './components/SkillsSection'
import EducationSection from './components/EducationSection'
import ContactSection from './components/ContactSection'
import FooterSection from './components/FooterSection'
import ColorPalette from './components/ColorPalette'

// Memoized NavigationDot component
const NavigationDot = memo(({ index, isActive, onClick }: { index: number; isActive: boolean; onClick: () => void }) => (
  <button
    className={`dot ${isActive ? 'active' : ''}`}
    onClick={onClick}
    aria-label={`Go to section ${index + 1}`}
  />
))

NavigationDot.displayName = 'NavigationDot'

function App() {
  const [activeSection, setActiveSection] = useState(0)
  
  // Cache the sections array
  const sections = useMemo(() => [0, 1, 2, 3], [])

  // Throttled scroll handler for performance
  const handleScroll = useCallback(() => {
    const sections = document.querySelectorAll('.section')
    const scrollPos = window.scrollY + window.innerHeight / 2

    sections.forEach((section, index) => {
      const element = section as HTMLElement
      if (scrollPos >= element.offsetTop && scrollPos < element.offsetTop + element.offsetHeight) {
        setActiveSection(index)
      }
    })
  }, [])

  useEffect(() => {
    let ticking = false
    
    const scrollListener = () => {
      if (!ticking) {
        window.requestAnimationFrame(() => {
          handleScroll()
          ticking = false
        })
        ticking = true
      }
    }

    window.addEventListener('scroll', scrollListener, { passive: true })
    return () => window.removeEventListener('scroll', scrollListener)
  }, [handleScroll])

  const scrollToSection = useCallback((index: number) => {
    const sections = document.querySelectorAll('.section')
    sections[index]?.scrollIntoView({ behavior: 'smooth' })
  }, [])

  // Create cached click handlers for each dot
  const dotHandlers = useMemo(() => 
    sections.map(index => () => scrollToSection(index))
  , [sections, scrollToSection])

  return (
    <div className="app">
      {/* Color Palette */}
      <ColorPalette />
      
      {/* Navigation Dots */}
      <div className="nav-dots">
        {sections.map((index) => (
          <NavigationDot
            key={index}
            index={index}
            isActive={activeSection === index}
            onClick={dotHandlers[index]}
          />
        ))}
      </div>

      <HeroSection />
      <SkillsSection />
      <EducationSection />
      <ContactSection />
      <FooterSection />
    </div>
  )
}

export default App
