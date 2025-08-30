import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';

class CustomNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomNavigationBar({super.key});
  
  @override
  Size get preferredSize => const Size.fromHeight(100);
  
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    
    _slideAnimation = Tween<double>(
      begin: -50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: 25,
              ),
              child: GlassmorphicContainer(
                width: size.width * 0.94,
                height: 70,
                borderRadius: 25,
                blur: 60,
                alignment: Alignment.center,
                border: 1.5,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    themeProvider.isDarkMode
                        ? const Color(0xFF1A1A2E).withOpacity(0.7)
                        : Colors.white.withOpacity(0.9),
                    themeProvider.isDarkMode
                        ? const Color(0xFF0F0F1E).withOpacity(0.5)
                        : Colors.white.withOpacity(0.7),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF00D4FF).withOpacity(0.3),
                    const Color(0xFF0080FF).withOpacity(0.2),
                    const Color(0xFF4A90E2).withOpacity(0.1),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLogo(context, themeProvider),
                      if (size.width > 900) 
                        Expanded(child: _buildDesktopMenu(context, navProvider, themeProvider)),
                      if (size.width <= 900) _buildMobileMenu(context),
                      Row(
                        children: [
                          _buildThemeToggle(context, themeProvider),
                          if (size.width > 900) const SizedBox(width: 10),
                          if (size.width > 900) _buildContactButton(context, themeProvider),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildLogo(BuildContext context, ThemeProvider themeProvider) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Provider.of<NavigationProvider>(context, listen: false).scrollToSection(0);
        },
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.elasticOut,
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF00D4FF),
                          Color(0xFF0080FF),
                          Color(0xFF4A90E2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0080FF).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'SK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        themeProvider.isDarkMode 
                            ? const Color(0xFF00D4FF)
                            : const Color(0xFF0080FF),
                        themeProvider.isDarkMode
                            ? const Color(0xFF0080FF) 
                            : const Color(0xFF4A90E2),
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'KOTENKOV',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildDesktopMenu(BuildContext context, NavigationProvider navProvider, ThemeProvider themeProvider) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: navProvider.sections.asMap().entries.map((entry) {
          final index = entry.key;
          final section = entry.value;
          final isSelected = navProvider.currentIndex == index;
          
          return _NavigationItem(
            label: section,
            isSelected: isSelected,
            isDarkMode: themeProvider.isDarkMode,
            onTap: () => navProvider.scrollToSection(index),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildMobileMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00D4FF), Color(0xFF0080FF)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showMobileMenu(context),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
  
  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final navProvider = Provider.of<NavigationProvider>(context);
        final themeProvider = Provider.of<ThemeProvider>(context);
        
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              alignment: Alignment.bottomCenter,
              child: GlassmorphicContainer(
                width: double.infinity,
                height: 400,
                borderRadius: 30,
                blur: 40,
                alignment: Alignment.center,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    themeProvider.isDarkMode
                        ? const Color(0xFF1A1A2E).withOpacity(0.95)
                        : Colors.white.withOpacity(0.95),
                    themeProvider.isDarkMode
                        ? const Color(0xFF0F0F1E).withOpacity(0.9)
                        : Colors.white.withOpacity(0.9),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF00D4FF).withOpacity(0.3),
                    const Color(0xFF0080FF).withOpacity(0.2),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...navProvider.sections.asMap().entries.map((entry) {
                      final index = entry.key;
                      final section = entry.value;
                      final isSelected = navProvider.currentIndex == index;
                      
                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        curve: Curves.easeOutBack,
                        builder: (context, double itemValue, child) {
                          return Transform.translate(
                            offset: Offset((1 - itemValue) * 50, 0),
                            child: Opacity(
                              opacity: itemValue,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                                decoration: BoxDecoration(
                                  gradient: isSelected ? const LinearGradient(
                                    colors: [Color(0xFF00D4FF), Color(0xFF0080FF)],
                                  ) : null,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () {
                                      navProvider.scrollToSection(index);
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                      child: Text(
                                        section,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                          color: isSelected 
                                              ? Colors.white 
                                              : (themeProvider.isDarkMode ? Colors.white70 : Colors.black87),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    _buildContactButton(context, themeProvider),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  Widget _buildThemeToggle(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode 
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => themeProvider.toggleTheme(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: Icon(
                themeProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(themeProvider.isDarkMode),
                color: themeProvider.isDarkMode ? Colors.amber : Colors.indigo,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildContactButton(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00D4FF), Color(0xFF0080FF)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0080FF).withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .scrollToSection(Provider.of<NavigationProvider>(context, listen: false).sections.length - 1);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Kontakt',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isDarkMode;
  final VoidCallback onTap;
  
  const _NavigationItem({
    required this.label,
    required this.isSelected,
    required this.isDarkMode,
    required this.onTap,
  });
  
  @override
  State<_NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<_NavigationItem> 
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;
  
  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
  }
  
  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverAnimation,
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: widget.isSelected || _isHovered
                          ? const Color(0xFF0080FF)
                          : (widget.isDarkMode ? Colors.white70 : Colors.black54),
                      fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                    child: Text(widget.label),
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2,
                    width: widget.isSelected 
                        ? 30
                        : (_isHovered ? 20 : 0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00D4FF), Color(0xFF0080FF)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}