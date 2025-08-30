import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class CompanySection extends StatefulWidget {
  const CompanySection({super.key});

  @override
  State<CompanySection> createState() => _CompanySectionState();
}

class _CompanySectionState extends State<CompanySection> 
    with TickerProviderStateMixin {
  int? hoveredIndex;
  late AnimationController _floatingController;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1200;
    final isTablet = screenSize.width > 600 && screenSize.width <= 1200;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : (isTablet ? 60 : 30),
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F0F11),
            Color(0xFF1A1A1D),
            Color(0xFF141417),
          ],
        ),
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
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi) * 8),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF8E8E93),
                    Color(0xFFFAFAFA),
                    Color(0xFF8E8E93),
                  ],
                ).createShader(bounds),
                child: const Text(
                  'TRUSTED BY LEADING COMPANIES',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Collaborating with innovative brands worldwide',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompanyGrid(BuildContext context) {
    final companies = [
      {
        'name': 'TechCorp Solutions',
        'description': 'Enterprise Software Development',
        'icon': FontAwesomeIcons.microchip,
        'url': 'https://example.com',
        'color1': const Color(0xFF007AFF),
        'color2': const Color(0xFF0066CC),
      },
      {
        'name': 'Digital Innovations',
        'description': 'AI & Machine Learning',
        'icon': FontAwesomeIcons.brain,
        'url': 'https://example.com',
        'color1': const Color(0xFF5E5CE6),
        'color2': const Color(0xFF4B4BC3),
      },
      {
        'name': 'CloudScale Systems',
        'description': 'Cloud Infrastructure',
        'icon': FontAwesomeIcons.cloud,
        'url': 'https://example.com',
        'color1': const Color(0xFF00C7BE),
        'color2': const Color(0xFF00A098),
      },
      {
        'name': 'DataFlow Analytics',
        'description': 'Big Data Solutions',
        'icon': FontAwesomeIcons.chartLine,
        'url': 'https://example.com',
        'color1': const Color(0xFFFF3B30),
        'color2': const Color(0xFFD70015),
      },
      {
        'name': 'SecureNet Pro',
        'description': 'Cybersecurity Services',
        'icon': FontAwesomeIcons.shield,
        'url': 'https://example.com',
        'color1': const Color(0xFF34C759),
        'color2': const Color(0xFF30A14E),
      },
      {
        'name': 'Mobile First Labs',
        'description': 'App Development',
        'icon': FontAwesomeIcons.mobileScreen,
        'url': 'https://example.com',
        'color1': const Color(0xFFFF9500),
        'color2': const Color(0xFFFF7A00),
      },
    ];

    return AnimationLimiter(
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,
        children: companies.asMap().entries.map((entry) {
          final index = entry.key;
          final company = entry.value;
          
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 800),
            columnCount: 3,
            child: ScaleAnimation(
              scale: 0.5,
              child: FadeInAnimation(
                child: _buildCompanyCard(company, index),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCompanyCard(Map<String, dynamic> company, int index) {
    final isHovered = hoveredIndex == index;
    
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(company['url']),
        child: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 300,
              height: 200,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(isHovered ? 0.05 : 0)
                ..scale(isHovered ? 1.05 : 1.0)
                ..translate(0.0, isHovered ? -10.0 : 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isHovered
                      ? [
                          company['color1'] as Color,
                          company['color2'] as Color,
                        ]
                      : [
                          const Color(0xFF2A2A2D),
                          const Color(0xFF1A1A1D),
                        ],
                ),
                border: Border.all(
                  color: isHovered
                      ? (company['color1'] as Color).withValues(alpha: 0.5)
                      : const Color(0xFF2A2A2D),
                  width: 1,
                ),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: (company['color1'] as Color).withValues(alpha: 0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                        const BoxShadow(
                          color: Colors.black,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ]
                    : [
                        const BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
              ),
              child: Stack(
                children: [
                  // Animated background pattern
                  if (isHovered)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedBuilder(
                          animation: _rotationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationController.value * 2 * math.pi,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    center: const Alignment(0.7, -0.6),
                                    radius: 1.2,
                                    colors: [
                                      Colors.white.withValues(alpha: 0.2),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isHovered
                                ? Colors.white.withValues(alpha: 0.2)
                                : Colors.white.withValues(alpha: 0.05),
                            border: Border.all(
                              color: isHovered
                                  ? Colors.white.withValues(alpha: 0.3)
                                  : Colors.white.withValues(alpha: 0.1),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            company['icon'] as IconData,
                            color: isHovered
                                ? Colors.white
                                : const Color(0xFF8E8E93),
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          company['name'] as String,
                          style: TextStyle(
                            color: isHovered
                                ? Colors.white
                                : const Color(0xFF8E8E93),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          company['description'] as String,
                          style: TextStyle(
                            color: isHovered
                                ? Colors.white.withValues(alpha: 0.9)
                                : const Color(0xFF8E8E93).withValues(alpha: 0.7),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Arrow indicator
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isHovered ? 1.0 : 0.0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}