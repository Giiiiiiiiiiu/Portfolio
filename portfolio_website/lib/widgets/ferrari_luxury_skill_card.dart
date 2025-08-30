import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class FerrariLuxurySkillCard extends StatefulWidget {
  final String skillName;
  final IconData icon;
  final int percentage;
  final String description;
  final Color accentColor;
  final int index;

  const FerrariLuxurySkillCard({
    super.key,
    required this.skillName,
    required this.icon,
    required this.percentage,
    required this.description,
    required this.accentColor,
    required this.index,
  });

  @override
  State<FerrariLuxurySkillCard> createState() => _FerrariLuxurySkillCardState();
}

class _FerrariLuxurySkillCardState extends State<FerrariLuxurySkillCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _breatheController;
  late Animation<double> _hoverScale;
  late Animation<double> _breatheAnimation;
  
  bool _isHovered = false;
  double _mouseX = 0;
  double _mouseY = 0;

  // Ferrari-inspired colors - Luxury grays with metallic finish
  static const Color _ferrariGray = Color(0xFF2C2C2E);
  static const Color _metallicGray = Color(0xFF3A3A3C);
  static const Color _darkGray = Color(0xFF1C1C1E);
  static const Color _carbonFiber = Color(0xFF151517);
  static const Color _silverAccent = Color(0xFF8E8E93);

  @override
  void initState() {
    super.initState();
    
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _breatheController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _hoverScale = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));
    
    _breatheAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _breatheController,
      curve: Curves.easeInOut,
    ));
    
    // Subtle entrance animation
    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) {
        _hoverController.forward();
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) _hoverController.reverse();
        });
      }
    });
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _breatheController.dispose();
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
          _breatheController,
        ]),
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_isHovered ? _mouseX * 0.02 : 0)
              ..rotateX(_isHovered ? -_mouseY * 0.02 : 0)
              ..scale(_hoverScale.value),
            child: Container(
              width: 320,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  // Subtle luxury shadow
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, _isHovered ? 8 : 5),
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: widget.accentColor.withOpacity(0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Matte metallic gradient background - Ferrari gray
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _ferrariGray,
                            _metallicGray,
                            _darkGray,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                    
                    // Carbon fiber texture overlay
                    if (_isHovered)
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _isHovered ? 0.3 : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                _carbonFiber.withOpacity(0.5),
                                Colors.transparent,
                                _carbonFiber.withOpacity(0.5),
                              ],
                            ),
                          ),
                        ),
                      ),
                    
                    // Subtle metallic sheen (not shiny, just premium feel)
                    AnimatedBuilder(
                      animation: _breatheAnimation,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1 + _breatheAnimation.value * 2, -1),
                              end: Alignment(1, 1),
                              colors: [
                                Colors.transparent,
                                _silverAccent.withOpacity(0.05),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    
                    // Premium border
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _isHovered 
                            ? widget.accentColor.withOpacity(0.3)
                            : _silverAccent.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    
                    // Content with luxury spacing
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Header with skill name and icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.skillName,
                                      style: TextStyle(
                                        color: _isHovered 
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.95),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        fontFamily: 'SF Pro Display',
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      widget.description,
                                      style: TextStyle(
                                        color: _silverAccent.withOpacity(0.8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Luxury icon container
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _metallicGray,
                                      _darkGray,
                                    ],
                                  ),
                                  border: Border.all(
                                    color: _isHovered 
                                      ? widget.accentColor.withOpacity(0.5)
                                      : _silverAccent.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  widget.icon,
                                  size: 24,
                                  color: _isHovered 
                                    ? widget.accentColor
                                    : _silverAccent,
                                ),
                              ),
                            ],
                          ),
                          
                          // Luxury progress indicator
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'EXPERTISE LEVEL',
                                    style: TextStyle(
                                      color: _silverAccent.withOpacity(0.6),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  Text(
                                    '${widget.percentage}%',
                                    style: TextStyle(
                                      color: _isHovered 
                                        ? widget.accentColor
                                        : Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              
                              // Ferrari-style progress bar
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: _darkGray,
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 1500 + (widget.index * 100)),
                                          curve: Curves.easeOutCubic,
                                          width: constraints.maxWidth * (widget.percentage / 100),
                                          height: 4,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            gradient: LinearGradient(
                                              colors: [
                                                widget.accentColor.withOpacity(0.8),
                                                widget.accentColor,
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                        // Subtle end cap (Ferrari detail)
                                        if (_isHovered)
                                          AnimatedPositioned(
                                            duration: const Duration(milliseconds: 300),
                                            left: (constraints.maxWidth * (widget.percentage / 100)) - 2,
                                            child: Container(
                                              width: 4,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: widget.accentColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: widget.accentColor.withOpacity(0.5),
                                                    blurRadius: 4,
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