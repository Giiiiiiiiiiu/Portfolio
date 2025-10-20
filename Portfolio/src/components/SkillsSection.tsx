import { motion, AnimatePresence } from 'framer-motion';
import { useState } from 'react';
import skillsData from '../resources/skills.json';

const SkillsSection = () => {
  const [expandedSkill, setExpandedSkill] = useState<number | null>(null);

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.2
      }
    }
  };

  const cardVariants = {
    hidden: { 
      opacity: 0, 
      y: 50,
      rotateX: -15
    },
    visible: { 
      opacity: 1, 
      y: 0,
      rotateX: 0,
      transition: {
        type: "spring" as const,
        stiffness: 100,
        damping: 12
      }
    }
  };

  const comboVariants = {
    hidden: { 
      opacity: 0, 
      height: 0,
      marginTop: 0
    },
    visible: { 
      opacity: 1, 
      height: "auto",
      marginTop: "1.5rem",
      transition: {
        height: { type: "spring" as const, stiffness: 300, damping: 25 },
        opacity: { duration: 0.3 }
      }
    },
    exit: {
      opacity: 0,
      height: 0,
      marginTop: 0,
      transition: {
        height: { type: "spring" as const, stiffness: 300, damping: 25 },
        opacity: { duration: 0.2 }
      }
    }
  };

  const toggleSkill = (skillId: number) => {
    setExpandedSkill(expandedSkill === skillId ? null : skillId);
  };

  return (
    <section className="section skills-section">
      <div className="section-content">
        <motion.h2 
          className="section-title"
          initial={{ opacity: 0, x: -50 }}
          whileInView={{ opacity: 1, x: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        > 
          {skillsData.title}
        </motion.h2>
        <motion.div 
          className="skills-grid"
          variants={containerVariants}
          initial="hidden"
          whileInView="visible"
          viewport={{ once: true, amount: 0.2 }}
        >
          {skillsData.skills.map((skill) => (
            <motion.div 
              key={skill.id} 
              className={`skill-card ${expandedSkill === skill.id ? 'expanded' : ''}`}
              variants={cardVariants}
              whileHover={{ 
                scale: 1.02,
                transition: { type: "spring" as const, stiffness: 300 }
              }}
              onClick={() => toggleSkill(skill.id)}
              style={{ cursor: 'pointer' }}
            >
              <motion.div 
                className="skill-icon"
                whileHover={{ 
                  scale: 1.2, 
                  rotate: [0, -10, 10, -10, 0],
                  transition: { duration: 0.5 }
                }}
              >
                {skill.icon}
              </motion.div>
              <h3>{skill.title}</h3>
              <p>{skill.description}</p>
              <div className="skill-tags">
                {skill.tags.map((tag, index) => (
                  <motion.span 
                    key={index}
                    whileHover={{ 
                      scale: 1.1, 
                      y: -3,
                      transition: { type: "spring" as const, stiffness: 400 }
                    }}
                  >
                    {tag}
                  </motion.span>
                ))}
              </div>

              <AnimatePresence>
                {expandedSkill === skill.id && skill.combos && (
                  <motion.div 
                    className="skill-combos"
                    variants={comboVariants}
                    initial="hidden"
                    animate="visible"
                    exit="exit"
                  >
                    <div className="combos-title">Tech Stacks:</div>
                    <div className="combos-grid">
                      {skill.combos.map((combo, idx) => (
                        <motion.div
                          key={idx}
                          className="combo-item"
                          initial={{ opacity: 0, scale: 0.8 }}
                          animate={{ opacity: 1, scale: 1 }}
                          transition={{ delay: idx * 0.1 }}
                          whileHover={{ scale: 1.05 }}
                        >
                          <div className="combo-name">{combo.name}</div>
                          <div className="combo-tech">
                            {combo.tech.map((tech, techIdx) => (
                              <span key={techIdx} className="tech-badge">{tech}</span>
                            ))}
                          </div>
                        </motion.div>
                      ))}
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  );
};

export default SkillsSection;
