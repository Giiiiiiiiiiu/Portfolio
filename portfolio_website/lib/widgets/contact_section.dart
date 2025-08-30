import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  int? hoveredSocialIndex;

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
        horizontal: isDesktop ? 120 : (isTablet ? 60 : 30),
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            const Color(0xFF1a1a2e),
            const Color(0xFF16213e),
            const Color(0xFF0f3460),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 60),
          isDesktop || isTablet
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactForm(context)),
                    const SizedBox(width: 60),
                    Expanded(child: _buildContactInfo(context)),
                  ],
                )
              : Column(
                  children: [
                    _buildContactForm(context),
                    const SizedBox(height: 40),
                    _buildContactInfo(context),
                  ],
                ),
          const SizedBox(height: 80),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        duration: const Duration(milliseconds: 800),
        verticalOffset: -50,
        child: FadeInAnimation(
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    const Color(0xFF00D2FF),
                    const Color(0xFF3A7BD5),
                    const Color(0xFF00D2FF),
                  ],
                ).createShader(bounds),
                child: const Text(
                  'Kontakt',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Lass uns zusammenarbeiten!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        duration: const Duration(milliseconds: 800),
        horizontalOffset: -50,
        child: FadeInAnimation(
          child: GlassmorphicContainer(
            width: double.infinity,
            height: 500,
            borderRadius: 25,
            blur: 20,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF00D2FF).withOpacity(0.5),
                Colors.white.withOpacity(0.2),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nachricht senden',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField(
                      controller: _nameController,
                      label: 'Name',
                      icon: FontAwesomeIcons.user,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Namen eingeben';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _emailController,
                      label: 'E-Mail',
                      icon: FontAwesomeIcons.envelope,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte E-Mail eingeben';
                        }
                        if (!value.contains('@')) {
                          return 'Bitte gültige E-Mail eingeben';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _messageController,
                      label: 'Nachricht',
                      icon: FontAwesomeIcons.comment,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Nachricht eingeben';
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    _buildSendButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
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
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        prefixIcon: maxLines == 1
            ? Icon(icon, color: const Color(0xFF00D2FF), size: 20)
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFF00D2FF),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          // Hier würde normalerweise die E-Mail versendet werden
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nachricht wurde gesendet!'),
              backgroundColor: Color(0xFF00D2FF),
            ),
          );
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00D2FF),
              Color(0xFF3A7BD5),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00D2FF).withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.paperPlane,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 10),
            Text(
              'Nachricht senden',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final contactInfo = [
      {
        'icon': FontAwesomeIcons.envelope,
        'title': 'E-Mail',
        'value': 'contact@example.com',
        'link': 'mailto:contact@example.com',
      },
      {
        'icon': FontAwesomeIcons.phone,
        'title': 'Telefon',
        'value': '+49 123 456789',
        'link': 'tel:+49123456789',
      },
      {
        'icon': FontAwesomeIcons.mapMarkerAlt,
        'title': 'Standort',
        'value': 'Berlin, Deutschland',
        'link': '',
      },
    ];

    final socialLinks = [
      {
        'icon': FontAwesomeIcons.github,
        'url': 'https://github.com',
        'color': const Color(0xFF333333),
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'url': 'https://linkedin.com',
        'color': const Color(0xFF0077B5),
      },
      {
        'icon': FontAwesomeIcons.twitter,
        'url': 'https://twitter.com',
        'color': const Color(0xFF1DA1F2),
      },
      {
        'icon': FontAwesomeIcons.instagram,
        'url': 'https://instagram.com',
        'color': const Color(0xFFE4405F),
      },
    ];

    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        duration: const Duration(milliseconds: 800),
        horizontalOffset: 50,
        child: FadeInAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kontaktinformationen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 30),
              ...contactInfo.map((info) => _buildContactInfoItem(info)).toList(),
              const SizedBox(height: 40),
              Text(
                'Folge mir',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: socialLinks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final social = entry.value;
                  return _buildSocialIcon(social, index);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfoItem(Map<String, dynamic> info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: InkWell(
        onTap: info['link'].isNotEmpty
            ? () async {
                final url = Uri.parse(info['link']);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              }
            : null,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF00D2FF).withOpacity(0.2),
                    const Color(0xFF3A7BD5).withOpacity(0.2),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFF00D2FF).withOpacity(0.5),
                ),
              ),
              child: Icon(
                info['icon'] as IconData,
                color: const Color(0xFF00D2FF),
                size: 20,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  info['value'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(Map<String, dynamic> social, int index) {
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
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 15),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isHovered
                ? (social['color'] as Color)
                : Colors.white.withOpacity(0.1),
            border: Border.all(
              color: isHovered
                  ? (social['color'] as Color)
                  : Colors.white.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: (social['color'] as Color).withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            social['icon'] as IconData,
            color: isHovered ? Colors.white : Colors.white.withOpacity(0.7),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            '© 2024 Portfolio. Alle Rechte vorbehalten.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Entwickelt mit',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                FontAwesomeIcons.heart,
                color: Color(0xFFFF006E),
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                'und Flutter',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}