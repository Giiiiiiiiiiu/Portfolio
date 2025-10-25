import { motion } from 'framer-motion';
import { memo, useCallback, useMemo, useState } from 'react';
import emailjs from '@emailjs/browser';
import contactData from '../resources/contact.json';
import { EMAILJS_CONFIG } from '../config/emailjs';

const ContactSection = memo(() => {
  const isMobile = useMemo(() => window.innerWidth <= 768, []);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState<'idle' | 'success' | 'error'>('idle');
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: ''
  });

  const handleInputChange = useCallback((e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  }, []);

  const handleSubmit = useCallback(async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    
    if (isSubmitting) return;
    
    setIsSubmitting(true);
    setSubmitStatus('idle');
    
    try {
      emailjs.init(EMAILJS_CONFIG.PUBLIC_KEY);
      
      const fullMessage = `Von: ${formData.name}
E-Mail: ${formData.email}

Nachricht:
${formData.message}`;
      
      const templateParams = {
        from_name: formData.name,
        from_email: formData.email,
        message: fullMessage
      };
      
      await emailjs.send(
        EMAILJS_CONFIG.SERVICE_ID,
        EMAILJS_CONFIG.TEMPLATE_ID,
        templateParams
      );
      
      setSubmitStatus('success');
      setFormData({ name: '', email: '', message: '' });
      
      setTimeout(() => {
        setSubmitStatus('idle');
      }, 5000);
      
    } catch (error) {
      console.error('Failed to send email:', error);
      setSubmitStatus('error');
      
      setTimeout(() => {
        setSubmitStatus('idle');
      }, 5000);
    } finally {
      setIsSubmitting(false);
    }
  }, [formData, isSubmitting]);

  return (
    <section className="section contact-section">
      <div className="section-content">
        <motion.h2 
          className="section-title"
          initial={{ opacity: 0, x: -50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.3 }}
        > 
          {contactData.title}
        </motion.h2>
        <div className="contact-content">
          <motion.div 
            className="contact-info"
            initial={{ opacity: 0, x: -80 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ type: "spring" as const, stiffness: 100, duration: 0.3 }}
          >
            <h3>{contactData.heading}</h3>
            <p className="contact-description">{contactData.description}</p>
          </motion.div>
          <motion.form 
            className="contact-form" 
            onSubmit={handleSubmit}
            initial={{ opacity: 0, x: 80 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ type: "spring" as const, stiffness: 100, duration: 0.3 }}
          >
            <motion.div 
              className="form-group"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
            >
              <input 
                type="text" 
                name="name"
                value={formData.name}
                onChange={handleInputChange}
                placeholder={contactData.form.namePlaceholder}
                className="form-input"
                required
                disabled={isSubmitting}
              />
            </motion.div>
            <motion.div 
              className="form-group"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
            >
              <input 
                type="email" 
                name="email"
                value={formData.email}
                onChange={handleInputChange}
                placeholder={contactData.form.emailPlaceholder}
                className="form-input"
                required
                disabled={isSubmitting}
              />
            </motion.div>
            <motion.div 
              className="form-group"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
            >
              <textarea 
                name="message"
                value={formData.message}
                onChange={handleInputChange}
                placeholder={contactData.form.messagePlaceholder}
                className="form-input form-textarea"
                rows={5}
                required
                disabled={isSubmitting}
              ></textarea>
            </motion.div>
            <motion.button 
              type="submit" 
              className={`send-button ${isSubmitting ? 'submitting' : ''}`}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
              disabled={isSubmitting}
              {...(!isMobile && !isSubmitting && {
                whileHover: { 
                  scale: 1.05, 
                  y: -10,
                  transition: { type: "spring" as const, stiffness: 400 }
                },
                whileTap: { scale: 0.95 }
              })}
            >
              <span>{isSubmitting ? 'Sende...' : contactData.form.submitButton}</span>
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
            
            {submitStatus === 'success' && (
              <motion.div 
                className="form-status success"
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0 }}
              >
                ✅ Nachricht erfolgreich gesendet!
              </motion.div>
            )}
            
            {submitStatus === 'error' && (
              <motion.div 
                className="form-status error"
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0 }}
              >
                ❌ Fehler beim Senden. Bitte versuche es später erneut.
              </motion.div>
            )}
          </motion.form>
        </div>
      </div>
    </section>
  );
});

ContactSection.displayName = 'ContactSection';

export default ContactSection;
