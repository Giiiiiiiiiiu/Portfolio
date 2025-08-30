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
  final int particleCount = 50;
  
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
                  const Color(0xFF000000),
                  const Color(0xFF0A0A0A),
                  const Color(0xFF1A1A1A),
                ]
              : [
                  const Color(0xFFFAFAFA),
                  const Color(0xFFF5F5F5),
                  const Color(0xFFEEEEEE),
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
    final size = 2.0 + random.nextDouble() * 4;
    final opacity = 0.1 + random.nextDouble() * 0.4;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor.withOpacity(opacity),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(opacity * 0.5),
            blurRadius: size * 2,
            spreadRadius: size,
          ),
        ],
      ),
    );
  }
}