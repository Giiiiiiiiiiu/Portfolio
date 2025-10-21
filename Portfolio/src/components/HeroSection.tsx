import { motion } from 'framer-motion';
import { memo, useMemo, useEffect, useRef, useState } from 'react';
import heroData from '../resources/hero.json';

const HeroSection = memo(() => {
  const isMobile = useMemo(() => window.innerWidth <= 768, []);
  const [mousePosition, setMousePosition] = useState({ x: 150, y: 150 });
  const [isEffectActive, setIsEffectActive] = useState(true);
  const sectionRef = useRef<HTMLDivElement>(null);
  
  const hasMouseSupport = useMemo(() => {
    const hasHover = window.matchMedia('(hover: hover)').matches;
    const hasFinePointer = window.matchMedia('(pointer: fine)').matches;
    const hasCoarsePointer = window.matchMedia('(pointer: coarse)').matches;
    
    return hasHover && hasFinePointer && !hasCoarsePointer;
  }, []);
  
  useEffect(() => {
    const handleScroll = () => {
      if (sectionRef.current) {
        const rect = sectionRef.current.getBoundingClientRect();
        if (rect.bottom < window.innerHeight * 0.2) {
          setIsEffectActive(false);
        } else {
          setIsEffectActive(true);
        }
      }
    };

    window.addEventListener('scroll', handleScroll);
    handleScroll();
    
    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);
  
  useEffect(() => {
    if (!hasMouseSupport || !isEffectActive) return;
    
    const handleMouseMove = (e: MouseEvent) => {
      if (sectionRef.current) {
        const rect = sectionRef.current.getBoundingClientRect();
        setMousePosition({ 
          x: e.clientX - rect.left, 
          y: e.clientY - rect.top 
        });
      }
    };

    window.addEventListener('mousemove', handleMouseMove);
    
    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
    };
  }, [hasMouseSupport, isEffectActive]);
  
  return (
    <section className="section hero-section" ref={sectionRef}>
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
            opacity: isEffectActive ? 1 : 0,
            zIndex: 0,
            maskImage: isEffectActive 
              ? `radial-gradient(circle 250px at ${mousePosition.x}px ${mousePosition.y}px, rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0.8) 40%, rgba(0, 0, 0, 0.3) 70%, transparent 100%)`
              : 'radial-gradient(circle 0px at 0px 0px, transparent 100%)',
            WebkitMaskImage: isEffectActive
              ? `radial-gradient(circle 250px at ${mousePosition.x}px ${mousePosition.y}px, rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0.8) 40%, rgba(0, 0, 0, 0.3) 70%, transparent 100%)`
              : 'radial-gradient(circle 0px at 0px 0px, transparent 100%)',
            maskSize: '100% 100%',
            WebkitMaskSize: '100% 100%',
            maskRepeat: 'no-repeat',
            WebkitMaskRepeat: 'no-repeat',
            transition: 'opacity 0.5s ease-out, mask-image 0.5s ease-out, -webkit-mask-image 0.5s ease-out',
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
