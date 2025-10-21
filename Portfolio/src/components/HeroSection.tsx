import { motion } from 'framer-motion';
import { memo, useMemo, useEffect, useRef, useState } from 'react';
import heroData from '../resources/hero.json';

const HeroSection = memo(() => {
  const isMobile = useMemo(() => window.innerWidth <= 768, []);
  const [mousePosition, setMousePosition] = useState({ x: 0, y: 0 });
  const sectionRef = useRef<HTMLDivElement>(null);
  
  // Mouse and touch tracking
  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      if (sectionRef.current) {
        const rect = sectionRef.current.getBoundingClientRect();
        setMousePosition({ 
          x: e.clientX - rect.left, 
          y: e.clientY - rect.top 
        });
      }
    };

    const handleTouchMove = (e: TouchEvent) => {
      if (e.touches.length > 0 && sectionRef.current) {
        const rect = sectionRef.current.getBoundingClientRect();
        setMousePosition({ 
          x: e.touches[0].clientX - rect.left, 
          y: e.touches[0].clientY - rect.top 
        });
      }
    };

    window.addEventListener('mousemove', handleMouseMove);
    window.addEventListener('touchmove', handleTouchMove, { passive: true });
    
    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('touchmove', handleTouchMove);
    };
  }, []);
  
  return (
    <section className="section hero-section" ref={sectionRef}>
      {/* Hidden background image with reveal mask */}
      <div 
        className="hero-background-reveal"
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: '100%',
          height: '100%',
          backgroundImage: `url(${import.meta.env.BASE_URL}OpacityBackground.svg)`,
          backgroundSize: 'cover',
          backgroundPosition: 'center',
          backgroundRepeat: 'no-repeat',
          opacity: 1,
          zIndex: 0,
          maskImage: `radial-gradient(circle 250px at ${mousePosition.x}px ${mousePosition.y}px, rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0.8) 40%, rgba(0, 0, 0, 0.3) 70%, transparent 100%)`,
          WebkitMaskImage: `radial-gradient(circle 250px at ${mousePosition.x}px ${mousePosition.y}px, rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0.8) 40%, rgba(0, 0, 0, 0.3) 70%, transparent 100%)`,
          maskSize: '100% 100%',
          WebkitMaskSize: '100% 100%',
          maskRepeat: 'no-repeat',
          WebkitMaskRepeat: 'no-repeat',
          transition: 'mask-position 0.1s ease-out, -webkit-mask-position 0.1s ease-out',
          pointerEvents: 'none'
        }}
      />
      
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
              src={`${import.meta.env.BASE_URL}me.png`}
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
