import { memo } from 'react';
import educationData from '../resources/education.json';

const EducationSection = memo(() => {
  return (
    <section className="section education-section">
      <div className="education-container">
        <div className="education-header">
          <h2 className="section-title education-title">
            {educationData.title}
          </h2>
          <div className="title-decoration">
            <span className="decoration-line"></span>
            <span className="decoration-dot"></span>
            <span className="decoration-line"></span>
          </div>
        </div>
        
        <div className="timeline-3d-container">
          <div className="timeline-beam" />
          
          {educationData.timeline.map((item, index) => (
            <div 
              key={item.id} 
              className={`timeline-card-3d ${index % 2 === 0 ? 'card-left' : 'card-right'}`}
            >
              <div className="card-3d-wrapper">
                <div className="card-3d-content">
                  <div className="card-inner">
                    <div className="card-year-section">
                      <div className="year-hologram">
                        {item.year}
                      </div>
                      <div className="index-badge">
                        {String(index + 1).padStart(2, '0')}
                      </div>
                    </div>
                    
                    <div className="card-content-body">
                      <h3 className="card-title-3d">{item.title}</h3>
                      <div className="card-meta">
                        <span className="location-tag">
                          <span className="location-icon">⚡</span>
                          {item.location}
                        </span>
                      </div>
                      <div className="card-description-3d">
                        {item.description}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <div className="connection-node">
                <div className="node-core"></div>
                <div className="node-ring"></div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
});

EducationSection.displayName = 'EducationSection';

export default EducationSection;
