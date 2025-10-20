import { motion } from 'framer-motion';
import { memo, useMemo } from 'react';
import educationData from '../resources/education.json';

const EducationSection = memo(() => {
  const isMobile = useMemo(() => window.innerWidth <= 768, []);
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
      <div className="section-content">
        <motion.h2 
          className="section-title"
          initial={{ opacity: 0, x: -50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.3 }}
        > 
          {educationData.title}
        </motion.h2>
        <motion.div 
          className="timeline"
          variants={timelineVariants}
          initial="hidden"
          animate="visible"
        >
          {educationData.timeline.map((item) => (
            <motion.div 
              key={item.id} 
              className="timeline-item"
              variants={itemVariants}
            >
              <motion.div 
                className="timeline-dot"
                initial={{ scale: 0 }}
                animate={{ scale: 1 }}
                transition={{ type: "spring" as const, stiffness: 500, duration: 0.3 }}
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
      </div>
    </section>
  );
});

EducationSection.displayName = 'EducationSection';

export default EducationSection;
