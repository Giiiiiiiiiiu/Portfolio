import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';

class CustomNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavigationBar({super.key});
  
  @override
  Size get preferredSize => const Size.fromHeight(80);
  
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: 20,
      ),
      child: GlassmorphicContainer(
        width: size.width * 0.9,
        height: 60,
        borderRadius: 30,
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
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(context),
              if (size.width > 800) _buildDesktopMenu(context, navProvider),
              if (size.width <= 800) _buildMobileMenu(context),
              _buildThemeToggle(context, themeProvider),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildLogo(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF6B5B95), Color(0xFF88B0D3)],
            ).createShader(bounds),
            child: const Text(
              'Portfolio',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildDesktopMenu(BuildContext context, NavigationProvider navProvider) {
    return Row(
      children: navProvider.sections.asMap().entries.map((entry) {
        final index = entry.key;
        final section = entry.value;
        final isSelected = navProvider.currentIndex == index;
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextButton(
            onPressed: () => navProvider.scrollToSection(index),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected 
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
              child: Text(section),
            ),
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildMobileMenu(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        _showMobileMenu(context);
      },
    );
  }
  
  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final navProvider = Provider.of<NavigationProvider>(context);
        
        return GlassmorphicContainer(
          width: double.infinity,
          height: 300,
          borderRadius: 20,
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
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.2),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: navProvider.sections.asMap().entries.map((entry) {
              final index = entry.key;
              final section = entry.value;
              
              return ListTile(
                title: Text(
                  section,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                onTap: () {
                  navProvider.scrollToSection(index);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
  
  Widget _buildThemeToggle(BuildContext context, ThemeProvider themeProvider) {
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey(themeProvider.isDarkMode),
        ),
      ),
      onPressed: () => themeProvider.toggleTheme(),
    );
  }
}