import heroData from '../resources/hero.json';

const HeroSection = () => {
  return (
    <section className="section hero-section">
      <div className="hero-content">
        <div className="profile-image-container">
          <div className="profile-image">
            <div className="image-placeholder">
              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                <circle cx="12" cy="7" r="4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </div>
          </div>
          <div className="glow-effect"></div>
        </div>
        <h1 className="name">
          <span className="name-line">{heroData.name.firstName}</span>
          <span className="name-line">{heroData.name.lastName}</span>
        </h1>
        <p className="tagline">{heroData.tagline}</p>
        <div className="scroll-indicator">
          <span>{heroData.scrollText}</span>
          <div className="scroll-arrow">↓</div>
        </div>
      </div>
    </section>
  );
};

export default HeroSection;
