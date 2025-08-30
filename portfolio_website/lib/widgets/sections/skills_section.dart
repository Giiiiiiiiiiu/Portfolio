import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../modern_skill_card.dart';
import '../ultra_modern_skill_card.dart';
import '../../services/content_service.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String? expandedCategory;
  final ContentService _contentService = ContentService();
  Map<String, List<SkillItem>> skillCategories = {};
  Map<String, IconData> categoryIcons = {};
  Map<String, Color> categoryColors = {};
  String title = '';
  String subtitle = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSkillsFromJSON();
  }

  Future<void> _loadSkillsFromJSON() async {
    try {
      await _contentService.loadSkillsContent();
      final categories = _contentService.skillCategories;
      
      print('Loading skills, found ${categories.length} categories');
      
      // Load title and subtitle from JSON
      title = _contentService.skillsTitle;
      subtitle = _contentService.skillsContent?['subtitle'] ?? 'Comprehensive skill set across modern technologies';
      
      Map<String, List<SkillItem>> loadedCategories = {};
      Map<String, IconData> loadedIcons = {};
      Map<String, Color> loadedColors = {};
      
      categories.forEach((categoryName, categoryData) {
        print('Processing category: $categoryName');
      List<SkillItem> skills = [];
      if (categoryData['skills'] != null) {
        for (var skill in categoryData['skills']) {
          skills.add(SkillItem(
            skill['name'] ?? '',
            _getIconData(skill['icon'] ?? 'code'),
            skill['percentage'] ?? 0,
            skill['description'] ?? '',
          ));
        }
      }
      loadedCategories[categoryName] = skills;
      loadedIcons[categoryName] = _getIconData(categoryData['icon'] ?? 'code');
      
      // Parse color safely
      String colorString = categoryData['color'] ?? '#0080FF';
      if (colorString.startsWith('#')) {
        colorString = colorString.replaceFirst('#', '0xFF');
      } else if (!colorString.startsWith('0x')) {
        colorString = '0xFF$colorString';
      }
      try {
        loadedColors[categoryName] = Color(int.parse(colorString));
      } catch (e) {
        loadedColors[categoryName] = const Color(0xFF0080FF);
        print('Error parsing color for $categoryName: $e');
      }
    });
    
      setState(() {
        skillCategories = loadedCategories;
        categoryIcons = loadedIcons;
        categoryColors = loadedColors;
        _isLoading = false;
        print('Loaded ${skillCategories.length} categories: ${skillCategories.keys.toList()}');
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
      case 'javascript': return Icons.javascript;
      case 'code': return Icons.code;
      case 'terminal': return Icons.terminal;
      case 'phone_android': return Icons.phone_android;
      case 'coffee': return Icons.coffee;
      case 'window': return Icons.window;
      case 'php': return Icons.code;
      case 'storage': return Icons.storage;
      case 'web': return Icons.web;
      case 'layers': return Icons.layers;
      case 'web_asset': return Icons.web_asset;
      case 'mobile_friendly': return Icons.mobile_friendly;
      case 'dns': return Icons.dns;
      case 'api': return Icons.api;
      case 'security': return Icons.security;
      case 'settings_applications': return Icons.settings_applications;
      case 'view_agenda': return Icons.view_agenda;
      case 'data_object': return Icons.data_object;
      case 'speed': return Icons.speed;
      case 'search': return Icons.search;
      case 'cloud': return Icons.cloud;
      case 'table_chart': return Icons.table_chart;
      case 'cloud_queue': return Icons.cloud_queue;
      case 'cloud_circle': return Icons.cloud_circle;
      case 'hub': return Icons.hub;
      case 'hub_outlined': return Icons.hub_outlined;
      case 'autorenew': return Icons.autorenew;
      case 'build': return Icons.build;
      case 'computer': return Icons.computer;
      case 'auto_awesome': return Icons.auto_awesome;
      case 'link': return Icons.link;
      case 'psychology': return Icons.psychology;
      case 'psychology_alt': return Icons.psychology_alt;
      case 'face': return Icons.face;
      case 'scatter_plot': return Icons.scatter_plot;
      case 'edit_note': return Icons.edit_note;
      case 'find_in_page': return Icons.find_in_page;
      default: return Icons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 400,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0A0A),
              Color(0xFF121216),
              Color(0xFF1C1C24),
              Color(0xFF2C2C34),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF0080FF),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0A0A),
            Color(0xFF121216),
            Color(0xFF1C1C24),
            Color(0xFF2C2C34),
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFF0080FF),
                Color(0xFF00BFFF),
                Color(0xFF4A90E2),
              ],
            ).createShader(bounds),
            child: Text(
              title.isNotEmpty ? title : 'TECHNICAL EXPERTISE',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                shadows: [
                  const Shadow(
                    color: Color(0xFF0080FF),
                    blurRadius: 30,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle.isNotEmpty ? subtitle : 'Comprehensive skill set across modern technologies',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: skillCategories.keys.map((category) {
              return _buildCategoryCard(context, category);
            }).toList(),
          ),
          if (expandedCategory != null) ...[
            const SizedBox(height: 60),
            _buildExpandedSkills(context),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String category) {
    final isExpanded = expandedCategory == category;
    final color = categoryColors[category] ?? const Color(0xFF0080FF);
    final icon = categoryIcons[category] ?? Icons.code;
    final skillCount = skillCategories[category]?.length ?? 0;

    return ModernSkillCard(
      category: category,
      icon: icon,
      color: color,
      skillCount: skillCount,
      isExpanded: isExpanded,
      onTap: () {
        setState(() {
          expandedCategory = isExpanded ? null : category;
        });
      },
    );
  }

  Widget _buildExpandedSkills(BuildContext context) {
    final skills = skillCategories[expandedCategory] ?? [];
    final color = categoryColors[expandedCategory] ?? const Color(0xFF0080FF);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                color,
                color.withOpacity(0.6),
              ],
            ).createShader(bounds),
            child: Text(
              expandedCategory!,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                shadows: [
                  Shadow(
                    color: color,
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: skills.asMap().entries.map((entry) {
              return _buildSkillCard(context, entry.value, color, entry.key);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, SkillItem skill, Color color, int index) {
    return UltraModernSkillCard(
      skillName: skill.name,
      icon: skill.icon,
      percentage: skill.percentage,
      description: skill.description,
      primaryColor: color,
      index: index,
    );
  }

  Widget _buildProgressBar(int percentage, Color color) {
    return Column(
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
            Text(
              '$percentage%',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutCubic,
                width: (200 - 40) * (percentage / 100),
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withOpacity(0.6),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SkillItem {
  final String name;
  final IconData icon;
  final int percentage;
  final String description;

  SkillItem(this.name, this.icon, this.percentage, this.description);
}

class Skill3DCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final int percentage;

  const Skill3DCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.percentage,
  });

  @override
  State<Skill3DCard> createState() => _Skill3DCardState();
}

class _Skill3DCardState extends State<Skill3DCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.15,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        _controller.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_rotationAnimation.value)
              ..rotateX(_rotationAnimation.value * 0.5),
            child: Container(
              width: 200,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isHovering
                      ? [
                          widget.color.withOpacity(0.9),
                          widget.color.withOpacity(0.6),
                        ]
                      : [
                          const Color(0xFF2A2A3E),
                          const Color(0xFF1A1A2E),
                        ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(_isHovering ? 0.6 : 0.3),
                    blurRadius: _isHovering ? 30 : 20,
                    offset: Offset(0, _isHovering ? 15 : 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      size: 50,
                      color: _isHovering ? Colors.white : widget.color,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: _isHovering
                            ? [
                                Shadow(
                                  color: widget.color,
                                  blurRadius: 10,
                                ),
                              ]
                            : [],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          height: 8,
                          width: (160 * widget.percentage / 100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              colors: [
                                widget.color,
                                widget.color.withOpacity(0.6),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.color.withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${widget.percentage}%',
                      style: TextStyle(
                        color: widget.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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