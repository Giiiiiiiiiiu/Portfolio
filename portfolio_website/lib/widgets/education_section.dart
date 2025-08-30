import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class EducationSection extends StatefulWidget {
  const EducationSection({super.key});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> 
    with TickerProviderStateMixin {
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
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1200;
    final isTablet = screenSize.width > 600 && screenSize.width <= 1200;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : (isTablet ? 60 : 30),
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF141417),
            Color(0xFF1A1A1D),
            Color(0xFF0F0F11),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 80),
          _buildEducationTimeline(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi) * 8),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF8E8E93),
                    Color(0xFFFAFAFA),
                    Color(0xFF8E8E93),
                  ],
                ).createShader(bounds),
                child: const Text(
                  'EDUCATIONAL JOURNEY',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Academic Excellence & Professional Development',
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

  Widget _buildEducationTimeline(BuildContext context) {
    final educationData = [
      {
        'year': '2021 - 2024',
        'degree': 'Bachelor of Computer Science',
        'institution': 'Technical University',
        'location': 'Munich, Germany',
        'description': 'Specialized in Software Engineering and AI',
        'icon': FontAwesomeIcons.graduationCap,
        'grade': '1.7 GPA',
      },
      {
        'year': '2019 - 2021',
        'degree': 'Advanced Technical Certificate',
        'institution': 'Professional Academy',
        'location': 'Berlin, Germany',
        'description': 'Focus on Full-Stack Development',
        'icon': FontAwesomeIcons.certificate,
        'grade': 'With Distinction',
      },
      {
        'year': '2015 - 2019',
        'degree': 'Technical Diploma',
        'institution': 'Technical Institute',
        'location': 'Hamburg, Germany',
        'description': 'Foundation in Computer Science',
        'icon': FontAwesomeIcons.school,
        'grade': 'Top 5% of Class',
      },
    ];

    return AnimationLimiter(
      child: Column(
        children: educationData.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 800),
            child: SlideAnimation(
              horizontalOffset: index.isEven ? -50 : 50,
              child: FadeInAnimation(
                child: _buildEducationCard(data, index),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEducationCard(Map<String, dynamic> data, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            if (index.isEven) ...[
              Expanded(child: _buildCardContent(data, true)),
              const SizedBox(width: 40),
              _buildTimelineNode(index),
              const SizedBox(width: 40),
              Expanded(child: Container()),
            ] else ...[
              Expanded(child: Container()),
              const SizedBox(width: 40),
              _buildTimelineNode(index),
              const SizedBox(width: 40),
              Expanded(child: _buildCardContent(data, false)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent(Map<String, dynamic> data, bool isLeft) {
    return HoverCard(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2A2A2D),
              Color(0xFF1A1A1D),
            ],
          ),
          border: Border.all(
            color: const Color(0xFF2A2A2D),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: isLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isLeft) ...[
                  _buildIcon(data['icon']),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: isLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['year'],
                        style: const TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['degree'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: isLeft ? TextAlign.end : TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['institution'],
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 16,
                        ),
                        textAlign: isLeft ? TextAlign.end : TextAlign.start,
                      ),
                    ],
                  ),
                ),
                if (isLeft) ...[
                  const SizedBox(width: 16),
                  _buildIcon(data['icon']),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Text(
              data['description'],
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: isLeft ? TextAlign.end : TextAlign.start,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: isLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                _buildChip(data['location'], FontAwesomeIcons.locationDot),
                const SizedBox(width: 12),
                _buildChip(data['grade'], FontAwesomeIcons.award),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF007AFF),
            Color(0xFF0066CC),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007AFF).withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 22,
      ),
    );
  }

  Widget _buildChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: const Color(0xFF8E8E93),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineNode(int index) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF007AFF),
                Color(0xFF0066CC),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF007AFF).withValues(
                  alpha: 0.3 + 0.2 * _pulseController.value,
                ),
                blurRadius: 20 + 10 * _pulseController.value,
                spreadRadius: 2 + 3 * _pulseController.value,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '0${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;
  
  const HoverCard({super.key, required this.child});

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
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
        animation: _controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..scale(1.0 + 0.02 * _controller.value)
              ..translate(0.0, -5.0 * _controller.value),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF007AFF).withValues(
                      alpha: 0.2 * _controller.value,
                    ),
                    blurRadius: 30 * _controller.value,
                    offset: Offset(0, 10 * _controller.value),
                  ),
                ],
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}