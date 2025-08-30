import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math' as math;
import '../../services/content_service.dart';
import '../../utils/ferrari_theme.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> with TickerProviderStateMixin {
  String? expandedCategory;
  final ContentService _contentService = ContentService();
  Map<String, dynamic> skillCategories = {};
  String title = '';
  String subtitle = '';
  bool _isLoading = true;
  late AnimationController _floatingController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _loadSkillsFromJSON();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _loadSkillsFromJSON() async {
    try {
      await _contentService.loadSkillsContent();
      final categories = _contentService.skillCategories;
      
      print('DEBUG: Loaded categories: ${categories.keys.toList()}');
      
      title = _contentService.skillsTitle;
      subtitle = _contentService.skillsContent?['subtitle'] ?? '';
      
      setState(() {
        skillCategories = categories;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading skills: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'language': return FontAwesomeIcons.globe;
      case 'phone_iphone': return FontAwesomeIcons.mobileScreen;
      case 'auto_awesome': return FontAwesomeIcons.wandMagicSparkles;
      case 'dns': return FontAwesomeIcons.server;
      case 'react': return FontAwesomeIcons.react;
      case 'code': return FontAwesomeIcons.code;
      case 'view_in_ar': return FontAwesomeIcons.cube;
      case 'palette': return FontAwesomeIcons.palette;
      case 'install_mobile': return FontAwesomeIcons.mobileScreenButton;
      case 'sync': return FontAwesomeIcons.arrowsRotate;
      case 'widgets': return FontAwesomeIcons.shapes;
      case 'flutter_dash': return Icons.flutter_dash;
      case 'phone_android': return FontAwesomeIcons.android;
      case 'apple': return FontAwesomeIcons.apple;
      case 'android': return FontAwesomeIcons.android;
      case 'speed': return FontAwesomeIcons.gaugeHigh;
      case 'trending_up': return FontAwesomeIcons.chartLine;
      case 'notifications_active': return FontAwesomeIcons.bell;
      case 'shopping_cart': return FontAwesomeIcons.cartShopping;
      case 'psychology': return FontAwesomeIcons.brain;
      case 'link': return FontAwesomeIcons.link;
      case 'visibility': return FontAwesomeIcons.eye;
      case 'translate': return FontAwesomeIcons.language;
      case 'settings_suggest': return FontAwesomeIcons.gears;
      case 'scatter_plot': return FontAwesomeIcons.chartScatter;
      case 'edit_note': return FontAwesomeIcons.penToSquare;
      case 'smart_toy': return FontAwesomeIcons.robot;
      case 'javascript': return FontAwesomeIcons.js;
      case 'hub': return FontAwesomeIcons.hubspot;
      case 'storage': return FontAwesomeIcons.database;
      case 'cloud': return FontAwesomeIcons.cloud;
      default: return FontAwesomeIcons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.grey.shade900,
            ],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
        ),
      );
    }

    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1200;
    final isTablet = screenSize.width > 600 && screenSize.width <= 1200;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 140 : (isTablet ? 80 : 40),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0E27),
            const Color(0xFF151933),
            const Color(0xFF0A0E27),
          ],
        ),
      ),
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 80),
          _buildCategoryGrid(),
          if (expandedCategory != null) ...[
            const SizedBox(height: 80),
            _buildExpandedSkills(),
          ],
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi) * 10),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    const Color(0xFF00D9FF),
                    const Color(0xFFFF00FF),
                    const Color(0xFF00FF88),
                    const Color(0xFF00D9FF),
                  ],
                  stops: [
                    0.0,
                    _floatingController.value * 0.5,
                    _floatingController.value,
                    1.0,
                  ],
                ).createShader(bounds),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3.0,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.6),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryGrid() {
    return Wrap(
      spacing: 30,
      runSpacing: 30,
      alignment: WrapAlignment.center,
      children: skillCategories.entries.map((entry) {
        return Ultra3DCategoryCard(
          category: entry.key,
          data: entry.value,
          icon: _getIconData(entry.value['icon'] ?? 'code'),
          onTap: () {
            setState(() {
              expandedCategory = expandedCategory == entry.key ? null : entry.key;
            });
          },
          isExpanded: expandedCategory == entry.key,
        );
      }).toList(),
    );
  }

  Widget _buildExpandedSkills() {
    final skills = skillCategories[expandedCategory]?['skills'] ?? [];
    final categoryData = skillCategories[expandedCategory];
    
    return AnimationLimiter(
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                const Color(0xFF00D9FF),
                const Color(0xFFFF00FF),
              ],
            ).createShader(bounds),
            child: Text(
              expandedCategory!,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: skills.asMap().entries.map((entry) {
              final skill = entry.value;
              return AnimationConfiguration.staggeredGrid(
                position: entry.key,
                duration: const Duration(milliseconds: 800),
                columnCount: 4,
                child: ScaleAnimation(
                  scale: 0.5,
                  child: FadeInAnimation(
                    child: ModernSkillCard(
                      name: skill['name'] ?? '',
                      icon: _getIconData(skill['icon'] ?? 'code'),
                      percentage: skill['percentage'] ?? 0,
                      description: skill['description'] ?? '',
                      gradient: skill['gradient'],
                      index: entry.key,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Ultra3DCategoryCard extends StatefulWidget {
  final String category;
  final Map<String, dynamic> data;
  final IconData icon;
  final VoidCallback onTap;
  final bool isExpanded;

  const Ultra3DCategoryCard({
    Key? key,
    required this.category,
    required this.data,
    required this.icon,
    required this.onTap,
    required this.isExpanded,
  }) : super(key: key);

  @override
  State<Ultra3DCategoryCard> createState() => _Ultra3DCategoryCardState();
}

class _Ultra3DCategoryCardState extends State<Ultra3DCategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateRotation(Offset localPosition, Size size) {
    setState(() {
      _rotateX = (localPosition.dy - size.height / 2) / size.height * 0.3;
      _rotateY = (localPosition.dx - size.width / 2) / size.width * -0.3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gradientString = widget.data['color'] ?? 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
    final glowColor = widget.data['glowColor'] ?? '#667eea';
    final skillCount = (widget.data['skills'] as List?)?.length ?? 0;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
          _rotateX = 0;
          _rotateY = 0;
        });
        _controller.reverse();
      },
      onHover: (event) {
        final renderBox = context.findRenderObject() as RenderBox;
        _updateRotation(event.localPosition, renderBox.size);
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_rotateX)
            ..rotateY(_rotateY)
            ..scale(_isHovering ? 1.05 : 1.0),
          child: Container(
            width: 280,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: _parseGradient(gradientString),
              boxShadow: [
                BoxShadow(
                  color: _parseColor(glowColor).withOpacity(_isHovering ? 0.6 : 0.3),
                  blurRadius: _isHovering ? 40 : 20,
                  spreadRadius: _isHovering ? 5 : 0,
                  offset: Offset(0, _isHovering ? 20 : 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                if (_isHovering)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.transparent,
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.category,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '$skillCount Skills',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.isExpanded)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.greenAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _parseGradient(String gradientString) {
    if (gradientString.contains('linear-gradient')) {
      // Extract colors from the gradient string
      final regex = RegExp(r'#[0-9a-fA-F]{6}');
      final matches = regex.allMatches(gradientString).toList();
      
      if (matches.length >= 2) {
        final colors = matches.map((match) {
          final colorStr = gradientString.substring(match.start, match.end);
          return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
        }).toList();
        
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        );
      }
      
      // Default fallback gradient
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF667eea),
          Color(0xFF764ba2),
        ],
      );
    }
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        _parseColor(gradientString),
        _parseColor(gradientString).withValues(alpha: 0.7),
      ],
    );
  }

  Color _parseColor(String colorString) {
    if (colorString.startsWith('#')) {
      return Color(int.parse(colorString.replaceFirst('#', '0xFF')));
    }
    return const Color(0xFF667eea);
  }
}

class ModernSkillCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final int percentage;
  final String description;
  final String? gradient;
  final int index;

  const ModernSkillCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.percentage,
    required this.description,
    this.gradient,
    required this.index,
  }) : super(key: key);

  @override
  State<ModernSkillCard> createState() => _ModernSkillCardState();
}

class _ModernSkillCardState extends State<ModernSkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.percentage / 100,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LinearGradient _parseSkillGradient() {
    if (widget.gradient != null && widget.gradient!.contains('linear-gradient')) {
      final colors = widget.gradient!
          .replaceAll(RegExp(r'linear-gradient\([^)]*,\s*'), '')
          .replaceAll(')', '')
          .split(',')
          .map((c) => c.trim())
          .where((c) => c.startsWith('#'))
          .map((c) => Color(int.parse(c.replaceFirst('#', '0xFF'))))
          .toList();
      
      if (colors.length >= 2) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        );
      }
    }
    
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue.shade400,
        Colors.purple.shade400,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 220,
              height: 280,
              transform: Matrix4.identity()
                ..translate(0.0, _isHovering ? -10.0 : 0.0)
                ..scale(_isHovering ? 1.05 : 1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _parseSkillGradient().colors.first.withOpacity(_isHovering ? 0.4 : 0.2),
                    blurRadius: _isHovering ? 30 : 20,
                    offset: Offset(0, _isHovering ? 15 : 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    if (_isHovering)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: _parseSkillGradient().scale(0.3),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: _parseSkillGradient(),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: _parseSkillGradient().colors.first.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.icon,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            height: 40,
                            width: 40,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    value: _progressAnimation.value,
                                    strokeWidth: 3,
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _parseSkillGradient().colors.first,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget.percentage}%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 1500),
                                width: double.infinity,
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: _progressAnimation.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: _parseSkillGradient(),
                                      boxShadow: [
                                        BoxShadow(
                                          color: _parseSkillGradient().colors.first.withOpacity(0.5),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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