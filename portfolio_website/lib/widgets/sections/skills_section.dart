import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../ferrari_luxury_skill_card.dart';
import '../../services/content_service.dart';
import '../../utils/ferrari_theme.dart';

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
      // Programming Languages
      case 'javascript': return FontAwesomeIcons.js;
      case 'typescript': return FontAwesomeIcons.js; // TypeScript uses JS icon variant
      case 'python': return FontAwesomeIcons.python;
      case 'java': return FontAwesomeIcons.java;
      case 'php': return FontAwesomeIcons.php;
      case 'dart': return Icons.flutter_dash; // Use Flutter Dash icon for Dart
      case 'c': return FontAwesomeIcons.c;
      case 'terminal': return FontAwesomeIcons.c; // For C/C++/C#
      case 'sql': return FontAwesomeIcons.database;
      case 'html': return FontAwesomeIcons.html5;
      case 'css': return FontAwesomeIcons.css3Alt;
      case 'web': return FontAwesomeIcons.html5; // For HTML/CSS combo
      
      // Frameworks & Libraries
      case 'react': return FontAwesomeIcons.react;
      case 'angular': return FontAwesomeIcons.angular;
      case 'vuejs': return FontAwesomeIcons.vuejs;
      case 'node': return FontAwesomeIcons.nodeJs;
      case 'nodejs': return FontAwesomeIcons.nodeJs;
      case 'flutter': return Icons.flutter_dash; // Use Flutter Dash icon
      case 'django': return FontAwesomeIcons.python;
      case 'laravel': return FontAwesomeIcons.laravel;
      case 'bootstrap': return FontAwesomeIcons.bootstrap;
      
      // Databases
      case 'storage': return FontAwesomeIcons.database;
      case 'mongodb': return FontAwesomeIcons.database;
      case 'postgresql': return FontAwesomeIcons.database;
      case 'mysql': return FontAwesomeIcons.database;
      case 'redis': return FontAwesomeIcons.memory;
      case 'firebase': return FontAwesomeIcons.fire;
      
      // Cloud & DevOps
      case 'aws': return FontAwesomeIcons.aws;
      case 'cloud': return FontAwesomeIcons.cloud;
      case 'cloud_queue': return FontAwesomeIcons.aws;
      case 'cloud_circle': return FontAwesomeIcons.microsoft; // For Azure
      case 'docker': return FontAwesomeIcons.docker;
      case 'kubernetes': return FontAwesomeIcons.dharmachakra;
      case 'git': return FontAwesomeIcons.gitAlt;
      case 'github': return FontAwesomeIcons.github;
      case 'gitlab': return FontAwesomeIcons.gitlab;
      case 'linux': return FontAwesomeIcons.linux;
      case 'ubuntu': return FontAwesomeIcons.ubuntu;
      case 'windows': return FontAwesomeIcons.windows;
      case 'apple': return FontAwesomeIcons.apple;
      
      // Tools & Others
      case 'vscode': return FontAwesomeIcons.code;
      case 'npm': return FontAwesomeIcons.npm;
      case 'yarn': return FontAwesomeIcons.yarn;
      case 'webpack': return FontAwesomeIcons.cube;
      
      // AI & Machine Learning
      case 'auto_awesome': return FontAwesomeIcons.robot;
      case 'brain': return FontAwesomeIcons.brain;
      case 'psychology': return FontAwesomeIcons.brain;
      case 'link': return FontAwesomeIcons.link;
      
      // Mobile
      case 'phone_android': return FontAwesomeIcons.android;
      case 'mobile_friendly': return FontAwesomeIcons.mobileScreen;
      case 'apple_mobile': return FontAwesomeIcons.apple;
      
      // General/Default icons
      case 'code': return FontAwesomeIcons.code;
      case 'layers': return FontAwesomeIcons.layerGroup;
      case 'api': return FontAwesomeIcons.plug;
      case 'security': return FontAwesomeIcons.shield;
      case 'web_asset': return FontAwesomeIcons.globe;
      case 'dns': return FontAwesomeIcons.server;
      case 'build': return FontAwesomeIcons.hammer;
      case 'hub': return FontAwesomeIcons.codeBranch;
      case 'hub_outlined': return FontAwesomeIcons.codeBranch;
      case 'autorenew': return FontAwesomeIcons.rotate;
      case 'computer': return FontAwesomeIcons.desktop;
      case 'settings_applications': return FontAwesomeIcons.gear;
      case 'view_agenda': return FontAwesomeIcons.tableColumns;
      case 'data_object': return FontAwesomeIcons.database;
      case 'speed': return FontAwesomeIcons.gaugeHigh;
      case 'search': return FontAwesomeIcons.magnifyingGlass;
      case 'table_chart': return FontAwesomeIcons.table;
      case 'face': return FontAwesomeIcons.faceSmile;
      case 'scatter_plot': return FontAwesomeIcons.chartLine;
      case 'edit_note': return FontAwesomeIcons.penToSquare;
      case 'find_in_page': return FontAwesomeIcons.fileLines;
      case 'window': return FontAwesomeIcons.microsoft; // For C#/.NET
      case 'coffee': return FontAwesomeIcons.java; // Java
      
      default: return FontAwesomeIcons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 400,
        decoration: const BoxDecoration(
          gradient: FerrariTheme.luxuryGradient,
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: FerrariTheme.ferrariBlue,
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
      decoration: const BoxDecoration(
        gradient: FerrariTheme.ferrariGradient,
      ),
      child: Column(
        children: [
          AnimationConfiguration.synchronized(
            child: SlideAnimation(
              duration: FerrariTheme.elegantAnimation,
              verticalOffset: -60,
              curve: FerrariTheme.luxuryCurve,
              child: FadeInAnimation(
                duration: FerrariTheme.elegantAnimation,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      FerrariTheme.electricBlue,
                      FerrariTheme.pureWhite,
                      FerrariTheme.ferrariBlue,
                      FerrariTheme.electricBlue,
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0],
                  ).createShader(bounds),
                  child: Text(
                    title.isNotEmpty ? title : 'TECHNICAL EXPERTISE',
                    style: FerrariTheme.ferrariHeadline.copyWith(
                      fontSize: 52,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimationConfiguration.synchronized(
            child: SlideAnimation(
              duration: FerrariTheme.smoothAnimation,
              verticalOffset: -40,
              curve: FerrariTheme.luxuryCurve,
              child: FadeInAnimation(
                child: Text(
                  subtitle.isNotEmpty ? subtitle : 'Comprehensive skill set across modern technologies',
                  style: FerrariTheme.elegantSubtitle.copyWith(
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
    final color = categoryColors[category] ?? FerrariTheme.ferrariBlue;
    final icon = categoryIcons[category] ?? Icons.code;
    final skillCount = skillCategories[category]?.length ?? 0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          setState(() {
            expandedCategory = isExpanded ? null : category;
          });
        },
        child: AnimatedContainer(
          duration: FerrariTheme.quickAnimation,
          width: 280,
          height: 180,
          transform: Matrix4.identity()
            ..translate(0.0, isExpanded ? -10.0 : 0.0)
            ..scale(isExpanded ? 1.05 : 1.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isExpanded
                  ? [
                      color.withValues(alpha: 0.3),
                      FerrariTheme.primaryGray,
                      FerrariTheme.darkGray,
                    ]
                  : [
                      FerrariTheme.metallicGray,
                      FerrariTheme.primaryGray,
                      FerrariTheme.darkGray,
                    ],
              stops: const [0.0, 0.5, 1.0],
            ),
            borderRadius: FerrariTheme.luxuryRadius,
            boxShadow: isExpanded
                ? [
                    ...FerrariTheme.luxuryShadow,
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 25,
                      offset: const Offset(0, 12),
                    ),
                  ]
                : FerrariTheme.subtleShadow,
            border: Border.all(
              width: 1.5,
              color: isExpanded
                  ? color.withValues(alpha: 0.6)
                  : FerrariTheme.silverAccent.withValues(alpha: 0.3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withValues(alpha: 0.7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: FerrariTheme.pureWhite,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  category,
                  style: FerrariTheme.luxuryTitle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$skillCount Skills',
                  style: TextStyle(
                    color: FerrariTheme.silverAccent.withValues(alpha: 0.8),
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                color.withValues(alpha: 0.6),
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
    return FerrariLuxurySkillCard(
      skillName: skill.name,
      icon: skill.icon,
      percentage: skill.percentage,
      description: skill.description,
      accentColor: color,
      index: index,
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