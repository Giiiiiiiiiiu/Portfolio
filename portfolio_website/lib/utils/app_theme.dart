import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2C2C34);
  static const Color secondaryColor = Color(0xFF3E3E46);
  static const Color accentColor = Color(0xFF0080FF);
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color lightBackground = Color(0xFFF7F7F7);
  static const Color gradientStart = Color(0xFF1C1C24);
  static const Color gradientEnd = Color(0xFF3E3E46);
  static const Color neonAccent = Color(0xFF00BFFF);
  static const Color metallicBlue = Color(0xFF4A90E2);
  static const Color premiumBlue = Color(0xFF0066CC);
  static const Color premiumDark = Color(0xFF121216);
  static const Color glossyWhite = Color(0xFFFEFEFE);
  
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: lightBackground,
      ),
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 86,
            fontWeight: FontWeight.w900,
            letterSpacing: -2.5,
            height: 0.9,
          ),
          displayMedium: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
            height: 1.0,
          ),
          displaySmall: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.0,
          ),
          headlineMedium: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.25,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.25,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 12,
          shadowColor: accentColor.withOpacity(0.4),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
      )
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: darkBackground,
      ),
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.25,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
            color: Colors.white70,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.25,
            color: Colors.white70,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 20,
          shadowColor: accentColor.withOpacity(0.6),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0x1A2C2C2C)),
        ),
        color: const Color(0xFF0A0A0A),
      )
    );
  }
}