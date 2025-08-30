import 'package:flutter/material.dart';
import 'dart:math' as math;

class NeumorphicButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isPrimary;
  final double? width;
  final double height;

  const NeumorphicButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isPrimary = true,
    this.width,
    this.height = 65,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _depthAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _pulseAnimation;
  
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _depthAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isPrimary 
      ? const Color(0xFF0080FF)
      : const Color(0xFF2C2C34);
    
    final darkColor = widget.isPrimary
      ? const Color(0xFF0066CC)
      : const Color(0xFF1C1C24);
    
    final lightColor = widget.isPrimary
      ? const Color(0xFF00BFFF)
      : const Color(0xFF3E3E46);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedBuilder(
          animation: Listenable.merge([_controller, _pulseController]),
          builder: (context, child) {
            final depth = _depthAnimation.value;
            final isInset = !_isHovered;
            
            return Container(
              width: widget.width,
              height: widget.height,
              child: Stack(
                children: [
                  // Background with inner shadow effect
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1A1A1A),
                          const Color(0xFF0A0A0A),
                        ],
                      ),
                    ),
                  ),
                  
                  // Main button container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    transform: Matrix4.identity()
                      ..translate(
                        _isPressed ? 2.0 : (isInset ? 0.0 : -2.0 * depth),
                        _isPressed ? 2.0 : (isInset ? 0.0 : -2.0 * depth),
                      ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _isHovered 
                          ? [
                              baseColor,
                              darkColor,
                            ]
                          : [
                              const Color(0xFF1C1C24),
                              const Color(0xFF121216),
                            ],
                      ),
                      boxShadow: isInset 
                        ? [
                            // Inner shadow (inset effect)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              offset: const Offset(4, 4),
                              blurRadius: 8,
                              spreadRadius: -4,
                            ),
                            BoxShadow(
                              color: const Color(0xFF2C2C34).withOpacity(0.3),
                              offset: const Offset(-4, -4),
                              blurRadius: 8,
                              spreadRadius: -4,
                            ),
                          ]
                        : [
                            // Outer shadow (elevated effect)
                            BoxShadow(
                              color: baseColor.withOpacity(0.4 * depth),
                              offset: Offset(
                                5 * depth,
                                5 * depth,
                              ),
                              blurRadius: 15 + (10 * depth),
                              spreadRadius: 2 * depth,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              offset: Offset(
                                8 * depth,
                                8 * depth,
                              ),
                              blurRadius: 20 + (10 * depth),
                            ),
                            BoxShadow(
                              color: lightColor.withOpacity(0.2 * depth),
                              offset: Offset(
                                -3 * depth,
                                -3 * depth,
                              ),
                              blurRadius: 10 * depth,
                            ),
                          ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          // Gradient overlay for depth
                          if (isInset)
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.3),
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.05),
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          
                          // Glow effect when hovering
                          if (_isHovered && widget.isPrimary)
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      center: Alignment.center,
                                      radius: 1.5,
                                      colors: [
                                        baseColor.withOpacity(0.3 * _pulseAnimation.value),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          
                          // Inner light effect for depth
                          if (!isInset)
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              height: widget.height * 0.5,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(0.2),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          
                          // Content
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.icon != null) ...[
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    transform: Matrix4.identity()
                                      ..rotateZ(_isHovered ? math.pi * 0.1 : 0),
                                    child: Icon(
                                      widget.icon,
                                      color: _isHovered 
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.7),
                                      size: 24,
                                      shadows: _isHovered
                                        ? [
                                            Shadow(
                                              color: baseColor,
                                              blurRadius: 20,
                                            ),
                                          ]
                                        : [],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: TextStyle(
                                    color: _isHovered 
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: _isHovered ? 2.5 : 2,
                                    shadows: [
                                      if (isInset)
                                        const Shadow(
                                          color: Colors.black,
                                          offset: Offset(1, 1),
                                          blurRadius: 2,
                                        ),
                                      if (_isHovered)
                                        Shadow(
                                          color: baseColor,
                                          blurRadius: 30,
                                        ),
                                    ],
                                  ),
                                  child: Text(widget.text.toUpperCase()),
                                ),
                                if (_isHovered) ...[
                                  const SizedBox(width: 8),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    transform: Matrix4.identity()
                                      ..translate(_isHovered ? 0.0 : -10.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white.withOpacity(0.8),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          
                          // Border gradient
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isHovered
                                  ? baseColor.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.3),
                                width: isInset ? 1 : 2,
                              ),
                            ),
                          ),
                        ],
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
}