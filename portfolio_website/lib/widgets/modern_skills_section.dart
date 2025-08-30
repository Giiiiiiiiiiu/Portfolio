import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class ModernSkillsSection extends StatefulWidget {
  const ModernSkillsSection({Key? key}) : super(key: key);

  @override
  State<ModernSkillsSection> createState() => _ModernSkillsSectionState();
}

class _ModernSkillsSectionState extends State<ModernSkillsSection> 
    with TickerProviderStateMixin {
  String? selectedCategory;
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  
  final Map<String, List<SkillData>> skillsData = {
    'LANGUAGES': [
      SkillData('C', FontAwesomeIcons.c, 70, const Color(0xFF00599C)),
      SkillData('C++', Icons.add_box_outlined, 75, const Color(0xFF00599C)),
      SkillData('C#', Icons.tag, 75, const Color(0xFF239120)),
      SkillData('JavaScript', FontAwesomeIcons.js, 90, const Color(0xFFF7DF1E)),
      SkillData('TypeScript', FontAwesomeIcons.squareJs, 88, const Color(0xFF3178C6)),
      SkillData('Python', FontAwesomeIcons.python, 95, const Color(0xFF3776AB)), // Python hat beide Farben: #3776AB und #FFD43B
      SkillData('Dart', Icons.code, 85, const Color(0xFF0175C2)), // Dart offizielle Farbe
      SkillData('Java', FontAwesomeIcons.java, 80, const Color(0xFF007396)),
      SkillData('PHP', FontAwesomeIcons.php, 70, const Color(0xFF777BB4)),
      SkillData('SQL', FontAwesomeIcons.database, 85, const Color(0xFF336791)),
      SkillData('HTML', FontAwesomeIcons.html5, 95, const Color(0xFFE34C26)),
      SkillData('CSS', FontAwesomeIcons.css3Alt, 93, const Color(0xFF1572B6)),
      SkillData('SCSS', FontAwesomeIcons.sass, 85, const Color(0xFFCC6699)),
    ],
    'FRAMEWORKS': [
      SkillData('React', FontAwesomeIcons.react, 90, const Color(0xFF61DAFB)),
      SkillData('React Native', FontAwesomeIcons.react, 82, const Color(0xFF61DAFB)),
      SkillData('Next.js', FontAwesomeIcons.n, 88, const Color(0xFF000000)),
      SkillData('Flutter', Icons.flutter_dash, 85, const Color(0xFF02569B)), // Flutter mit offiziellem Dash Icon
      SkillData('Node.js', FontAwesomeIcons.nodeJs, 85, const Color(0xFF339933)),
      SkillData('Express.js', FontAwesomeIcons.e, 83, const Color(0xFF000000)),
      SkillData('Django', FontAwesomeIcons.python, 75, const Color(0xFF092E20)),
      SkillData('Spring Boot', FontAwesomeIcons.leaf, 70, const Color(0xFF6DB33F)),
      SkillData('Vue.js', FontAwesomeIcons.vuejs, 72, const Color(0xFF4FC08D)),
      SkillData('Tailwind CSS', FontAwesomeIcons.wind, 90, const Color(0xFF06B6D4)),
      SkillData('NativeWind', FontAwesomeIcons.wind, 80, const Color(0xFF06B6D4)),
    ],
    'DATABASES': [
      SkillData('PostgreSQL', FontAwesomeIcons.database, 85, const Color(0xFF4169E1)), // PostgreSQL Blue
      SkillData('MongoDB', FontAwesomeIcons.leaf, 80, const Color(0xFF47A248)), // MongoDB Green
      SkillData('MySQL', FontAwesomeIcons.database, 82, const Color(0xFF00758F)), // MySQL Official Blue
      SkillData('Redis', FontAwesomeIcons.memory, 75, const Color(0xFFDC382D)), // Redis Red
      SkillData('Elasticsearch', FontAwesomeIcons.magnifyingGlass, 70, const Color(0xFF005571)), 
      SkillData('Firebase', FontAwesomeIcons.fire, 78, const Color(0xFFFFA000)), // Firebase Orange
      SkillData('DynamoDB', FontAwesomeIcons.aws, 68, const Color(0xFF4053D6)), // DynamoDB Blue
      SkillData('SQLite', FontAwesomeIcons.database, 75, const Color(0xFF07405E)), // SQLite Blue
    ],
    'CLOUD & DEVOPS': [
      SkillData('AWS', FontAwesomeIcons.aws, 85, const Color(0xFFFF9900)), // AWS Orange
      SkillData('Azure', FontAwesomeIcons.microsoft, 80, const Color(0xFF0078D4)), // Azure Blue
      SkillData('Google Cloud', FontAwesomeIcons.google, 75, const Color(0xFF4285F4)), // Google Blue
      SkillData('Docker', FontAwesomeIcons.docker, 82, const Color(0xFF2496ED)), // Docker Blue
      SkillData('Kubernetes', FontAwesomeIcons.dharmachakra, 78, const Color(0xFF326CE5)), // K8s Blue
      SkillData('CI/CD', FontAwesomeIcons.infinity, 80, const Color(0xFF40C4FF)),
      SkillData('Terraform', FontAwesomeIcons.cube, 70, const Color(0xFF7E3FF2)), // Terraform Purple
      SkillData('Linux', FontAwesomeIcons.linux, 85, const Color(0xFFFCC624)), // Linux Yellow
    ],
    'AI INTEGRATION': [
      SkillData('OpenAI API', FontAwesomeIcons.robot, 90, const Color(0xFF10A37F)), // OpenAI Green
      SkillData('LangChain', FontAwesomeIcons.link, 80, const Color(0xFF1C3C3C)),
      SkillData('TensorFlow', FontAwesomeIcons.brain, 75, const Color(0xFFFF6F00)), // TensorFlow Orange
      SkillData('PyTorch', FontAwesomeIcons.fire, 70, const Color(0xFFEE4C2C)), // PyTorch Red
      SkillData('Hugging Face', FontAwesomeIcons.faceSmile, 78, const Color(0xFFFFD21E)), // HF Yellow
      SkillData('Vector DBs', FontAwesomeIcons.database, 76, const Color(0xFF5865F2)), // Pinecone Purple
      SkillData('Prompt Engineering', FontAwesomeIcons.penToSquare, 88, const Color(0xFF412991)),
      SkillData('RAG Systems', FontAwesomeIcons.magnifyingGlass, 82, const Color(0xFF0084FF)),
    ],
  };

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
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 1200 ? 100 : 50,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A2A2D), // Ferrari Primary Gray
            Color(0xFF3C3C3F), // Metallic Gray
            Color(0xFF1A1A1D), // Dark Gray
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 60),
          _buildCategoryCards(),
          if (selectedCategory != null) ...[
            const SizedBox(height: 60),
            _buildSkillsGrid(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF00D4FF),
                    Color(0xFF0080FF),
                    Color(0xFF4A90E2),
                  ],
                ).createShader(bounds),
                child: const Text(
                  'TECHNICAL EXPERTISE',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Comprehensive skill set across modern technologies',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryCards() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: skillsData.keys.map((category) {
        final index = skillsData.keys.toList().indexOf(category);
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(milliseconds: 500 + (index * 100)),
          curve: Curves.easeOutBack,
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: _CategoryCard(
                category: category,
                isSelected: selectedCategory == category,
                skillCount: skillsData[category]!.length,
                color: _getCategoryColor(category),
                icon: _getCategoryIcon(category),
                onTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == category ? null : category;
                  });
                },
                floatingAnimation: _floatingController,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildSkillsGrid() {
    final skills = skillsData[selectedCategory] ?? [];
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                _getCategoryColor(selectedCategory!),
                _getCategoryColor(selectedCategory!).withOpacity(0.6),
              ],
            ).createShader(bounds),
            child: Text(
              selectedCategory!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: skills.asMap().entries.map((entry) {
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 300 + (entry.key * 50)),
                curve: Curves.easeOutBack,
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: _ModernSkillCard(
                      skill: entry.value,
                      index: entry.key,
                      pulseAnimation: _pulseController,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'LANGUAGES': return const Color(0xFF0080FF);
      case 'FRAMEWORKS': return const Color(0xFF00BFFF);
      case 'DATABASES': return const Color(0xFF4A90E2);
      case 'CLOUD & DEVOPS': return const Color(0xFF0066CC);
      case 'AI INTEGRATION': return const Color(0xFF00CEC9);
      default: return const Color(0xFF0080FF);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'LANGUAGES': return FontAwesomeIcons.code;
      case 'FRAMEWORKS': return FontAwesomeIcons.layerGroup;
      case 'DATABASES': return FontAwesomeIcons.database;
      case 'CLOUD & DEVOPS': return FontAwesomeIcons.cloud;
      case 'AI INTEGRATION': return FontAwesomeIcons.robot;
      default: return FontAwesomeIcons.code;
    }
  }
}

class _CategoryCard extends StatefulWidget {
  final String category;
  final bool isSelected;
  final int skillCount;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final AnimationController floatingAnimation;

  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.skillCount,
    required this.color,
    required this.icon,
    required this.onTap,
    required this.floatingAnimation,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: widget.floatingAnimation,
          builder: (context, child) {
            final floatValue = widget.isSelected 
                ? math.sin(widget.floatingAnimation.value * math.pi) * 5
                : 0.0;
            
            return Transform.translate(
              offset: Offset(0, floatValue),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 260,
                height: 160,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(_isHovered ? -0.03 : 0)
                  ..rotateY(_isHovered ? 0.03 : 0)
                  ..scale(_isHovered ? 1.05 : 1.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.isSelected || _isHovered ? [
                      widget.color.withOpacity(0.9),
                      widget.color.withOpacity(0.7),
                    ] : [
                      const Color(0xFF3C3C3F), // Metallic Gray
                      const Color(0xFF2A2A2D), // Primary Gray
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isSelected || _isHovered
                          ? widget.color.withOpacity(0.4)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: widget.isSelected || _isHovered ? 30 : 15,
                      offset: Offset(0, widget.isSelected || _isHovered ? 15 : 8),
                    ),
                  ],
                  border: Border.all(
                    color: widget.isSelected || _isHovered
                        ? widget.color
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    if (widget.isSelected || _isHovered)
                      Positioned(
                        top: -20,
                        right: -20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                widget.color.withOpacity(0.3),
                                widget.color.withOpacity(0),
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
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  widget.color,
                                  widget.color.withOpacity(0.7),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.color.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.icon,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.category,
                            style: TextStyle(
                              color: widget.isSelected || _isHovered
                                  ? Colors.white
                                  : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${widget.skillCount} Skills',
                            style: TextStyle(
                              color: widget.isSelected || _isHovered
                                  ? Colors.white70
                                  : Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                        ],
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

class _ModernSkillCard extends StatefulWidget {
  final SkillData skill;
  final int index;
  final AnimationController pulseAnimation;

  const _ModernSkillCard({
    required this.skill,
    required this.index,
    required this.pulseAnimation,
  });

  @override
  State<_ModernSkillCard> createState() => _ModernSkillCardState();
}

class _ModernSkillCardState extends State<_ModernSkillCard> 
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: Duration(milliseconds: 1000 + (widget.index * 100)),
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.skill.percentage / 100,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    ));
    
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: widget.pulseAnimation,
        builder: (context, child) {
          final pulseValue = _isHovered 
              ? 1.0 + (widget.pulseAnimation.value * 0.05)
              : 1.0;
          
          return Transform.scale(
            scale: pulseValue,
            child: Container(
              width: 200,
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isHovered ? [
                    widget.skill.color.withOpacity(0.9),
                    widget.skill.color.withOpacity(0.6),
                  ] : [
                    const Color(0xFF3C3C3F), // Metallic Gray
                    const Color(0xFF2A2A2D), // Primary Gray
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered 
                        ? widget.skill.color.withOpacity(0.4)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: _isHovered ? 25 : 15,
                    offset: Offset(0, _isHovered ? 12 : 8),
                  ),
                ],
                border: Border.all(
                  color: _isHovered 
                      ? widget.skill.color
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.skill.icon,
                      size: 40,
                      color: _isHovered 
                          ? Colors.white
                          : widget.skill.color,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.skill.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isHovered 
                            ? Colors.white
                            : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 160,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Container(
                                  width: 160 * _progressAnimation.value,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        widget.skill.color,
                                        widget.skill.color.withOpacity(0.6),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.skill.color.withOpacity(0.5),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${(_progressAnimation.value * 100).toInt()}%',
                              style: TextStyle(
                                color: _isHovered 
                                    ? Colors.white
                                    : widget.skill.color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
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

class SkillData {
  final String name;
  final IconData icon;
  final int percentage;
  final Color color;

  SkillData(this.name, this.icon, this.percentage, this.color);
}