import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({Key? key}) : super(key: key);

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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1a1a2e),
            const Color(0xFF16213e),
            const Color(0xFF0f3460),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 60),
          _buildEducationTimeline(context),
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
                    const Color(0xFF00D2FF),
                    const Color(0xFF3A7BD5),
                    const Color(0xFF00D2FF),
                  ],
                ).createShader(bounds),
                child: const Text(
                  'Bildungsweg',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Meine akademische und berufliche Entwicklung',
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

  Widget _buildEducationTimeline(BuildContext context) {
    final educationData = [
      {
        'title': 'Bachelor - Angewandte Informatik',
        'institution': 'Hochschule/Universität',
        'period': 'Seit 2024',
        'description': 'Aktuell im Studium - Software Engineering, Web Development, KI-Integration',
        'icon': FontAwesomeIcons.graduationCap,
        'color': const Color(0xFF0080FF),
      },
      {
        'title': 'Fachhochschulreife',
        'institution': 'Fachoberschule',
        'period': '2022 - 2024',
        'description': 'Schwerpunkt Informatik - Programmierung, Datenbanken, Netzwerktechnik',
        'icon': FontAwesomeIcons.school,
        'color': const Color(0xFF00BFFF),
      },
    ];

    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 100,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: educationData.asMap().entries.map((entry) {
            final index = entry.key;
            final education = entry.value;
            final isLeft = index % 2 == 0;
            
            return _buildTimelineItem(
              context,
              education,
              isLeft,
              index == educationData.length - 1,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    Map<String, dynamic> education,
    bool isLeft,
    bool isLast,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    
    if (isMobile) {
      return _buildMobileTimelineItem(context, education, isLast);
    }
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side
            Expanded(
              child: isLeft
                  ? _buildEducationCard(context, education)
                  : const SizedBox(),
            ),
            
            // Timeline
            Column(
              children: [
                _buildTimelineNode(education['color'] as Color, education['icon'] as IconData),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          education['color'] as Color,
                          Colors.white.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            
            // Right side
            Expanded(
              child: !isLeft
                  ? _buildEducationCard(context, education)
                  : const SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileTimelineItem(
    BuildContext context,
    Map<String, dynamic> education,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline
        Column(
          children: [
            _buildTimelineNode(education['color'] as Color, education['icon'] as IconData),
            if (!isLast)
              Container(
                width: 2,
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      education['color'] as Color,
                      Colors.white.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20),
        // Card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: _buildEducationCard(context, education),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineNode(Color color, IconData icon) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.8),
            color,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context, Map<String, dynamic> education) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GlassmorphicContainer(
          width: double.infinity,
          height: 140,
          borderRadius: 20,
          blur: 20,
          alignment: Alignment.center,
          border: 2,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (education['color'] as Color).withOpacity(0.5),
              Colors.white.withOpacity(0.2),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      education['title'] as String,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: education['color'] as Color,
                      ),
                    ),
                    Text(
                      education['period'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  education['institution'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  education['description'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
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