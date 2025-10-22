import { motion } from 'framer-motion';
import { memo, useMemo, useState } from 'react';
import educationData from '../resources/education.json';

const EducationSection = memo(() => {
  const isMobile = useMemo(() => window.innerWidth <= 768, []);
  const [isDoorOpen, setIsDoorOpen] = useState(false);
  
  const timelineVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.3
      }
    }
  };

  const itemVariants = {
    hidden: { 
      opacity: 0, 
      x: -50,
      rotateY: -20
    },
    visible: { 
      opacity: 1, 
      x: 0,
      rotateY: 0,
      transition: {
        type: "spring" as const,
        stiffness: 100,
        damping: 15
      }
    }
  };

  return (
    <section className="section education-section">
      <div className="door-container">
        <motion.h2 
          className="section-title door-title"
          initial={{ opacity: 0, y: -30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
        > 
          {educationData.title}
        </motion.h2>
        
        <div className="door-frame double-door-frame">
          {/* Left Door */}
          <motion.div 
            className={`door door-left ${isDoorOpen ? 'open' : ''}`}
            onClick={() => setIsDoorOpen(!isDoorOpen)}
            initial={{ rotateY: 0 }}
            animate={{ rotateY: isDoorOpen ? -95 : 0 }}
            transition={{ 
              type: "spring" as const, 
              stiffness: 60, 
              damping: 15,
              duration: 1
            }}
          >
            <div className="door-front">
              <div className="door-handle-container door-handle-left">
                <div className="door-handle"></div>
              </div>
              <div className="door-panel door-panel-top-left"></div>
              <div className="door-panel door-panel-middle-left"></div>
              <div className="door-panel door-panel-bottom-left"></div>
              <div className="door-knocker door-knocker-left"></div>
              <div className="door-number door-number-left">0</div>
            </div>
            <div className="door-edge-left"></div>
            <div className="door-edge-right"></div>
            <div className="door-edge-top"></div>
          </motion.div>
          
          {/* Right Door */}
          <motion.div 
            className={`door door-right ${isDoorOpen ? 'open' : ''}`}
            onClick={() => setIsDoorOpen(!isDoorOpen)}
            initial={{ rotateY: 0 }}
            animate={{ rotateY: isDoorOpen ? 95 : 0 }}
            transition={{ 
              type: "spring" as const, 
              stiffness: 60, 
              damping: 15,
              duration: 1,
              delay: isDoorOpen ? 0.1 : 0
            }}
          >
            <div className="door-front">
              <div className="door-handle-container door-handle-right">
                <div className="door-handle"></div>
              </div>
              <div className="door-panel door-panel-top-right"></div>
              <div className="door-panel door-panel-middle-right"></div>
              <div className="door-panel door-panel-bottom-right"></div>
              <div className="door-knocker door-knocker-right"></div>
              <div className="door-number door-number-right">1</div>
            </div>
            <div className="door-edge-left"></div>
            <div className="door-edge-right"></div>
            <div className="door-edge-top"></div>
          </motion.div>
          
          {/* Center divider and label */}
          <motion.div 
            className="door-center-divider"
            initial={{ opacity: 1, scaleX: 1 }}
            animate={{ 
              opacity: isDoorOpen ? 0 : 1,
              scaleX: isDoorOpen ? 0 : 1
            }}
            transition={{ 
              duration: 0.5,
              delay: isDoorOpen ? 0.2 : 0.3
            }}
          />
          {!isDoorOpen && (
            <motion.div 
              className="door-label door-label-center"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.5 }}
            >
              <span className="door-label-text">Klicke zum Öffnen</span>
            </motion.div>
          )}
          
          {/* Room content behind door */}
          <motion.div 
            className="room-content"
            initial={{ opacity: 0 }}
            animate={{ 
              opacity: isDoorOpen ? 1 : 0,
              scale: isDoorOpen ? 1 : 0.9
            }}
            transition={{ 
              delay: isDoorOpen ? 0.3 : 0.8, 
              duration: isDoorOpen ? 0.5 : 0.3 
            }}
            style={{ pointerEvents: isDoorOpen ? 'auto' : 'none' }}
          >
            <motion.div 
              className="timeline"
              variants={timelineVariants}
              initial="hidden"
              animate={isDoorOpen ? "visible" : "hidden"}
            >
              {educationData.timeline.map((item, index) => (
                <motion.div 
                  key={item.id} 
                  className="timeline-item"
                  variants={itemVariants}
                  custom={index}
                >
                  <motion.div 
                    className="timeline-dot"
                    initial={{ scale: 0 }}
                    animate={{ scale: isDoorOpen ? 1 : 0 }}
                    transition={{ 
                      type: "spring" as const, 
                      stiffness: 500, 
                      delay: isDoorOpen ? 0.5 + index * 0.1 : 0 
                    }}
                  />
                  <motion.div 
                    className="timeline-content"
                    {...(!isMobile && {
                      whileHover: { 
                        x: 20, 
                        rotateY: -5, 
                        scale: 1.02,
                        transition: { type: "spring" as const, stiffness: 300 }
                      }
                    })}
                  >
                    <motion.div 
                      className="timeline-year"
                      {...(!isMobile && {
                        whileHover: { scale: 1.1, z: 20 }
                      })}
                    >
                      {item.year}
                    </motion.div>
                    <h3>{item.title}</h3>
                    <p className="timeline-location">{item.location}</p>
                    <p className="timeline-description">{item.description}</p>
                  </motion.div>
                </motion.div>
              ))}
            </motion.div>
          </motion.div>
          
          {/* Door Frame Decoration */}
          <div className="door-frame-decoration">
            <div className="frame-top"></div>
            <div className="frame-left"></div>
            <div className="frame-right"></div>
            <div className="frame-bottom"></div>
          </div>
        </div>
      </div>
    </section>
  );
});

EducationSection.displayName = 'EducationSection';

export default EducationSection;
