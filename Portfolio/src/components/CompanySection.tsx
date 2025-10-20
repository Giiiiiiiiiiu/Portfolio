import { motion } from 'framer-motion';
import companyData from '../resources/company.json';

const CompanySection = () => {
  const { company } = companyData;

  return (
    <section className="section company-section">
      <div className="section-content">
        <motion.h2 
          className="section-title"
          initial={{ opacity: 0, x: -50 }}
          whileInView={{ opacity: 1, x: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        > 
          {companyData.title}
        </motion.h2>
        <motion.div 
          className="company-card"
          initial={{ opacity: 0, y: 100, rotateX: -20 }}
          whileInView={{ opacity: 1, y: 0, rotateX: 0 }}
          viewport={{ once: true }}
          transition={{ type: "spring" as const, stiffness: 60, damping: 15 }}
          whileHover={{ 
            y: -15, 
            rotateX: 2, 
            scale: 1.02,
            transition: { type: "spring" as const, stiffness: 300 }
          }}
        >
          <motion.div 
            className="company-logo"
            initial={{ scale: 0, rotate: -180 }}
            whileInView={{ scale: 1, rotate: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.3, type: "spring" as const, stiffness: 200 }}
            whileHover={{ 
              scale: 1.1, 
              rotateY: 10,
              transition: { type: "spring" as const, stiffness: 300 }
            }}
          >
            <div className="logo-placeholder">{company.logo}</div>
          </motion.div>
          <h3 className="company-name">{company.name}</h3>
          <p className="company-tagline">{company.tagline}</p>
          <div className="company-description">
            <p>{company.description}</p>
            <div className="company-services">
              {company.services.map((service, index) => (
                <motion.div 
                  key={index} 
                  className="service-item"
                  initial={{ opacity: 0, scale: 0.8 }}
                  whileInView={{ opacity: 1, scale: 1 }}
                  viewport={{ once: true }}
                  transition={{ delay: index * 0.1 + 0.5 }}
                  whileHover={{ 
                    scale: 1.08, 
                    z: 20,
                    transition: { type: "spring" as const, stiffness: 400 }
                  }}
                >
                  ✓ {service}
                </motion.div>
              ))}
            </div>
          </div>
        </motion.div>
      </div>
    </section>
  );
};

export default CompanySection;
