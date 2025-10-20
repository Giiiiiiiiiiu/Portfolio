import { motion } from 'framer-motion';
import { memo, useMemo } from 'react';
import heroData from '../resources/hero.json';

const HeroSection = memo(() => {
  const isMobile = useMemo(() => window.innerWidth <= 768, []);
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
            duration: 0.3
          }}
          {...(!isMobile && {
            whileHover: { 
              scale: 1.1, 
              rotateY: 10,
              transition: { type: "spring" as const, stiffness: 300 }
            }
          })}
        >
          <div className="profile-image">
            <img 
              src="/me.png"  
              className="profile-picture"
            />
          </div>
          <div className="glow-effect"></div>
        </motion.div>
        <motion.h1 
          className="name"
          initial={{ opacity: 0, y: 50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.3 }}
        >
          <motion.span 
            className="name-line"
            initial={{ opacity: 0, x: -100 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ type: "spring" as const, stiffness: 100, duration: 0.3 }}
          >
            {heroData.name.firstName}
          </motion.span>
          <motion.span 
            className="name-line"
            initial={{ opacity: 0, x: 100 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ type: "spring" as const, stiffness: 100, duration: 0.3 }}
          >
            {heroData.name.lastName}
          </motion.span>
        </motion.h1>
        <motion.p 
          className="tagline"
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.3 }}
        >
          {heroData.tagline}
        </motion.p>
        <motion.div 
          className="scroll-indicator"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.3 }}
        >
          <span>{heroData.scrollText}</span>
          <div className="scroll-arrow">↓</div>
        </motion.div>
      </div>
    </section>
  );
});

HeroSection.displayName = 'HeroSection';

export default HeroSection;
