import companyData from '../resources/company.json';

const CompanySection = () => {
  const { company } = companyData;

  return (
    <section className="section company-section">
      <div className="section-content">
        <h2 className="section-title"> 
          {companyData.title}
        </h2>
        <div className="company-card">
          <div className="company-logo">
            <div className="logo-placeholder">{company.logo}</div>
          </div>
          <h3 className="company-name">{company.name}</h3>
          <p className="company-tagline">{company.tagline}</p>
          <div className="company-description">
            <p>{company.description}</p>
            <div className="company-services">
              {company.services.map((service, index) => (
                <div key={index} className="service-item">
                  ✓ {service}
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default CompanySection;
