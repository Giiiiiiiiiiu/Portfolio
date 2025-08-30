import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:math' as math;
import 'dart:ui';

class ModernSkillCard extends StatefulWidget {
  final String category;
  final IconData icon;
  final Color color;
  final int skillCount;
  final VoidCallback onTap;
  final bool isExpanded;

  const ModernSkillCard({
    super.key,
    required this.category,
    required this.icon,
    required this.color,
    required this.skillCount,
    required this.onTap,
    required this.isExpanded,
  });

  @override
  State<ModernSkillCard> createState() => _ModernSkillCardState();
}

class _ModernSkillCardState extends State<ModernSkillCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _hoverScale;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;
  
  bool _isHovered = false;
  double _mouseX = 0;
  double _mouseY = 0;

  @override
  void initState() {
    super.initState();
    
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _hoverScale = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutBack,
    ));
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_rotationController);
    
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      onHover: (event) {
        setState(() {
          _mouseX = event.localPosition.dx;
          _mouseY = event.localPosition.dy;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _hoverController,
            _pulseController,
            _rotationController,
          ]),
          builder: (context, child) {
            return Transform.scale(
              scale: widget.isExpanded ? 1.05 : _hoverScale.value,
              child: Container(
                width: 320,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    // Main shadow
                    BoxShadow(
                      color: widget.color.withOpacity(0.3 * _glowAnimation.value),
                      blurRadius: 40 + (20 * _glowAnimation.value),
                      spreadRadius: _isHovered ? 10 : 0,
                      offset: const Offset(0, 20),
                    ),
                    // Ambient shadow
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    children: [
                      // Animated gradient background
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(_mouseX / 320 - 0.5, _mouseY / 220 - 0.5),
                            end: Alignment.bottomRight,
                            colors: [
                              widget.color.withOpacity(0.9),
                              widget.color.withOpacity(0.6),
                              const Color(0xFF0A0A0A),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                      
                      // Animated mesh gradient overlay
                      AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: MeshGradientPainter(
                              rotation: _rotationAnimation.value,
                              color: widget.color,
                              opacity: _isHovered ? 0.3 : 0.1,
                            ),
                            child: Container(),
                          );
                        },
                      ),
                      
                      // Glass morphism layer
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.05),
                              ],
                            ),
                            border: Border.all(
                              color: widget.color.withOpacity(0.3),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Animated icon container
                                AnimatedBuilder(
                                  animation: _pulseAnimation,
                                  builder: (context, child) {
                                    return Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            widget.color,
                                            widget.color.withOpacity(0.4),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: widget.color.withOpacity(0.6 * _pulseAnimation.value),
                                            blurRadius: 30 * _pulseAnimation.value,
                                            spreadRadius: 10 * _pulseAnimation.value,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        widget.icon,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                                
                                // Skill count badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                  ),
                                  child: Text(
                                    '${widget.skillCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Animated button
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(
                                      colors: widget.isExpanded
                                        ? [
                                            Colors.white.withOpacity(0.2),
                                            Colors.white.withOpacity(0.1),
                                          ]
                                        : [
                                            widget.color.withOpacity(0.8),
                                            widget.color.withOpacity(0.6),
                                          ],
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    boxShadow: _isHovered
                                      ? [
                                          BoxShadow(
                                            color: widget.color.withOpacity(0.5),
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                          ),
                                        ]
                                      : [],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.isExpanded ? 'CLOSE' : 'EXPLORE',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      AnimatedRotation(
                                        duration: const Duration(milliseconds: 300),
                                        turns: widget.isExpanded ? 0.5 : 0,
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Floating particles
                      if (_isHovered)
                        ...List.generate(5, (index) {
                          return AnimatedPositioned(
                            duration: Duration(milliseconds: 1000 + (index * 200)),
                            curve: Curves.easeOutBack,
                            left: _isHovered 
                              ? 50.0 + (index * 40) + (math.Random().nextDouble() * 20)
                              : -20,
                            top: _isHovered 
                              ? 30.0 + (index * 20) + (math.Random().nextDouble() * 30)
                              : 250,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.color,
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.color,
                                    blurRadius: 12,
                                    spreadRadius: 3,
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

class MeshGradientPainter extends CustomPainter {
  final double rotation;
  final Color color;
  final double opacity;

  MeshGradientPainter({
    required this.rotation,
    required this.color,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment(
          math.cos(rotation) * 0.5,
          math.sin(rotation) * 0.5,
        ),
        radius: 0.8,
        colors: [
          color.withOpacity(opacity),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawCircle(
      Offset(
        size.width / 2 + math.cos(rotation) * 50,
        size.height / 2 + math.sin(rotation) * 50,
      ),
      size.width * 0.6,
      paint,
    );
  }

  @override
  bool shouldRepaint(MeshGradientPainter oldDelegate) {
    return rotation != oldDelegate.rotation;
  }
}