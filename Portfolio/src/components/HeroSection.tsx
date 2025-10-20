import { motion } from 'framer-motion';
import heroData from '../resources/hero.json';

const HeroSection = () => {
  return (
    <section className="section hero-section">
      <div className="hero-content">
        <motion.div 
          className="profile-image-container"
          initial={{ opacity: 0, scale: 0.5, rotateY: -180 }}
          animate={{ opacity: 1, scale: 1, rotateY: 0 }}
          transition={{ 
            type: "spring" as const, 
            stiffness: 80, 
            damping: 15,
            delay: 0.2 
          }}
          whileHover={{ 
            scale: 1.1, 
            rotateY: 10,
            transition: { type: "spring" as const, stiffness: 300 }
          }}
        >
          <div className="profile-image">
            <div className="image-placeholder">
              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                <circle cx="12" cy="7" r="4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </div>
          </div>
          <div className="glow-effect"></div>
        </motion.div>
        <motion.h1 
          className="name"
          initial={{ opacity: 0, y: 50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.5, duration: 0.8 }}
        >
          <motion.span 
            className="name-line"
            initial={{ opacity: 0, x: -100 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.6, type: "spring" as const, stiffness: 100 }}
          >
            {heroData.name.firstName}
          </motion.span>
          <motion.span 
            className="name-line"
            initial={{ opacity: 0, x: 100 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.7, type: "spring" as const, stiffness: 100 }}
          >
            {heroData.name.lastName}
          </motion.span>
        </motion.h1>
        <motion.p 
          className="tagline"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.9, duration: 0.6 }}
        >
          {heroData.tagline}
        </motion.p>
        <motion.div 
          className="scroll-indicator"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1, y: [0, 10, 0] }}
          transition={{ 
            opacity: { delay: 1.1, duration: 0.5 },
            y: { delay: 1.5, duration: 2, repeat: Infinity, ease: "easeInOut" }
          }}
        >
          <span>{heroData.scrollText}</span>
          <div className="scroll-arrow">↓</div>
        </motion.div>
      </div>
    </section>
  );
};

export default HeroSection;
