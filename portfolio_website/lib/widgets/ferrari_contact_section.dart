import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/ferrari_theme.dart';

class FerrariContactSection extends StatefulWidget {
  const FerrariContactSection({Key? key}) : super(key: key);

  @override
  State<FerrariContactSection> createState() => _FerrariContactSectionState();
}

class _FerrariContactSectionState extends State<FerrariContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  int? hoveredSocialIndex;
  bool isFormHovered = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1200;
    final isTablet = screenSize.width > 600 && screenSize.width <= 1200;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 140 : (isTablet ? 80 : 40),
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        gradient: FerrariTheme.luxuryGradient,
      ),
      child: Stack(
        children: [
          // Carbon fiber pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: CarbonFiberPatternPainter(),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSectionTitle(context),
              const SizedBox(height: 80),
              isDesktop || isTablet
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildLuxuryContactForm(context)),
                        const SizedBox(width: 60),
                        Expanded(child: _buildLuxuryContactInfo(context)),
                      ],
                    )
                  : Column(
                      children: [
                        _buildLuxuryContactForm(context),
                        const SizedBox(height: 40),
                        _buildLuxuryContactInfo(context),
                      ],
                    ),
              const SizedBox(height: 100),
              _buildLuxuryFooter(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        duration: FerrariTheme.elegantAnimation,
        verticalOffset: -60,
        curve: FerrariTheme.luxuryCurve,
        child: FadeInAnimation(
          duration: FerrariTheme.elegantAnimation,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                    'GET IN TOUCH',
                    style: FerrariTheme.ferrariHeadline.copyWith(
                      fontSize: 52,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Let\'s Create Something Extraordinary Together',
                  style: FerrariTheme.elegantSubtitle.copyWith(
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLuxuryContactForm(BuildContext context) {
    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        duration: FerrariTheme.elegantAnimation,
        horizontalOffset: -100,
        curve: FerrariTheme.luxuryCurve,
        child: FadeInAnimation(
          duration: FerrariTheme.smoothAnimation,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => isFormHovered = true),
            onExit: (_) => setState(() => isFormHovered = false),
            child: AnimatedContainer(
              duration: FerrariTheme.quickAnimation,
              transform: Matrix4.identity()
                ..translate(0.0, isFormHovered ? -8.0 : 0.0)
                ..scale(isFormHovered ? 1.02 : 1.0),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      FerrariTheme.metallicGray.withValues(alpha: 0.9),
                      FerrariTheme.primaryGray,
                      FerrariTheme.darkGray,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                  borderRadius: FerrariTheme.luxuryRadius,
                  boxShadow: isFormHovered ? [
                    ...FerrariTheme.luxuryShadow,
                    BoxShadow(
                      color: FerrariTheme.ferrariBlue.withValues(alpha: 0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ] : FerrariTheme.subtleShadow,
                  border: Border.all(
                    width: 1.5,
                    color: isFormHovered 
                      ? FerrariTheme.electricBlue.withValues(alpha: 0.6)
                      : FerrariTheme.silverAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  FerrariTheme.ferrariBlue,
                                  FerrariTheme.electricBlue,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: FerrariTheme.ferrariBlue.withValues(alpha: 0.4),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              FontAwesomeIcons.envelope,
                              color: FerrariTheme.pureWhite,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'SEND MESSAGE',
                            style: FerrariTheme.luxuryTitle.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      _buildLuxuryTextField(
                        controller: _nameController,
                        label: 'Your Name',
                        icon: FontAwesomeIcons.user,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      _buildLuxuryTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        icon: FontAwesomeIcons.at,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      _buildLuxuryTextField(
                        controller: _messageController,
                        label: 'Your Message',
                        icon: FontAwesomeIcons.comment,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your message';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      _buildLuxurySendButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLuxuryTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(
        color: FerrariTheme.pureWhite,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: FerrariTheme.silverAccent.withValues(alpha: 0.8),
          fontSize: 15,
        ),
        prefixIcon: maxLines == 1
            ? Icon(
                icon,
                color: FerrariTheme.ferrariBlue,
                size: 20,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: FerrariTheme.subtleRadius,
          borderSide: BorderSide(
            color: FerrariTheme.silverAccent.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: FerrariTheme.subtleRadius,
          borderSide: const BorderSide(
            color: FerrariTheme.electricBlue,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: FerrariTheme.subtleRadius,
          borderSide: const BorderSide(
            color: FerrariTheme.dangerRed,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: FerrariTheme.subtleRadius,
          borderSide: const BorderSide(
            color: FerrariTheme.dangerRed,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: FerrariTheme.carbonFiber.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _buildLuxurySendButton(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: FerrariTheme.elegantAnimation,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + 0.05 * value,
          child: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Message sent successfully!'),
                    backgroundColor: FerrariTheme.ferrariBlue,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: FerrariTheme.subtleRadius,
                    ),
                  ),
                );
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                borderRadius: FerrariTheme.subtleRadius,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    FerrariTheme.ferrariBlue,
                    FerrariTheme.electricBlue,
                    FerrariTheme.oceanBlue,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: FerrariTheme.ferrariBlue.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.paperPlane,
                    color: FerrariTheme.pureWhite,
                    size: 18,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'SEND MESSAGE',
                    style: TextStyle(
                      color: FerrariTheme.pureWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLuxuryContactInfo(BuildContext context) {
    final contactInfo = [
      {
        'icon': FontAwesomeIcons.envelope,
        'title': 'EMAIL',
        'value': 'hello@portfolio.com',
        'link': 'mailto:hello@portfolio.com',
      },
      {
        'icon': FontAwesomeIcons.phone,
        'title': 'PHONE',
        'value': '+49 123 456789',
        'link': 'tel:+49123456789',
      },
      {
        'icon': FontAwesomeIcons.mapMarkerAlt,
        'title': 'LOCATION',
        'value': 'Berlin, Germany',
        'link': '',
      },
    ];

    final socialLinks = [
      {
        'icon': FontAwesomeIcons.github,
        'url': 'https://github.com',
        'color': FerrariTheme.silverAccent,
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'url': 'https://linkedin.com',
        'color': FerrariTheme.ferrariBlue,
      },
      {
        'icon': FontAwesomeIcons.twitter,
        'url': 'https://twitter.com',
        'color': FerrariTheme.electricBlue,
      },
      {
        'icon': FontAwesomeIcons.instagram,
        'url': 'https://instagram.com',
        'gradient': [FerrariTheme.ferrariBlue, FerrariTheme.electricBlue],
      },
    ];

    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        duration: FerrariTheme.elegantAnimation,
        horizontalOffset: 100,
        curve: FerrariTheme.luxuryCurve,
        child: FadeInAnimation(
          duration: FerrariTheme.smoothAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      FerrariTheme.metallicGray,
                      FerrariTheme.primaryGray,
                      FerrariTheme.darkGray,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                  borderRadius: FerrariTheme.luxuryRadius,
                  boxShadow: FerrariTheme.subtleShadow,
                  border: Border.all(
                    width: 1.5,
                    color: FerrariTheme.silverAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                FerrariTheme.silverAccent,
                                FerrariTheme.metallicGray,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: FerrariTheme.carbonFiber.withValues(alpha: 0.5),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Icon(
                            FontAwesomeIcons.info,
                            color: FerrariTheme.pureWhite,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'CONTACT INFO',
                          style: FerrariTheme.luxuryTitle.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ...contactInfo.map((info) => _buildLuxuryContactItem(info)).toList(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      FerrariTheme.metallicGray,
                      FerrariTheme.primaryGray,
                      FerrariTheme.darkGray,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                  borderRadius: FerrariTheme.luxuryRadius,
                  boxShadow: FerrariTheme.subtleShadow,
                  border: Border.all(
                    width: 1.5,
                    color: FerrariTheme.silverAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FOLLOW ME',
                      style: FerrariTheme.luxuryTitle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: socialLinks.asMap().entries.map((entry) {
                        final index = entry.key;
                        final social = entry.value;
                        return _buildLuxurySocialIcon(social, index);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLuxuryContactItem(Map<String, dynamic> info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: info['link'].toString().isNotEmpty
            ? () async {
                final url = Uri.parse(info['link'] as String);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              }
            : null,
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    FerrariTheme.ferrariBlue.withValues(alpha: 0.2),
                    FerrariTheme.electricBlue.withValues(alpha: 0.1),
                  ],
                ),
                border: Border.all(
                  color: FerrariTheme.ferrariBlue.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                info['icon'] as IconData,
                color: FerrariTheme.electricBlue,
                size: 22,
              ),
            ),
            const SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info['title'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: FerrariTheme.silverAccent.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  info['value'] as String,
                  style: const TextStyle(
                    fontSize: 17,
                    color: FerrariTheme.pureWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuxurySocialIcon(Map<String, dynamic> social, int index) {
    final isHovered = hoveredSocialIndex == index;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredSocialIndex = index),
      onExit: (_) => setState(() => hoveredSocialIndex = null),
      child: InkWell(
        onTap: () async {
          final url = Uri.parse(social['url'] as String);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        child: AnimatedContainer(
          duration: FerrariTheme.quickAnimation,
          margin: const EdgeInsets.only(right: 20),
          width: 55,
          height: 55,
          transform: Matrix4.identity()
            ..translate(0.0, isHovered ? -5.0 : 0.0)
            ..scale(isHovered ? 1.1 : 1.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isHovered && social['gradient'] != null
                ? LinearGradient(
                    colors: social['gradient'] as List<Color>,
                  )
                : null,
            color: isHovered && social['gradient'] == null
                ? (social['color'] as Color)
                : FerrariTheme.carbonFiber,
            border: Border.all(
              color: isHovered
                  ? (social['color'] as Color? ?? FerrariTheme.ferrariBlue)
                  : FerrariTheme.silverAccent.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: (social['color'] as Color? ?? 
                          FerrariTheme.ferrariBlue).withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            social['icon'] as IconData,
            color: isHovered 
                ? FerrariTheme.pureWhite 
                : FerrariTheme.silverAccent.withValues(alpha: 0.8),
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildLuxuryFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: FerrariTheme.silverAccent.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                FerrariTheme.silverAccent,
                FerrariTheme.pureWhite,
                FerrariTheme.silverAccent,
              ],
            ).createShader(bounds),
            child: Text(
              '© 2024 PORTFOLIO',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
                color: FerrariTheme.silverAccent.withValues(alpha: 0.6),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CRAFTED WITH',
                style: TextStyle(
                  fontSize: 13,
                  color: FerrariTheme.silverAccent.withValues(alpha: 0.5),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    FerrariTheme.ferrariBlue,
                    FerrariTheme.electricBlue,
                  ],
                ).createShader(bounds),
                child: const Icon(
                  FontAwesomeIcons.heart,
                  color: FerrariTheme.pureWhite,
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'AND FLUTTER',
                style: TextStyle(
                  fontSize: 13,
                  color: FerrariTheme.silverAccent.withValues(alpha: 0.5),
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Carbon fiber pattern painter
class CarbonFiberPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = FerrariTheme.carbonFiber.withValues(alpha: 0.05)
      ..strokeWidth = 0.5;
      
    const spacing = 25.0;
    
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
      canvas.drawLine(
        Offset(i + spacing / 2, 0),
        Offset(i + size.height - spacing / 2, size.height),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}