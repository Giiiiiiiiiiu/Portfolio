import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/ferrari_theme.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1200;
    final isTablet = screenSize.width > 600 && screenSize.width <= 1200;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 140 : (isTablet ? 80 : 40),
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        gradient: FerrariTheme.luxuryGradient,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 80),
          _buildEducationTimeline(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        duration: FerrariTheme.elegantAnimation,
        verticalOffset: -60,
        curve: FerrariTheme.luxuryCurve,
        child: FadeInAnimation(
          duration: FerrariTheme.elegantAnimation,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      FerrariTheme.silverAccent,
                      FerrariTheme.pureWhite,
                      FerrariTheme.metallicGray,
                      FerrariTheme.silverAccent,
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0],
                  ).createShader(bounds),
                  child: Text(
                    'BILDUNGSWEG',
                    style: FerrariTheme.ferrariHeadline.copyWith(
                      fontSize: 52,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Meine akademische und berufliche Entwicklung',
                  style: FerrariTheme.elegantSubtitle.copyWith(
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
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
        'color': FerrariTheme.silverAccent,
        'accentColor': FerrariTheme.pureWhite,
      },
      {
        'title': 'Fachhochschulreife',
        'institution': 'Fachoberschule',
        'period': '2022 - 2024',
        'description': 'Schwerpunkt Informatik - Programmierung, Datenbanken, Netzwerktechnik',
        'icon': FontAwesomeIcons.school,
        'color': FerrariTheme.lightGray,
        'accentColor': FerrariTheme.silverAccent,
      },
    ];

    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: FerrariTheme.smoothAnimation,
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 120,
            curve: FerrariTheme.luxuryCurve,
            child: FadeInAnimation(
              duration: FerrariTheme.elegantAnimation,
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
                    width: 3,
                    height: 140,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          FerrariTheme.silverAccent,
                          FerrariTheme.metallicGray,
                          FerrariTheme.lightGray,
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                        BoxShadow(
                          color: FerrariTheme.carbonFiber,
                          blurRadius: 4,
                          offset: Offset(1, 0),
                        ),
                      ],
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
                width: 3,
                height: 170,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      FerrariTheme.silverAccent,
                      FerrariTheme.metallicGray,
                      FerrariTheme.lightGray,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  boxShadow: [
                    BoxShadow(
                      color: FerrariTheme.carbonFiber,
                      blurRadius: 4,
                      offset: Offset(1, 0),
                    ),
                  ],
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
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FerrariTheme.silverAccent,
            FerrariTheme.metallicGray,
            FerrariTheme.primaryGray,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        boxShadow: FerrariTheme.luxuryShadow,
        border: Border.all(
          width: 2,
          color: FerrariTheme.carbonFiber,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              FerrariTheme.metallicGray,
              FerrariTheme.primaryGray,
            ],
          ),
        ),
        child: Icon(
          icon,
          color: FerrariTheme.pureWhite,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context, Map<String, dynamic> education) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: FerrariTheme.quickAnimation,
        curve: FerrariTheme.luxuryCurve,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                FerrariTheme.metallicGray,
                FerrariTheme.primaryGray,
                FerrariTheme.darkGray,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
            borderRadius: FerrariTheme.luxuryRadius,
            boxShadow: FerrariTheme.luxuryShadow,
            border: Border.all(
              width: 1,
              color: FerrariTheme.silverAccent.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and period
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      education['title'] as String,
                      style: FerrariTheme.luxuryTitle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: education['color'] as Color,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FerrariTheme.carbonFiber,
                          FerrariTheme.primaryGray,
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: FerrariTheme.silverAccent.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      education['period'] as String,
                      style: FerrariTheme.premiumBody.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: FerrariTheme.silverAccent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Institution
              Text(
                education['institution'] as String,
                style: FerrariTheme.elegantSubtitle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: FerrariTheme.pureWhite,
                ),
              ),
              const SizedBox(height: 12),
              
              // Description
              Text(
                education['description'] as String,
                style: FerrariTheme.premiumBody.copyWith(
                  fontSize: 15,
                  height: 1.6,
                  color: FerrariTheme.silverAccent.withValues(alpha: 0.9),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Decorative metallic line
              Container(
                height: 2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      FerrariTheme.silverAccent,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}