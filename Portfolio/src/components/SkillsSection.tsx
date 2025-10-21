import { motion, AnimatePresence } from 'framer-motion';
import React, { useState, memo, useMemo, useCallback } from 'react';
import skillsData from '../resources/skills.json';
import { 
  SiSwift, SiKotlin, SiFlutter, SiDart, SiExpo, SiReact, 
  SiTypescript, SiTailwindcss, SiHtml5, SiCss3, SiJavascript,
  SiCplusplus, SiSharp, SiUnity, SiUnrealengine,
  SiMysql, SiPostgresql, SiPhp, SiMongodb, SiAmazondynamodb,
  SiRedis, SiPusher, SiSocketdotio, SiFirebase,
  SiAmazon, SiGooglecloud, SiDocker, SiKubernetes
} from 'react-icons/si';
import { FaCode, FaEnvelope, FaPhone, FaServer, FaCloud } from 'react-icons/fa';

const SkillsSection = memo(() => {
  const [expandedSkill, setExpandedSkill] = useState<number | null>(null);
  const isMobile = useMemo(() => window.innerWidth <= 768, []);
  
  const getTechColor = useCallback((tech: string): string => {
    return (skillsData.techColors as Record<string, string>)[tech] || '#3b82f6';
  }, []);

  const getTextColor = useCallback((tech: string): string => {
    const lightBgTechs = ['JavaScript', 'Tailwind'];
    return lightBgTechs.includes(tech) ? '#000000' : '#ffffff';
  }, []);

  const iconMap = useMemo(() => ({
    'SwiftUI': <SiSwift />,
    'Swift': <SiSwift />,
    'Kotlin': <SiKotlin />,
    'Flutter': <SiFlutter />,
    'Dart': <SiDart />,
    'Expo': <SiExpo />,
    'React': <SiReact />,
    'TypeScript': <SiTypescript />,
    'Tailwind': <SiTailwindcss />,
    'HTML': <SiHtml5 />,
    'CSS': <SiCss3 />,
    'JavaScript': <SiJavascript />,
    'C++': <SiCplusplus />,
    'C#': <SiSharp />,
    'Unity': <SiUnity />,
    'Unreal': <SiUnrealengine />,
    'Blueprints': <FaCode />,
    'Construct': <FaCode />,
    'MySQL': <SiMysql />,
    'PostgreSQL': <SiPostgresql />,
    'phpMyAdmin': <SiPhp />,
    'MongoDB': <SiMongodb />,
    'DynamoDB': <SiAmazondynamodb />,
    'Redis': <SiRedis />,
    'Pusher': <SiPusher />,
    'Socket.io': <SiSocketdotio />,
    'WebSockets': <FaCode />,
    'Firebase': <SiFirebase />,
    'AWS': <SiAmazon />,
    'Azure': <FaCloud />,
    'Google Cloud': <SiGooglecloud />,
    'EC2': <FaServer />,
    'S3': <SiAmazon />,
    'Lambda': <FaServer />,
    'SendGrid': <FaEnvelope />,
    'Twilio': <FaPhone />,
    'Docker': <SiDocker />,
    'Kubernetes': <SiKubernetes />
  }), []);

  const getTechIcon = useCallback((tech: string) => {
    return (iconMap as Record<string, React.ReactElement>)[tech] || <FaCode />;
  }, [iconMap]);

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

  const toggleSkill = useCallback((skillId: number) => {
    setExpandedSkill(prev => prev === skillId ? null : skillId);
  }, []);

  return (
    <section className="section skills-section">
      <div className="section-content">
        <motion.h2 
          className="section-title"
          initial={{ opacity: 0, x: -50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.3 }}
        > 
          {skillsData.title}
        </motion.h2>
        <motion.div 
          className="skills-grid"
          variants={containerVariants}
          initial="hidden"
          animate="visible"
        >
          {skillsData.skills.map((skill) => (
            <motion.div 
              key={skill.id} 
              className="skill-card"
              variants={cardVariants}
              {...(!isMobile && {
                whileHover: { 
                  scale: 1.02,
                  transition: { type: "spring" as const, stiffness: 300 }
                }
              })}
              onClick={() => toggleSkill(skill.id)}
              style={{ cursor: 'pointer' }}
            >
              <AnimatePresence mode="wait">
                {expandedSkill === skill.id && skill.combos ? (
                  <motion.div 
                    key="combos"
                    className="skill-full-content"
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.95 }}
                    transition={{ duration: 0.3 }}
                  >
                    <div className="combos-title">Tech Stacks</div>
                    <div className="combos-grid">
                      {skill.combos.map((combo, idx) => (
                        <motion.div
                          key={idx}
                          className="combo-item"
                          initial={{ opacity: 0, y: 20 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ delay: idx * 0.08 }}
                        >
                          <div className="combo-name">{combo.name}</div>
                          <div className="combo-tech">
                            {combo.tech.map((tech, techIdx) => (
                              <span 
                                key={techIdx} 
                                className="tech-badge"
                                style={{
                                  backgroundColor: getTechColor(tech),
                                  color: getTextColor(tech),
                                  borderColor: getTechColor(tech),
                                  fontWeight: 700
                                }}
                              >
                                <span className="tech-icon">{getTechIcon(tech)}</span>
                                <span className="tech-name">{tech}</span>
                              </span>
                            ))}
                          </div>
                        </motion.div>
                      ))}
                    </div>
                  </motion.div>
                ) : (
                  <motion.div
                    key="default"
                    className="skill-full-content skill-default-view"
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.95 }}
                    transition={{ duration: 0.3 }}
                  >
                    <motion.div 
                      className="skill-icon-large"
                      whileHover={{ 
                        scale: 1.15,
                        rotate: 360,
                        transition: { duration: 0.6, ease: "easeInOut" }
                      }}
                    >
                      <div className="icon-wrapper">
                        {skill.icon}
                      </div>
                    </motion.div>
                    <h3 className="skill-title-large">{skill.title}</h3>
                    <p className="skill-description">{skill.description}</p>
                    <motion.div 
                      className="click-hint"
                      animate={{ 
                        opacity: [0.5, 1, 0.5],
                        y: [0, -5, 0]
                      }}
                      transition={{ 
                        duration: 2,
                        repeat: Infinity,
                        ease: "easeInOut"
                      }}
                    >
                      👆 Klick für Tech Stacks
                    </motion.div>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  );
});

SkillsSection.displayName = 'SkillsSection';

export default SkillsSection;
