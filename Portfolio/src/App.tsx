import { useEffect, useState, useCallback, useMemo, lazy, Suspense, memo } from 'react'
import './App.css'
import HeroSection from './components/HeroSection'

// Lazy load non-critical sections
const SkillsSection = lazy(() => import('./components/SkillsSection'))
const EducationSection = lazy(() => import('./components/EducationSection'))
const ContactSection = lazy(() => import('./components/ContactSection'))
const FooterSection = lazy(() => import('./components/FooterSection'))

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
      <Suspense fallback={<div className="loading">Loading...</div>}>
        <SkillsSection />
        <EducationSection />
        <ContactSection />
        <FooterSection />
      </Suspense>
    </div>
  )
}

export default App
