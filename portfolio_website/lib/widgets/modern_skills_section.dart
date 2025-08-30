import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import '../services/content_service.dart';

class ModernSkillsSection extends StatefulWidget {
  const ModernSkillsSection({super.key});

  @override
  State<ModernSkillsSection> createState() => _ModernSkillsSectionState();
}

class _ModernSkillsSectionState extends State<ModernSkillsSection> 
    with TickerProviderStateMixin {
  String? selectedCategory;
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  final ContentService _contentService = ContentService();
  Map<String, dynamic> skillCategories = {};
  String title = '';
  String subtitle = '';
  bool _isLoading = true;
  
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
      case 'scatter_plot': return FontAwesomeIcons.chartLine;
      case 'edit_note': return FontAwesomeIcons.penToSquare;
      case 'smart_toy': return FontAwesomeIcons.robot;
      case 'javascript': return FontAwesomeIcons.js;
      case 'hub': return FontAwesomeIcons.hubspot;
      case 'storage': return FontAwesomeIcons.database;
      case 'cloud': return FontAwesomeIcons.cloud;
      case 'sports_esports': return FontAwesomeIcons.gamepad;
      case 'sports_soccer': return FontAwesomeIcons.baseball;
      case 'group': return FontAwesomeIcons.users;
      default: return FontAwesomeIcons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 400,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1D),
              Color(0xFF0F0F11),
            ],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF007AFF),
          ),
        ),
      );
    }

    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1200;
    final isTablet = screenSize.width > 600 && screenSize.width <= 1200;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : (isTablet ? 60 : 30),
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1A1D), // Dark luxury black
            Color(0xFF0F0F11), // Carbon fiber black
          ],
        ),
      ),
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 80),
          _buildCategoryGrid(),
          if (selectedCategory != null) ...[
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
          offset: Offset(0, math.sin(_floatingController.value * math.pi) * 8),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    const Color(0xFF8E8E93), // Silver accent
                    const Color(0xFFFAFAFA), // Pure white
                    const Color(0xFF8E8E93),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ).createShader(bounds),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryGrid() {
    return Center(
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,
        children: skillCategories.entries.map((entry) {
          return UltraModernCategoryCard(
            category: entry.key,
            data: entry.value,
            icon: _getIconData(entry.value['icon'] ?? 'code'),
            onTap: () {
              setState(() {
                selectedCategory = selectedCategory == entry.key ? null : entry.key;
              });
            },
            isExpanded: selectedCategory == entry.key,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExpandedSkills() {
    final skillsList = skillCategories[selectedCategory]?['skills'] ?? [];
    
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFF8E8E93),
              Color(0xFFFAFAFA),
              Color(0xFF8E8E93),
            ],
          ).createShader(bounds),
          child: Text(
            selectedCategory!,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 50),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: List<Widget>.from(skillsList.asMap().entries.map((entry) {
            final skill = entry.value as Map<String, dynamic>;
            return UltraModernSkillCard(
              name: skill['name']?.toString() ?? '',
              icon: _getIconData(skill['icon']?.toString() ?? 'code'),
              percentage: (skill['percentage'] as num?)?.toInt() ?? 0,
              description: skill['description']?.toString() ?? '',
              gradient: skill['gradient']?.toString(),
              index: entry.key,
            );
          })),
        ),
      ],
    );
  }
}

class UltraModernCategoryCard extends StatefulWidget {
  final String category;
  final Map<String, dynamic> data;
  final IconData icon;
  final VoidCallback onTap;
  final bool isExpanded;

  const UltraModernCategoryCard({
    super.key,
    required this.category,
    required this.data,
    required this.icon,
    required this.onTap,
    required this.isExpanded,
  });

  @override
  State<UltraModernCategoryCard> createState() => _UltraModernCategoryCardState();
}

class _UltraModernCategoryCardState extends State<UltraModernCategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovering = false;
  double _mouseX = 0;
  double _mouseY = 0;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skillCount = (widget.data['skills'] as List?)?.length ?? 0;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
          _mouseX = 0;
          _mouseY = 0;
        });
        _hoverController.reverse();
      },
      onHover: (event) {
        final renderBox = context.findRenderObject() as RenderBox;
        final size = renderBox.size;
        setState(() {
          _mouseX = (event.localPosition.dx - size.width / 2) / size.width;
          _mouseY = (event.localPosition.dy - size.height / 2) / size.height;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            final hoverValue = _hoverController.value;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(_mouseX * 0.2 * hoverValue)
                ..rotateX(-_mouseY * 0.2 * hoverValue)
                ..translate(
                  0.0,
                  0.0,
                  _isHovering ? 30.0 : -10.0,
                ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 240,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _isHovering
                        ? [
                            const Color(0xFF3C3C3F), // Metallic gray
                            const Color(0xFF2A2A2D), // Primary gray
                          ]
                        : [
                            const Color(0xFF2A2A2D),
                            const Color(0xFF1A1A1D),
                          ],
                  ),
                  boxShadow: _isHovering
                      ? [
                          // Outer glow when hovering
                          BoxShadow(
                            color: const Color(0xFF007AFF).withValues(alpha: 0.3),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                          const BoxShadow(
                            color: Color(0xFF000000),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ]
                      : [
                          // Inner shadow when not hovering (embedded look)
                          const BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                            spreadRadius: -5,
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                            spreadRadius: -10,
                          ),
                        ],
                  border: Border.all(
                    color: _isHovering
                        ? const Color(0xFF8E8E93).withValues(alpha: 0.3)
                        : const Color(0xFF2A2A2D),
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    // Gradient overlay for depth
                    if (!_isHovering)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.2),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: _isHovering
                                    ? [
                                        const Color(0xFF007AFF),
                                        const Color(0xFF0066CC),
                                      ]
                                    : [
                                        const Color(0xFF3C3C3F),
                                        const Color(0xFF2A2A2D),
                                      ],
                              ),
                              boxShadow: _isHovering
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF007AFF).withValues(alpha: 0.5),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [
                                      const BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(0, 2),
                                        spreadRadius: -3,
                                      ),
                                    ],
                            ),
                            child: Icon(
                              widget.icon,
                              color: _isHovering
                                  ? Colors.white
                                  : const Color(0xFF8E8E93),
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.category,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _isHovering
                                  ? Colors.white
                                  : const Color(0xFF8E8E93),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _isHovering
                                  ? const Color(0xFF007AFF).withValues(alpha: 0.2)
                                  : Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$skillCount Skills',
                              style: TextStyle(
                                color: _isHovering
                                    ? const Color(0xFF007AFF)
                                    : const Color(0xFF8E8E93).withValues(alpha: 0.6),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.isExpanded)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF007AFF),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF007AFF),
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
            );
          },
        ),
      ),
    );
  }
}

class UltraModernSkillCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final int percentage;
  final String description;
  final String? gradient;
  final int index;

  const UltraModernSkillCard({
    super.key,
    required this.name,
    required this.icon,
    required this.percentage,
    required this.description,
    this.gradient,
    required this.index,
  });

  @override
  State<UltraModernSkillCard> createState() => _UltraModernSkillCardState();
}

class _UltraModernSkillCardState extends State<UltraModernSkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.percentage / 100,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    Future.delayed(Duration(milliseconds: widget.index * 50), () {
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
              width: 200,
              height: 240,
              transform: Matrix4.identity()
                ..translate(0.0, _isHovering ? -8.0 : 0.0)
                ..scale(_isHovering ? 1.05 : 1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isHovering
                      ? [
                          const Color(0xFF2A2A2D),
                          const Color(0xFF1A1A1D),
                        ]
                      : [
                          const Color(0xFF1A1A1D),
                          const Color(0xFF0F0F11),
                        ],
                ),
                border: Border.all(
                  color: _isHovering
                      ? const Color(0xFF007AFF).withValues(alpha: 0.3)
                      : const Color(0xFF2A2A2D),
                  width: 1,
                ),
                boxShadow: _isHovering
                    ? [
                        BoxShadow(
                          color: const Color(0xFF007AFF).withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                    : [
                        const BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF007AFF).withValues(alpha: 0.8),
                            const Color(0xFF0066CC).withValues(alpha: 0.8),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF007AFF).withValues(alpha: 0.3),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF8E8E93).withValues(alpha: 0.8),
                        fontSize: 10,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Progress bar
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: const Color(0xFF2A2A2D),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1500),
                          width: double.infinity,
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _progressAnimation.value,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF007AFF),
                                    Color(0xFF00C7BE),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.percentage}%',
                      style: TextStyle(
                        color: const Color(0xFF007AFF),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: const Color(0xFF007AFF).withValues(alpha: 0.5),
                            blurRadius: 10,
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