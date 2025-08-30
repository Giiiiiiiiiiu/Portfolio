import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class UltraModernSkillCard extends StatefulWidget {
  final String skillName;
  final IconData icon;
  final int percentage;
  final String description;
  final Color primaryColor;
  final int index;

  const UltraModernSkillCard({
    super.key,
    required this.skillName,
    required this.icon,
    required this.percentage,
    required this.description,
    required this.primaryColor,
    required this.index,
  });

  @override
  State<UltraModernSkillCard> createState() => _UltraModernSkillCardState();
}

class _UltraModernSkillCardState extends State<UltraModernSkillCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _shimmerController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _hoverScale;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  
  bool _isHovered = false;
  double _mouseX = 0;
  double _mouseY = 0;

  @override
  void initState() {
    super.initState();
    
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    
    _hoverScale = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutBack,
    ));
    
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(_shimmerController);
    
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
    
    // Start with a delay based on index for staggered animation
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _hoverController.forward();
        _hoverController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _shimmerController.dispose();
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
          final RenderBox box = context.findRenderObject() as RenderBox;
          final size = box.size;
          _mouseX = (event.localPosition.dx / size.width) * 2 - 1;
          _mouseY = (event.localPosition.dy / size.height) * 2 - 1;
        });
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _hoverController,
          _shimmerController,
          _pulseController,
          _rotationController,
        ]),
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_mouseX * 0.05)
              ..rotateX(-_mouseY * 0.05)
              ..scale(_hoverScale.value),
            child: Container(
              width: 280,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: widget.primaryColor.withOpacity(_isHovered ? 0.4 : 0.2),
                    blurRadius: _isHovered ? 30 : 20,
                    spreadRadius: _isHovered ? 5 : 0,
                    offset: Offset(0, _isHovered ? 15 : 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    // Animated gradient background
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _isHovered
                            ? [
                                widget.primaryColor.withOpacity(0.3),
                                widget.primaryColor.withOpacity(0.1),
                                Colors.black.withOpacity(0.8),
                              ]
                            : [
                                const Color(0xFF1a1a2e),
                                const Color(0xFF16213e),
                                const Color(0xFF0f3460),
                              ],
                        ),
                      ),
                    ),
                    
                    // Animated pattern overlay
                    if (_isHovered)
                      AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: PatternPainter(
                              rotation: _rotationAnimation.value,
                              color: widget.primaryColor,
                            ),
                            child: Container(),
                          );
                        },
                      ),
                    
                    // Glass morphism effect
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _isHovered ? 10 : 5,
                        sigmaY: _isHovered ? 10 : 5,
                      ),
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
                            color: widget.primaryColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    
                    // Shimmer effect
                    AnimatedBuilder(
                      animation: _shimmerAnimation,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1, -1),
                              end: Alignment(1, 1),
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(_isHovered ? 0.2 : 0.1),
                                Colors.transparent,
                              ],
                              stops: [
                                _shimmerAnimation.value - 0.3,
                                _shimmerAnimation.value,
                                _shimmerAnimation.value + 0.3,
                              ].map((e) => e.clamp(0.0, 1.0)).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Skill name with gradient text
                              Expanded(
                                child: ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: _isHovered
                                      ? [
                                          widget.primaryColor,
                                          widget.primaryColor.withOpacity(0.6),
                                        ]
                                      : [
                                          Colors.white,
                                          Colors.white.withOpacity(0.9),
                                        ],
                                  ).createShader(bounds),
                                  child: Text(
                                    widget.skillName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Animated icon
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          widget.primaryColor.withOpacity(0.8),
                                          widget.primaryColor.withOpacity(0.3),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: widget.primaryColor.withOpacity(0.5 * _pulseAnimation.value),
                                          blurRadius: 20 * _pulseAnimation.value,
                                          spreadRadius: 5 * _pulseAnimation.value,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      widget.icon,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          
                          // Description
                          Text(
                            widget.description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                          
                          // Progress bar with percentage
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Proficiency',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 11,
                                    ),
                                  ),
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 300),
                                    style: TextStyle(
                                      color: _isHovered ? widget.primaryColor : Colors.white.withOpacity(0.9),
                                      fontSize: _isHovered ? 14 : 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    child: Text('${widget.percentage}%'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 1000 + (widget.index * 100)),
                                          curve: Curves.easeOutCubic,
                                          width: constraints.maxWidth * (widget.percentage / 100),
                                          height: 6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            gradient: LinearGradient(
                                              colors: [
                                                widget.primaryColor,
                                                widget.primaryColor.withOpacity(0.6),
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: widget.primaryColor.withOpacity(0.5),
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        // Glowing dot at the end
                                        if (_isHovered)
                                          AnimatedPositioned(
                                            duration: const Duration(milliseconds: 300),
                                            left: constraints.maxWidth * (widget.percentage / 100) - 6,
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: widget.primaryColor,
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  final double rotation;
  final Color color;

  PatternPainter({
    required this.rotation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    
    for (int i = 0; i < 5; i++) {
      final x = size.width * (0.2 + i * 0.15);
      final y = size.height * (0.5 + math.sin(rotation + i) * 0.3);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.quadraticBezierTo(
          x - 20, y - 20,
          x, y,
        );
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PatternPainter oldDelegate) {
    return rotation != oldDelegate.rotation;
  }
}