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
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.9, duration: 0.8 }}
        >
          {heroData.tagline}
        </motion.p>
        <motion.div 
          className="scroll-indicator"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 1.1, duration: 0.5 }}
        >
          <span>{heroData.scrollText}</span>
          <div className="scroll-arrow">↓</div>
        </motion.div>
      </div>
    </section>
  );
};

export default HeroSection;
