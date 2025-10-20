import { motion } from 'framer-motion';
import contactData from '../resources/contact.json';

const ContactSection = () => {
  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    // Hier kannst du später die Email-Logik implementieren
    console.log('Form submitted');
  };

  return (
    <section className="section contact-section">
      <div className="section-content">
        <motion.h2 
          className="section-title"
          initial={{ opacity: 0, x: -50 }}
          whileInView={{ opacity: 1, x: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        > 
          {contactData.title}
        </motion.h2>
        <div className="contact-content">
          <motion.div 
            className="contact-info"
            initial={{ opacity: 0, x: -80 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2, type: "spring" as const, stiffness: 100 }}
          >
            <h3>{contactData.heading}</h3>
            <p className="contact-description">{contactData.description}</p>
          </motion.div>
          <motion.form 
            className="contact-form" 
            onSubmit={handleSubmit}
            initial={{ opacity: 0, x: 80 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.3, type: "spring" as const, stiffness: 100 }}
          >
            <motion.div 
              className="form-group"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.4 }}
            >
              <input 
                type="text" 
                placeholder={contactData.form.namePlaceholder}
                className="form-input"
                required
              />
            </motion.div>
            <motion.div 
              className="form-group"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.5 }}
            >
              <input 
                type="email" 
                placeholder={contactData.form.emailPlaceholder}
                className="form-input"
                required
              />
            </motion.div>
            <motion.div 
              className="form-group"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.6 }}
            >
              <textarea 
                placeholder={contactData.form.messagePlaceholder}
                className="form-input form-textarea"
                rows={5}
                required
              ></textarea>
            </motion.div>
            <motion.button 
              type="submit" 
              className="send-button"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.7 }}
              whileHover={{ 
                scale: 1.05, 
                y: -10,
                transition: { type: "spring" as const, stiffness: 400 }
              }}
              whileTap={{ scale: 0.95 }}
            >
              <span>{contactData.form.submitButton}</span>
              <motion.svg 
                viewBox="0 0 24 24" 
                fill="none" 
                xmlns="http://www.w3.org/2000/svg"
                animate={{ x: [0, 5, 0] }}
                transition={{ duration: 1.5, repeat: Infinity, ease: "easeInOut" }}
              >
                <path d="M22 2L11 13" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                <path d="M22 2L15 22L11 13L2 9L22 2Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </motion.svg>
            </motion.button>
          </motion.form>
        </div>
      </div>
      <motion.footer 
        className="footer"
        initial={{ opacity: 0 }}
        whileInView={{ opacity: 1 }}
        viewport={{ once: true }}
        transition={{ delay: 0.8, duration: 0.6 }}
      >
        <p>{contactData.footer.text}</p>
      </motion.footer>
    </section>
  );
};

export default ContactSection;
