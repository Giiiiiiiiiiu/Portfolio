import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import '../services/content_service.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _scrollButtonController;
  late AnimationController _floatingController;
  late AnimationController _shimmerController;
  final ContentService _contentService = ContentService();
  String heroName = '';
  List<String> heroTitles = [];
  String heroDescription = '';

  Color get _primaryColor =>
      MediaQuery.of(context).platformBrightness == Brightness.dark
          ? const Color(0xFF007AFF)
          : const Color(0xFF0055CC);

  Color get _backgroundColor =>
      MediaQuery.of(context).platformBrightness == Brightness.dark
          ? const Color(0xFF0A0A0B)
          : Colors.white;

  Color get _textColor =>
      MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Colors.white
          : Colors.black;

  LinearGradient get _backgroundGradient =>
      MediaQuery.of(context).platformBrightness == Brightness.dark
          ? const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0A0A0B),
                Color(0xFF141417),
                Color(0xFF1A1A1D),
              ],
            )
          : LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.grey[50]!,
                Colors.grey[100]!,
              ],
            );

  @override
  void initState() {
    super.initState();
    _scrollButtonController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _loadHeroContent();
  }

  Future<void> _loadHeroContent() async {
    await _contentService.loadHomeContent();
    setState(() {
      heroName = _contentService.heroName;
      heroTitles = _contentService.heroTitles;
      heroDescription = _contentService.heroDescription;
    });
  }

  @override
  void dispose() {
    _scrollButtonController.dispose();
    _floatingController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  void _scrollToNext() {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: _backgroundGradient,
      ),
      child: Stack(
        children: [
          // Animated background particles
          _buildParticleBackground(),

          // Grid pattern overlay
          _buildGridPattern(),

          // Animated shimmer effect
          AnimatedBuilder(
            animation: _shimmerController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.5 + 3 * _shimmerController.value, -1.5),
                    end: Alignment(-0.5 + 3 * _shimmerController.value, -0.5),
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.03),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),

          // Main content with full width
          Positioned.fill(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Changed from center to start
              children: [
                const SizedBox(height: 80),
                _buildMainContent(
                    context, size), // Removed SizedBox height at top
                const Spacer(), // Added spacer to push scroll button to bottom
                const SizedBox(height: 120), // Kept space for scroll button
              ],
            ),
          ),

          // Floating geometric shapes
          _buildFloatingShapes(),

          // Premium scroll down button
          _buildPremiumScrollButton(context),
        ],
      ),
    );
  }

  Widget _buildParticleBackground() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(_floatingController.value),
          child: Container(),
        );
      },
    );
  }

  Widget _buildGridPattern() {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Positioned.fill(
      child: Stack(
        children: [
          CustomPaint(
            painter: GridPatternPainter(
              color: isDark
                  ? Colors.white.withOpacity(0.02)
                  : Colors.black.withOpacity(0.05),
            ),
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingShapes() {
    return Stack(
      children: [
        ...List.generate(5, (index) {
          return AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                final offset =
                    math.sin(_floatingController.value * math.pi + index) * 20;
                return Positioned(
                  top: 100.0 + index * 120 + offset,
                  left: index.isEven ? 50.0 + offset : null,
                  right: index.isOdd ? 50.0 - offset : null,
                  child: Transform.rotate(
                    angle: _floatingController.value * 2 * math.pi + index,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF007AFF).withValues(alpha: 0.1),
                            const Color(0xFF0066CC).withValues(alpha: 0.05),
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFF007AFF).withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                );
              });
        }),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context, Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 1200 ? 100 : (size.width > 600 ? 60 : 30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimationConfiguration.synchronized(
            duration: const Duration(milliseconds: 1200),
            child: SlideAnimation(
              verticalOffset: -30,
              curve: Curves.easeOutQuart,
              child: FadeInAnimation(
                child: Column(
                  children: [
                    // Profile image with animated border
                    Container(
                      width: size.width > 600 ? 150 : 120,
                      height: size.width > 600 ? 150 : 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF007AFF).withOpacity(0.3),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF007AFF).withOpacity(0.5),
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          '../assets/images/me.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Silver text effect
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? const [
                                Color(0xFF8E8E93),
                                Color(0xFFFAFAFA),
                                Color(0xFF8E8E93),
                              ]
                            : [
                                Color(0xFF2E2E2E),
                                Color(0xFF000000),
                                Color(0xFF2E2E2E),
                              ],
                      ).createShader(bounds),
                      child: Text(
                        'SERGEY KOTENKOV',
                        style: TextStyle(
                          fontSize: size.width > 1200
                              ? 72
                              : (size.width > 600 ? 54 : 36),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4.0,
                          height: 1.2,
                          color: _textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Simplified animated titles
          AnimationConfiguration.synchronized(
            duration: const Duration(milliseconds: 1400),
            child: SlideAnimation(
              verticalOffset: -20,
              curve: Curves.easeOutQuart,
              child: FadeInAnimation(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: size.width > 600 ? 28 : 22,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                    letterSpacing: 2.0,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: heroTitles
                        .map(
                          (title) => TypewriterAnimatedText(
                            title,
                            speed: const Duration(milliseconds: 100),
                            cursor: '|',
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Description with glass effect
          AnimationConfiguration.synchronized(
            duration: const Duration(milliseconds: 1600),
            child: SlideAnimation(
              verticalOffset: -10,
              curve: Curves.easeOutQuart,
              child: FadeInAnimation(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    color: _textColor.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Text(
                    heroDescription,
                    style: TextStyle(
                      fontSize: size.width > 600 ? 18 : 16,
                      color: _textColor.withOpacity(0.7),
                      height: 1.6,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // CTA Buttons
          AnimationConfiguration.synchronized(
            duration: const Duration(milliseconds: 1800),
            child: SlideAnimation(
              verticalOffset: 20,
              curve: Curves.easeOutQuart,
              child: FadeInAnimation(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCTAButton(
                      'View Projects',
                      FontAwesomeIcons.rocket,
                      true,
                      () {},
                    ),
                    const SizedBox(width: 20),
                    _buildCTAButton(
                      'Contact Me',
                      FontAwesomeIcons.envelope,
                      false,
                      () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(
      String text, IconData icon, bool isPrimary, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? LinearGradient(
                    colors: [
                      _primaryColor,
                      _primaryColor.withOpacity(0.8),
                    ],
                  )
                : null,
            color: isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isPrimary ? Colors.transparent : _primaryColor,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isPrimary ? _backgroundColor : _primaryColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: isPrimary ? _backgroundColor : _primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumScrollButton(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Center(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _scrollToNext,
            child: AnimatedBuilder(
              animation: _scrollButtonController,
              builder: (context, child) {
                final bounce =
                    math.sin(_scrollButtonController.value * math.pi * 2) * 5;
                return Transform.translate(
                  offset: Offset(0, bounce),
                  child: Container(
                    width: 50,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.1),
                          Colors.white.withValues(alpha: 0.05),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFF007AFF).withValues(alpha: 0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF007AFF).withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Animated scroll wheel
                        AnimatedBuilder(
                          animation: _scrollButtonController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                  0, -20 + 30 * _scrollButtonController.value),
                              child: Container(
                                width: 4,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: const Color(0xFF007AFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF007AFF)
                                          .withValues(alpha: 0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Arrow indicators
                        Positioned(
                          bottom: 10,
                          child: Column(
                            children: [
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: const Color(0xFF007AFF).withValues(
                                  alpha: 0.3 +
                                      0.3 *
                                          math.sin(
                                              _scrollButtonController.value *
                                                  math.pi *
                                                  2),
                                ),
                                size: 20,
                              ),
                              Transform.translate(
                                offset: const Offset(0, -10),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: const Color(0xFF007AFF).withValues(
                                    alpha: 0.5 +
                                        0.3 *
                                            math.sin(
                                                _scrollButtonController.value *
                                                        math.pi *
                                                        2 +
                                                    1),
                                  ),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painters for background effects
class ParticlePainter extends CustomPainter {
  final double animationValue;

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF007AFF).withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 50; i++) {
      final x = (i * 73 + animationValue * size.width) % size.width;
      final y = (i * 37 + animationValue * size.height) % size.height;
      final radius = 1.0 + math.sin(animationValue * math.pi + i) * 0.5;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

class GridPatternPainter extends CustomPainter {
  final Color color;

  GridPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const spacing = 50.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(GridPatternPainter oldDelegate) =>
      oldDelegate.color != color;
}
