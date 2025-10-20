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
        <h2 className="section-title"> 
          {contactData.title}
        </h2>
        <div className="contact-content">
          <div className="contact-info">
            <h3>{contactData.heading}</h3>
            <p className="contact-description">{contactData.description}</p>
          </div>
          <form className="contact-form" onSubmit={handleSubmit}>
            <div className="form-group">
              <input 
                type="text" 
                placeholder={contactData.form.namePlaceholder}
                className="form-input"
                required
              />
            </div>
            <div className="form-group">
              <input 
                type="email" 
                placeholder={contactData.form.emailPlaceholder}
                className="form-input"
                required
              />
            </div>
            <div className="form-group">
              <textarea 
                placeholder={contactData.form.messagePlaceholder}
                className="form-input form-textarea"
                rows={5}
                required
              ></textarea>
            </div>
            <button type="submit" className="send-button">
              <span>{contactData.form.submitButton}</span>
              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M22 2L11 13" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                <path d="M22 2L15 22L11 13L2 9L22 2Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </button>
          </form>
        </div>
      </div>
      <footer className="footer">
        <p>{contactData.footer.text}</p>
      </footer>
    </section>
  );
};

export default ContactSection;
