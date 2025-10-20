import { useEffect, useState } from 'react'
import './App.css'
import HeroSection from './components/HeroSection'
import SkillsSection from './components/SkillsSection'
import EducationSection from './components/EducationSection'
import CompanySection from './components/CompanySection'
import ContactSection from './components/ContactSection'
import FooterSection from './components/FooterSection'

function App() {
  const [activeSection, setActiveSection] = useState(0)

  useEffect(() => {
    const handleScroll = () => {
      const sections = document.querySelectorAll('.section')
      const scrollPos = window.scrollY + window.innerHeight / 2

      sections.forEach((section, index) => {
        const element = section as HTMLElement
        if (scrollPos >= element.offsetTop && scrollPos < element.offsetTop + element.offsetHeight) {
          setActiveSection(index)
        }
      })
    }

    window.addEventListener('scroll', handleScroll)
    return () => window.removeEventListener('scroll', handleScroll)
  }, [])

  const scrollToSection = (index: number) => {
    const sections = document.querySelectorAll('.section')
    sections[index]?.scrollIntoView({ behavior: 'smooth' })
  }

  return (
    <div className="app">
      {/* Navigation Dots */}
      <div className="nav-dots">
        {[0, 1, 2, 3].map((index) => (
          <button
            key={index}
            className={`dot ${activeSection === index ? 'active' : ''}`}
            onClick={() => scrollToSection(index)}
            aria-label={`Go to section ${index + 1}`}
          />
        ))}
      </div>

      <HeroSection />
      <SkillsSection />
      <EducationSection />
      {/* <CompanySection /> */}
      <ContactSection />
      <FooterSection />
    </div>
  )
}

export default App
