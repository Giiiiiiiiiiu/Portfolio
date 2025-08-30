import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
            'PREMIUM SKILLS',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _buildSectionTitle(context, 'LANGUAGES'),
              _build3DSkillCard(
                context,
                'Python',
                Icons.code,
                const Color(0xFF0080FF),
                'Backend & AI',
                95,
              ),
              _build3DSkillCard(
                context,
                'JavaScript/TypeScript',
                Icons.javascript,
                const Color(0xFF00BFFF),
                'Full Stack',
                90,
              ),
              _build3DSkillCard(
                context,
                'Dart',
                Icons.phone_android,
                const Color(0xFF4A90E2),
                'Mobile Development',
                85,
              ),
              const SizedBox(width: double.infinity, height: 40),
              _buildSectionTitle(context, 'FRAMEWORKS'),
              _build3DSkillCard(
                context,
                'React/Next.js',
                Icons.web,
                const Color(0xFF0066CC),
                'Web Applications',
                90,
              ),
              _build3DSkillCard(
                context,
                'Flutter',
                Icons.mobile_friendly,
                const Color(0xFF0080FF),
                'Cross-Platform',
                85,
              ),
              _build3DSkillCard(
                context,
                'Node.js/Express',
                Icons.api,
                const Color(0xFF00BFFF),
                'Backend APIs',
                88,
              ),
              const SizedBox(width: double.infinity, height: 40),
              _buildSectionTitle(context, 'DATABASES'),
              _build3DSkillCard(
                context,
                'PostgreSQL',
                Icons.storage,
                const Color(0xFF4A90E2),
                'Relational DB',
                85,
              ),
              _build3DSkillCard(
                context,
                'MongoDB',
                Icons.data_object,
                const Color(0xFF0066CC),
                'NoSQL',
                80,
              ),
              _build3DSkillCard(
                context,
                'Redis',
                Icons.speed,
                const Color(0xFF0080FF),
                'Caching',
                75,
              ),
              const SizedBox(width: double.infinity, height: 40),
              _buildSectionTitle(context, 'CLOUD SERVICES'),
              _build3DSkillCard(
                context,
                'AWS',
                Icons.cloud_queue,
                const Color(0xFF00BFFF),
                'Amazon Web Services',
                85,
              ),
              _build3DSkillCard(
                context,
                'Microsoft Azure',
                Icons.cloud_circle,
                const Color(0xFF4A90E2),
                'Microsoft Cloud',
                80,
              ),
              _build3DSkillCard(
                context,
                'Docker/K8s',
                Icons.hub,
                const Color(0xFF0066CC),
                'Containerization',
                82,
              ),
              const SizedBox(width: double.infinity, height: 40),
              _buildSectionTitle(context, 'AI INTEGRATION'),
              _build3DSkillCard(
                context,
                'OpenAI/GPT',
                Icons.auto_awesome,
                const Color(0xFF0080FF),
                'Language Models',
                90,
              ),
              _build3DSkillCard(
                context,
                'TensorFlow',
                Icons.psychology,
                const Color(0xFF00BFFF),
                'Machine Learning',
                75,
              ),
              _build3DSkillCard(
                context,
                'LangChain',
                Icons.link,
                const Color(0xFF4A90E2),
                'AI Orchestration',
                80,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: const Color(0xFF0080FF),
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
        ),
      ),
    );
  }

  Widget _build3DSkillCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String description,
    int percentage,
  ) {
    return Skill3DCard(
      title: title,
      icon: icon,
      color: color,
      description: description,
      percentage: percentage,
    );
  }
}

class Skill3DCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final int percentage;

  const Skill3DCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.percentage,
  }) : super(key: key);

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
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_rotationAnimation.value)
              ..rotateX(-_rotationAnimation.value / 2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 280,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.color.withValues(alpha: 0.8),
                    widget.color.withValues(alpha: 0.4),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha: _isHovering ? 0.6 : 0.3),
                    blurRadius: _isHovering ? 30 : 15,
                    spreadRadius: _isHovering ? 5 : 0,
                    offset: Offset(0, _isHovering ? 10 : 5),
                  ),
                  if (_isHovering)
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.2),
                      blurRadius: 50,
                      spreadRadius: 10,
                    ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.3),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            widget.icon,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Expertise',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${widget.percentage}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 1000),
                                    curve: Curves.easeOutCubic,
                                    width: (280 - 50) * (widget.percentage / 100),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.white.withValues(alpha: 0.8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withValues(alpha: 0.5),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}