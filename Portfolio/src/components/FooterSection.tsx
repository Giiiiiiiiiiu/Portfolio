import { motion } from 'framer-motion';
import { FaGithub, FaLinkedin } from 'react-icons/fa';
import { FaXTwitter } from 'react-icons/fa6';

const FooterSection = () => {
  const socialLinks = [
    {
      name: 'GitHub',
      icon: <FaGithub />,
      url: 'https://github.com/yourusername', // Ersetze mit deinem GitHub Username
      color: '#333'
    },
    {
      name: 'LinkedIn',
      icon: <FaLinkedin />,
      url: 'https://linkedin.com/in/yourprofile', // Ersetze mit deinem LinkedIn Profil
      color: '#0077B5'
    },
    {
      name: 'X',
      icon: <FaXTwitter />,
      url: 'https://x.com/yourusername', // Ersetze mit deinem X/Twitter Username
      color: '#000000'
    }
  ];

  return (
    <footer className="footer-section">
      <div className="footer-content">
        <motion.div 
          className="social-links"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
        >
          {socialLinks.map((social, index) => (
            <motion.a
              key={social.name}
              href={social.url}
              target="_blank"
              rel="noopener noreferrer"
              className="social-link"
              initial={{ opacity: 0, scale: 0.5 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: index * 0.1, duration: 0.5 }}
              whileHover={{ 
                scale: 1.2,
                rotate: 360,
                transition: { duration: 0.4 }
              }}
              style={{ 
                '--social-color': social.color 
              } as React.CSSProperties & { '--social-color': string }}
            >
              {social.icon}
              <span className="social-tooltip">{social.name}</span>
            </motion.a>
          ))}
        </motion.div>

        <motion.p 
          className="footer-text"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.4, duration: 0.6 }}
        >
          © {new Date().getFullYear()} - Made with 💙 by Sergey Kotenkov
        </motion.p>
      </div>
    </footer>
  );
};

export default FooterSection;
