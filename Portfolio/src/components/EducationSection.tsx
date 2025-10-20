import educationData from '../resources/education.json';

const EducationSection = () => {
  return (
    <section className="section education-section">
      <div className="section-content">
        <h2 className="section-title"> 
          {educationData.title}
        </h2>
        <div className="timeline">
          {educationData.timeline.map((item) => (
            <div key={item.id} className="timeline-item">
              <div className="timeline-dot"></div>
              <div className="timeline-content">
                <div className="timeline-year">{item.year}</div>
                <h3>{item.title}</h3>
                <p className="timeline-location">{item.location}</p>
                <p className="timeline-description">{item.description}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default EducationSection;
