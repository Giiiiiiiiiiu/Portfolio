import skillsData from '../resources/skills.json';

const SkillsSection = () => {
  return (
    <section className="section skills-section">
      <div className="section-content">
        <h2 className="section-title"> 
          {skillsData.title}
        </h2>
        <div className="skills-grid">
          {skillsData.skills.map((skill) => (
            <div key={skill.id} className="skill-card">
              <div className="skill-icon">{skill.icon}</div>
              <h3>{skill.title}</h3>
              <p>{skill.description}</p>
              <div className="skill-tags">
                {skill.tags.map((tag, index) => (
                  <span key={index}>{tag}</span>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default SkillsSection;
