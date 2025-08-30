import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanySection extends StatefulWidget {
  const CompanySection({Key? key}) : super(key: key);

  @override
  State<CompanySection> createState() => _CompanySectionState();
}

class _CompanySectionState extends State<CompanySection> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1200;
    final isTablet = screenSize.width > 600 && screenSize.width <= 1200;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : (isTablet ? 60 : 30),
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF0f3460),
            const Color(0xFF16213e),
            const Color(0xFF1a1a2e),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 60),
          _buildCompanyGrid(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        duration: const Duration(milliseconds: 800),
        verticalOffset: -50,
        child: FadeInAnimation(
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    const Color(0xFF3A7BD5),
                    const Color(0xFF00D2FF),
                    const Color(0xFF3A7BD5),
                  ],
                ).createShader(bounds),
                child: const Text(
                  'Berufserfahrung',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Unternehmen, mit denen ich zusammengearbeitet habe',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyGrid(BuildContext context) {
    final companies = [
      {
        'name': 'Tech Innovations GmbH',
        'position': 'Senior Full-Stack Developer',
        'period': '2023 - Heute',
        'description': 'Entwicklung von Cloud-nativen Anwendungen mit Kubernetes und Microservices',
        'logo': FontAwesomeIcons.rocket,
        'color': const Color(0xFF00D2FF),
        'technologies': ['Flutter', 'Node.js', 'AWS', 'Docker'],
        'website': 'https://example.com',
      },
      {
        'name': 'Digital Solutions AG',
        'position': 'Flutter Developer',
        'period': '2021 - 2023',
        'description': 'Mobile App-Entwicklung für iOS und Android mit Flutter',
        'logo': FontAwesomeIcons.mobileAlt,
        'color': const Color(0xFF3A7BD5),
        'technologies': ['Flutter', 'Firebase', 'REST APIs', 'Git'],
        'website': 'https://example.com',
      },
      {
        'name': 'StartUp Ventures',
        'position': 'Junior Developer',
        'period': '2020 - 2021',
        'description': 'Full-Stack Entwicklung und Prototyping für verschiedene Startup-Projekte',
        'logo': FontAwesomeIcons.lightbulb,
        'color': const Color(0xFF8B5CF6),
        'technologies': ['React', 'Python', 'PostgreSQL', 'CI/CD'],
        'website': 'https://example.com',
      },
      {
        'name': 'Freelance Projekte',
        'position': 'Selbstständiger Entwickler',
        'period': '2019 - 2020',
        'description': 'Webentwicklung und Consulting für KMUs',
        'logo': FontAwesomeIcons.laptop,
        'color': const Color(0xFF10B981),
        'technologies': ['WordPress', 'JavaScript', 'PHP', 'MySQL'],
        'website': 'https://example.com',
      },
    ];

    final screenSize = MediaQuery.of(context).size;
    final crossAxisCount = screenSize.width > 1200 ? 2 : 1;

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: screenSize.width > 600 ? 1.8 : 1.4,
        ),
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: crossAxisCount,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: _buildCompanyCard(context, companies[index], index),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCompanyCard(BuildContext context, Map<String, dynamic> company, int index) {
    final isHovered = hoveredIndex == index;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0, isHovered ? -10.0 : 0.0)
          ..scale(isHovered ? 1.02 : 1.0),
        child: GlassmorphicContainer(
          width: double.infinity,
          height: double.infinity,
          borderRadius: 25,
          blur: 20,
          alignment: Alignment.center,
          border: 2,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(isHovered ? 0.15 : 0.1),
              Colors.white.withOpacity(isHovered ? 0.08 : 0.05),
            ],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (company['color'] as Color).withOpacity(isHovered ? 0.8 : 0.5),
              Colors.white.withOpacity(0.2),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            (company['color'] as Color).withOpacity(0.8),
                            company['color'] as Color,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (company['color'] as Color).withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        company['logo'] as IconData,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            company['name'] as String,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: company['color'] as Color,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            company['position'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.calendar,
                      size: 14,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      company['period'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  company['description'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (company['technologies'] as List<String>).map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (company['color'] as Color).withOpacity(0.2),
                        border: Border.all(
                          color: (company['color'] as Color).withOpacity(0.5),
                        ),
                      ),
                      child: Text(
                        tech,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final url = Uri.parse(company['website'] as String);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Mehr erfahren',
                        style: TextStyle(
                          fontSize: 14,
                          color: company['color'] as Color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 14,
                        color: company['color'] as Color,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}