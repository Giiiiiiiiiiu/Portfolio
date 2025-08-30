import 'package:flutter/material.dart';
import 'dart:math' as math;

class PremiumButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isPrimary;
  final double? width;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isPrimary = true,
    this.width,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _shimmerController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _shimmerAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(_shimmerController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: Listenable.merge([_controller, _shimmerController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _isPressed ? 0.95 : _scaleAnimation.value,
              child: Container(
                width: widget.width,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isPrimary 
                        ? const Color(0xFF0080FF).withOpacity(0.4 * _glowAnimation.value)
                        : Colors.black.withOpacity(0.3),
                      blurRadius: 30 + (20 * _glowAnimation.value),
                      offset: const Offset(0, 10),
                      spreadRadius: _isHovered ? 5 : 0,
                    ),
                    if (widget.isPrimary && _isHovered)
                      BoxShadow(
                        color: const Color(0xFF00BFFF).withOpacity(0.2),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      // Background Gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: widget.isPrimary
                              ? [
                                  const Color(0xFF0080FF),
                                  const Color(0xFF0066CC),
                                  const Color(0xFF004499),
                                ]
                              : [
                                  const Color(0xFF2C2C34),
                                  const Color(0xFF1C1C24),
                                  const Color(0xFF121216),
                                ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                      
                      // Shimmer Effect
                      if (widget.isPrimary && _isHovered)
                        AnimatedBuilder(
                          animation: _shimmerAnimation,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.2),
                                    Colors.transparent,
                                  ],
                                  stops: [
                                    (_shimmerAnimation.value - 0.3).clamp(0.0, 1.0),
                                    _shimmerAnimation.value.clamp(0.0, 1.0),
                                    (_shimmerAnimation.value + 0.3).clamp(0.0, 1.0),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      
                      // Glass Effect Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(_isHovered ? 0.2 : 0.1),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.5],
                          ),
                        ),
                      ),
                      
                      // Border
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: _isHovered
                              ? const Color(0xFF00BFFF).withOpacity(0.6)
                              : widget.isPrimary 
                                ? const Color(0xFF0080FF).withOpacity(0.3)
                                : const Color(0xFF4A90E2).withOpacity(0.2),
                            width: _isHovered ? 2 : 1,
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
                              Transform.rotate(
                                angle: _isHovered ? math.pi * 0.1 : 0,
                                child: Icon(
                                  widget.icon,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            Text(
                              widget.text.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                letterSpacing: _isHovered ? 3 : 2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                  if (_isHovered)
                                    Shadow(
                                      color: widget.isPrimary 
                                        ? const Color(0xFF00BFFF)
                                        : Colors.white,
                                      blurRadius: 20,
                                    ),
                                ],
                              ),
                            ),
                            if (_isHovered) ...[
                              const SizedBox(width: 8),
                              Transform.translate(
                                offset: Offset(_isHovered ? 5 : 0, 0),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      // Particle Effects
                      if (_isHovered && widget.isPrimary)
                        ...List.generate(3, (index) {
                          return AnimatedPositioned(
                            duration: Duration(milliseconds: 500 + (index * 100)),
                            curve: Curves.easeOut,
                            left: _isHovered ? 20.0 + (index * 30) : -10,
                            top: _isHovered ? 10.0 + (index * 10) : 60,
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF00BFFF),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00BFFF),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}