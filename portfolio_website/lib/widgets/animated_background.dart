import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});
  
  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  final int particleCount = 80;
  
  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      particleCount,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(seconds: 10 + math.Random().nextInt(10)),
      ),
    );
    
    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ));
    }).toList();
    
    for (var controller in _controllers) {
      controller.repeat();
    }
  }
  
  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? [
                  const Color(0xFF0A0A0A),
                  const Color(0xFF121216),
                  const Color(0xFF1C1C24),
                  const Color(0xFF2C2C34),
                ]
              : [
                  const Color(0xFFF7F7F7),
                  const Color(0xFFE8E8E8),
                  const Color(0xFFD9D9D9),
                  const Color(0xFFCACACA),
                ],
        ),
      ),
      child: Stack(
        children: List.generate(
          particleCount,
          (index) => AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Positioned(
                left: math.Random().nextDouble() * MediaQuery.of(context).size.width,
                top: _animations[index].value * MediaQuery.of(context).size.height,
                child: _buildParticle(index),
              );
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildParticle(int index) {
    final random = math.Random(index);
    final size = 1.0 + random.nextDouble() * 3;
    final opacity = 0.05 + random.nextDouble() * 0.2;
    final isBlue = random.nextBool();
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: isBlue ? [
            const Color(0xFF0080FF).withOpacity(opacity),
            const Color(0xFF0080FF).withOpacity(0),
          ] : [
            const Color(0xFF00BFFF).withOpacity(opacity * 0.5),
            const Color(0xFF00BFFF).withOpacity(0),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: isBlue 
              ? const Color(0xFF0080FF).withOpacity(opacity * 0.3)
              : const Color(0xFF00BFFF).withOpacity(opacity * 0.2),
            blurRadius: size * 4,
            spreadRadius: size * 2,
          ),
        ],
      ),
    );
  }
}