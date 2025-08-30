import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/ferrari_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: FerrariTheme.luxuryGradient,
      ),
      child: Stack(
        children: [
          // Subtle carbon fiber pattern background
          _buildCarbonFiberPattern(),
          
          // Animated metallic shimmer overlay
          _buildMetallicShimmer(),
          
          // Main content
          Center(
            child: AnimationConfiguration.synchronized(
              duration: FerrariTheme.elegantAnimation,
              child: SlideAnimation(
                verticalOffset: 50.0,
                curve: FerrariTheme.luxuryCurve,
                child: FadeInAnimation(
                  curve: FerrariTheme.smoothCurve,
                  child: _buildLuxuryContainer(context, size),
                ),
              ),
            ),
          ),
          
          // Floating elements for depth
          _buildFloatingElements(context),
          
          // Scroll indicator with luxury style
          _buildLuxuryScrollIndicator(context),
        ],
      ),
    );
  }
  
  // Carbon fiber texture background
  Widget _buildCarbonFiberPattern() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              FerrariTheme.carbonFiber.withValues(alpha: 0.1),
              FerrariTheme.darkGray.withValues(alpha: 0.05),
              Colors.transparent,
            ],
          ),
        ),
        child: CustomPaint(
          painter: CarbonFiberPainter(),
        ),
      ),
    );
  }
  
  // Animated metallic shimmer effect
  Widget _buildMetallicShimmer() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 4),
      builder: (context, value, child) {
        return AnimatedContainer(
          duration: const Duration(seconds: 4),
          child: Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0 + 2.0 * value, -1.0),
                  end: Alignment(1.0 + 2.0 * value, 1.0),
                  colors: [
                    Colors.transparent,
                    FerrariTheme.silverAccent.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  // Main luxury container
  Widget _buildLuxuryContainer(BuildContext context, Size size) {
    return Container(
      width: size.width * 0.85,
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      decoration: BoxDecoration(
        gradient: FerrariTheme.metallicSheen,
        borderRadius: FerrariTheme.luxuryRadius,
        border: Border.all(
          color: FerrariTheme.silverAccent.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          ...FerrariTheme.luxuryShadow,
          BoxShadow(
            color: FerrariTheme.silverAccent.withValues(alpha: 0.1),
            blurRadius: 60,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLuxuryAvatar(context),
          const SizedBox(height: 40),
          _buildFerrariName(context),
          const SizedBox(height: 25),
          _buildLuxuryAnimatedTitle(context),
          const SizedBox(height: 50),
          _buildElegantDescription(context),
          const SizedBox(height: 60),
          _buildFerrariActionButtons(context),
        ],
      ),
    );
  }
  
  // Luxury avatar with Ferrari styling
  Widget _buildLuxuryAvatar(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: FerrariTheme.elegantAnimation,
      curve: FerrariTheme.luxuryCurve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + 0.2 * value,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: FerrariTheme.ferrariGradient,
              border: Border.all(
                color: FerrariTheme.silverAccent.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: FerrariTheme.carbonFiber.withValues(alpha: 0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: FerrariTheme.silverAccent.withValues(alpha: 0.2),
                  blurRadius: 60,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/profile.jpg',
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: FerrariTheme.metallicSheen,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 90,
                          color: FerrariTheme.pureWhite,
                        ),
                      );
                    },
                  ),
                  // Metallic overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          FerrariTheme.silverAccent.withValues(alpha: 0.1),
                          Colors.transparent,
                          FerrariTheme.metallicGray.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  // Ferrari-styled name with metallic gradient
  Widget _buildFerrariName(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          FerrariTheme.pureWhite,
          FerrariTheme.silverAccent,
          FerrariTheme.pureWhite,
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(bounds),
      child: Text(
        'SERGEY KOTENKOV',
        style: FerrariTheme.ferrariHeadline.copyWith(
          fontSize: MediaQuery.of(context).size.width < 768 ? 36 : 56,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  
  // Luxury animated title
  Widget _buildLuxuryAnimatedTitle(BuildContext context) {
    return SizedBox(
      height: 60,
      child: DefaultTextStyle(
        style: FerrariTheme.luxuryTitle.copyWith(
          color: FerrariTheme.silverAccent,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          pause: const Duration(milliseconds: 2000),
          animatedTexts: [
            TypewriterAnimatedText(
              'LUXURY DEVELOPER',
              speed: const Duration(milliseconds: 100),
            ),
            TypewriterAnimatedText(
              'PREMIUM DESIGNER',
              speed: const Duration(milliseconds: 100),
            ),
            TypewriterAnimatedText(
              'DIGITAL ARCHITECT',
              speed: const Duration(milliseconds: 100),
            ),
            TypewriterAnimatedText(
              'CODE ARTISAN',
              speed: const Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
    );
  }
  
  // Elegant description
  Widget _buildElegantDescription(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Text(
        'Crafting premium digital experiences with Ferrari-level precision and luxury. Where code meets artistry in the pursuit of technological excellence.',
        textAlign: TextAlign.center,
        style: FerrariTheme.elegantSubtitle.copyWith(
          fontSize: MediaQuery.of(context).size.width < 768 ? 16 : 18,
        ),
      ),
    );
  }
  
  // Ferrari-inspired action buttons
  Widget _buildFerrariActionButtons(BuildContext context) {
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _buildLuxuryButton(
          text: 'VIEW PORTFOLIO',
          icon: Icons.visibility_outlined,
          isPrimary: true,
          onPressed: () {},
        ),
        _buildLuxuryButton(
          text: 'GET IN TOUCH',
          icon: Icons.mail_outline_rounded,
          isPrimary: false,
          onPressed: () {},
        ),
      ],
    );
  }
  
  // Luxury button with Ferrari styling
  Widget _buildLuxuryButton({
    required String text,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: FerrariTheme.elegantAnimation,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.9 + 0.1 * value,
          child: Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
              gradient: isPrimary ? FerrariTheme.ferrariGradient : null,
              color: isPrimary ? null : Colors.transparent,
              borderRadius: FerrariTheme.subtleRadius,
              border: Border.all(
                color: isPrimary 
                    ? Colors.transparent 
                    : FerrariTheme.silverAccent.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: isPrimary ? [
                BoxShadow(
                  color: FerrariTheme.carbonFiber.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ] : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: FerrariTheme.subtleRadius,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: FerrariTheme.pureWhite,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      text,
                      style: const TextStyle(
                        color: FerrariTheme.pureWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  // Floating elements for depth
  Widget _buildFloatingElements(BuildContext context) {
    return Stack(
      children: [
        // Top left floating element
        Positioned(
          top: 100,
          left: 50,
          child: _buildFloatingElement(0.6, 2.5),
        ),
        // Top right floating element
        Positioned(
          top: 150,
          right: 80,
          child: _buildFloatingElement(0.4, 3.0),
        ),
        // Bottom left floating element
        Positioned(
          bottom: 200,
          left: 100,
          child: _buildFloatingElement(0.5, 2.8),
        ),
      ],
    );
  }
  
  Widget _buildFloatingElement(double opacity, double duration) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: (duration * 1000).toInt()),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -20 * value),
          child: Opacity(
            opacity: opacity * value,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    FerrariTheme.silverAccent.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  // Luxury scroll indicator
  Widget _buildLuxuryScrollIndicator(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 2500),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Column(
              children: [
                Text(
                  'SCROLL TO EXPLORE',
                  style: TextStyle(
                    color: FerrariTheme.silverAccent.withValues(alpha: 0.8),
                    fontSize: 12,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: -10, end: 10),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, value),
                      child: Container(
                        width: 2,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              FerrariTheme.silverAccent.withValues(alpha: 0.6),
                              Colors.transparent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Custom painter for carbon fiber pattern
class CarbonFiberPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = FerrariTheme.carbonFiber.withValues(alpha: 0.03)
      ..strokeWidth = 0.5;
      
    const spacing = 20.0;
    
    // Draw diagonal lines for carbon fiber effect
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
    
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i + spacing / 2, 0),
        Offset(i + size.height + spacing / 2, size.height),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}