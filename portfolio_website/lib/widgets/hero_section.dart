import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'animated_background.dart';
import 'premium_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          const AnimatedBackground(),
          Center(
            child: AnimationConfiguration.synchronized(
              duration: const Duration(milliseconds: 1500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: GlassmorphicContainer(
                    width: size.width * 0.8,
                    height: size.height * 0.6,
                    borderRadius: 0,
                    blur: 30,
                    alignment: Alignment.center,
                    border: 2,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2C2C34).withOpacity(0.4),
                        const Color(0xFF1C1C24).withOpacity(0.2),
                      ],
                    ),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFF0000).withOpacity(0.2),
                        const Color(0xFFB8B8C0).withOpacity(0.1),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAvatar(context),
                          const SizedBox(height: 30),
                          _buildName(context),
                          const SizedBox(height: 20),
                          _buildAnimatedTitle(context),
                          const SizedBox(height: 40),
                          _buildDescription(context),
                          const SizedBox(height: 40),
                          _buildActionButtons(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildScrollIndicator(context),
        ],
      ),
    );
  }
  
  Widget _buildAvatar(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1500),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2C2C34), Color(0xFF4A4A52), Color(0xFF3E3E46)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF0000).withOpacity(0.5),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildName(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFB8B8C0), Color(0xFFFEFEFE), Color(0xFF4A4A52)],
      ).createShader(bounds),
      child: Text(
        'SERGEJ DAVID',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  Widget _buildAnimatedTitle(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Theme.of(context).primaryColor,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText('LUXURY DEVELOPER'),
            TypewriterAnimatedText('PREMIUM DESIGNER'),
            TypewriterAnimatedText('DIGITAL ARCHITECT'),
            TypewriterAnimatedText('CODE ARTIST'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDescription(BuildContext context) {
    return Text(
      'Leidenschaftlicher Entwickler mit Fokus auf moderne Webtechnologien und außergewöhnliche Benutzererfahrungen.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
      ),
    );
  }
  
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PremiumButton(
          text: 'VIEW PROJECTS',
          icon: Icons.speed,
          onPressed: () {},
          isPrimary: true,
        ),
        const SizedBox(width: 30),
        PremiumButton(
          text: 'CONTACT',
          icon: Icons.send,
          onPressed: () {},
          isPrimary: false,
        ),
      ],
    );
  }
  
  Widget _buildScrollIndicator(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 2000),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Column(
              children: [
                Text(
                  'Scroll down',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 2),
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(0, value * 10),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
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