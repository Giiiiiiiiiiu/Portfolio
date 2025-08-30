import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String? expandedCategory;

  final Map<String, List<SkillItem>> skillCategories = {
    'LANGUAGES': [
      SkillItem('Python', Icons.code, 95, 'Backend & AI'),
      SkillItem('JavaScript', Icons.javascript, 90, 'Frontend & Backend'),
      SkillItem('TypeScript', Icons.code, 88, 'Type-Safe Development'),
      SkillItem('Dart', Icons.phone_android, 85, 'Flutter Development'),
      SkillItem('Java', Icons.coffee, 80, 'Enterprise Applications'),
      SkillItem('C#', Icons.window, 75, '.NET Development'),
      SkillItem('SQL', Icons.storage, 85, 'Database Queries'),
      SkillItem('HTML/CSS', Icons.web, 95, 'Web Markup & Styling'),
    ],
    'FRAMEWORKS': [
      SkillItem('React', Icons.web, 90, 'SPA Development'),
      SkillItem('Next.js', Icons.web_asset, 88, 'Full-Stack React'),
      SkillItem('Flutter', Icons.mobile_friendly, 85, 'Cross-Platform Apps'),
      SkillItem('Node.js', Icons.dns, 85, 'Server-Side JavaScript'),
      SkillItem('Express.js', Icons.api, 83, 'REST APIs'),
      SkillItem('Django', Icons.security, 75, 'Python Web Framework'),
      SkillItem('Spring Boot', Icons.settings_applications, 70, 'Java Framework'),
      SkillItem('Vue.js', Icons.view_agenda, 72, 'Progressive Framework'),
    ],
    'DATABASES': [
      SkillItem('PostgreSQL', Icons.storage, 85, 'Relational Database'),
      SkillItem('MongoDB', Icons.data_object, 80, 'NoSQL Database'),
      SkillItem('MySQL', Icons.storage, 82, 'Relational Database'),
      SkillItem('Redis', Icons.speed, 75, 'In-Memory Cache'),
      SkillItem('Elasticsearch', Icons.search, 70, 'Search Engine'),
      SkillItem('Firebase', Icons.cloud, 78, 'Real-time Database'),
      SkillItem('DynamoDB', Icons.table_chart, 68, 'AWS NoSQL'),
      SkillItem('SQLite', Icons.phone_android, 75, 'Embedded Database'),
    ],
    'CLOUD & DEVOPS': [
      SkillItem('AWS', Icons.cloud_queue, 85, 'Amazon Web Services'),
      SkillItem('Microsoft Azure', Icons.cloud_circle, 80, 'Microsoft Cloud'),
      SkillItem('Google Cloud', Icons.cloud, 75, 'GCP Platform'),
      SkillItem('Docker', Icons.hub, 82, 'Containerization'),
      SkillItem('Kubernetes', Icons.hub_outlined, 78, 'Container Orchestration'),
      SkillItem('CI/CD', Icons.autorenew, 80, 'Jenkins, GitHub Actions'),
      SkillItem('Terraform', Icons.build, 70, 'Infrastructure as Code'),
      SkillItem('Linux', Icons.computer, 85, 'Server Administration'),
    ],
    'AI INTEGRATION': [
      SkillItem('OpenAI API', Icons.auto_awesome, 90, 'GPT-4, DALL-E'),
      SkillItem('LangChain', Icons.link, 80, 'LLM Orchestration'),
      SkillItem('TensorFlow', Icons.psychology, 75, 'Machine Learning'),
      SkillItem('PyTorch', Icons.psychology_alt, 70, 'Deep Learning'),
      SkillItem('Hugging Face', Icons.face, 78, 'NLP Models'),
      SkillItem('Vector DBs', Icons.scatter_plot, 76, 'Pinecone, Weaviate'),
      SkillItem('Prompt Engineering', Icons.edit_note, 88, 'LLM Optimization'),
      SkillItem('RAG Systems', Icons.find_in_page, 82, 'Retrieval Augmented'),
    ],
  };

  final Map<String, IconData> categoryIcons = {
    'LANGUAGES': Icons.code,
    'FRAMEWORKS': Icons.layers,
    'DATABASES': Icons.storage,
    'CLOUD & DEVOPS': Icons.cloud,
    'AI INTEGRATION': Icons.auto_awesome,
  };

  final Map<String, Color> categoryColors = {
    'LANGUAGES': const Color(0xFF0080FF),
    'FRAMEWORKS': const Color(0xFF00BFFF),
    'DATABASES': const Color(0xFF4A90E2),
    'CLOUD & DEVOPS': const Color(0xFF0066CC),
    'AI INTEGRATION': const Color(0xFF00CEC9),
  };

  @override
  Widget build(BuildContext context) {
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
          Text(
            'TECHNICAL EXPERTISE',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
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
    final color = categoryColors[category]!;
    final icon = categoryIcons[category]!;
    final skillCount = skillCategories[category]!.length;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            expandedCategory = isExpanded ? null : category;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          transform: Matrix4.identity()
            ..scale(isExpanded ? 1.05 : 1.0),
          child: GlassmorphicContainer(
            width: 280,
            height: 200,
            borderRadius: 20,
            blur: 20,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.05),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.5),
                color.withOpacity(0.2),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          color,
                          color.withOpacity(0.6),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$skillCount Skills',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isExpanded 
                        ? Colors.white.withOpacity(0.2)
                        : color.withOpacity(0.3),
                    ),
                    child: Text(
                      isExpanded ? 'CLOSE' : 'VIEW MORE',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedSkills(BuildContext context) {
    final skills = skillCategories[expandedCategory]!;
    final color = categoryColors[expandedCategory]!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      child: Column(
        children: [
          Text(
            expandedCategory!,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: skills.map((skill) {
              return _buildSkillCard(context, skill, color);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, SkillItem skill, Color color) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1C1C24),
                  const Color(0xFF2C2C34),
                ],
              ),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  skill.icon,
                  size: 30,
                  color: color,
                ),
                const SizedBox(height: 12),
                Text(
                  skill.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  skill.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                _buildProgressBar(skill.percentage, color),
              ],
            ),
          ),
        );
      },
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