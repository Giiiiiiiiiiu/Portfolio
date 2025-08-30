import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/ferrari_theme.dart';

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
        horizontal: isDesktop ? 140 : (isTablet ? 80 : 40),
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        gradient: FerrariTheme.ferrariGradient,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 80),
          _buildCompanyGrid(context),
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
                    'MY COMPANY',
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
                  'Building the Future of Digital Solutions',
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

  Widget _buildCompanyGrid(BuildContext context) {
    final companies = [
      {
        'name': 'FESTUSCODE',
        'position': 'Founder & Lead Developer',
        'period': 'Seit 2024',
        'description': 'Gründer und Hauptentwickler - Innovative Softwarelösungen und digitale Produkte für moderne Unternehmen',
        'logo': FontAwesomeIcons.rocket,
        'color': FerrariTheme.silverAccent,
        'accentColor': FerrariTheme.pureWhite,
        'technologies': ['React', 'Next.js', 'Flutter', 'TypeScript', 'Node.js', 'AWS', 'PostgreSQL', 'Docker'],
        'website': 'https://festuscode.com',
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
          crossAxisSpacing: 40,
          mainAxisSpacing: 40,
          childAspectRatio: screenSize.width > 600 ? 1.6 : 1.2,
        ),
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: FerrariTheme.elegantAnimation,
            columnCount: crossAxisCount,
            child: ScaleAnimation(
              curve: FerrariTheme.luxuryCurve,
              child: FadeInAnimation(
                duration: FerrariTheme.smoothAnimation,
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
        duration: FerrariTheme.quickAnimation,
        curve: FerrariTheme.luxuryCurve,
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -12.0 : 0.0)
          ..scale(isHovered ? 1.03 : 1.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
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
            boxShadow: isHovered ? [
              ...FerrariTheme.luxuryShadow,
              BoxShadow(
                color: FerrariTheme.silverAccent.withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ] : FerrariTheme.subtleShadow,
            border: Border.all(
              width: 1.5,
              color: isHovered 
                ? FerrariTheme.silverAccent.withValues(alpha: 0.6)
                : FerrariTheme.silverAccent.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with logo and company info
              Row(
                children: [
                  Container(
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
                      boxShadow: [
                        BoxShadow(
                          color: FerrariTheme.carbonFiber.withValues(alpha: 0.8),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                      border: Border.all(
                        width: 2,
                        color: FerrariTheme.carbonFiber,
                      ),
                    ),
                    child: Icon(
                      company['logo'] as IconData,
                      color: FerrariTheme.pureWhite,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company['name'] as String,
                          style: FerrariTheme.luxuryTitle.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: company['color'] as Color,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          company['position'] as String,
                          style: FerrariTheme.elegantSubtitle.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: FerrariTheme.pureWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Period badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      FerrariTheme.carbonFiber,
                      FerrariTheme.primaryGray,
                    ],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: FerrariTheme.silverAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.calendar,
                      size: 14,
                      color: FerrariTheme.silverAccent,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      company['period'] as String,
                      style: FerrariTheme.premiumBody.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: FerrariTheme.silverAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Description
              Text(
                company['description'] as String,
                style: FerrariTheme.premiumBody.copyWith(
                  fontSize: 16,
                  height: 1.6,
                  color: FerrariTheme.silverAccent.withValues(alpha: 0.9),
                ),
              ),
              const Spacer(),
              
              // Technologies
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: (company['technologies'] as List<String>).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          FerrariTheme.darkGray,
                          FerrariTheme.carbonFiber,
                        ],
                        stops: [0.0, 1.0],
                      ),
                      border: Border.all(
                        color: FerrariTheme.lightGray.withValues(alpha: 0.4),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: FerrariTheme.carbonFiber.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      tech,
                      style: FerrariTheme.premiumBody.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: FerrariTheme.pureWhite.withValues(alpha: 0.9),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              
              // Website link
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FerrariTheme.silverAccent.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () async {
                    final url = Uri.parse(company['website'] as String);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'VISIT WEBSITE',
                          style: FerrariTheme.premiumBody.copyWith(
                            fontSize: 15,
                            color: company['color'] as Color,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          FontAwesomeIcons.arrowRight,
                          size: 16,
                          color: company['color'] as Color,
                        ),
                      ],
                    ),
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