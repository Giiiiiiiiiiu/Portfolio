import 'package:flutter/material.dart';

class FerrariTheme {
  // Ferrari-inspired luxury colors
  static const Color primaryGray = Color(0xFF2A2A2D); // Main Ferrari Gray
  static const Color darkGray = Color(0xFF1A1A1D); // Deep luxury black
  static const Color metallicGray = Color(0xFF3C3C3F); // Metallic finish
  static const Color carbonFiber = Color(0xFF0F0F11); // Carbon fiber black
  static const Color silverAccent = Color(0xFF8E8E93); // Silver details
  static const Color lightGray = Color(0xFF48484A); // Light gray accent
  static const Color pureWhite = Color(0xFFFAFAFA); // Clean white
  
  // Accent colors (keeping blue but Ferrari-style)
  static const Color ferrariBlue = Color(0xFF0066CC); // Deep luxury blue
  static const Color electricBlue = Color(0xFF007AFF); // Bright accent
  static const Color oceanBlue = Color(0xFF005CA5); // Deep ocean
  
  // Status colors
  static const Color successGreen = Color(0xFF34C759);
  static const Color warningOrange = Color(0xFFFF9500);
  static const Color dangerRed = Color(0xFFFF3B30);
  
  // Gradients
  static const LinearGradient ferrariGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryGray,
      metallicGray,
      darkGray,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  
  static const LinearGradient luxuryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF2A2A2D),
      Color(0xFF1F1F22),
      Color(0xFF141417),
    ],
  );
  
  static const LinearGradient metallicSheen = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3C3C3F),
      Color(0xFF2A2A2D),
      Color(0xFF3C3C3F),
    ],
  );
  
  // Box Shadows
  static List<BoxShadow> luxuryShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 40,
      offset: const Offset(0, 20),
    ),
  ];
  
  static List<BoxShadow> subtleShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];
  
  // Text Styles
  static TextStyle ferrariHeadline = const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 56,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
    color: pureWhite,
    height: 1.1,
  );
  
  static TextStyle luxuryTitle = const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: pureWhite,
  );
  
  static TextStyle elegantSubtitle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: silverAccent.withOpacity(0.9),
    height: 1.5,
  );
  
  static TextStyle premiumBody = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: pureWhite.withOpacity(0.8),
    height: 1.6,
  );
  
  // Border Radius
  static BorderRadius luxuryRadius = BorderRadius.circular(16);
  static BorderRadius subtleRadius = BorderRadius.circular(12);
  static BorderRadius sharpRadius = BorderRadius.circular(8);
  
  // Animations
  static Duration quickAnimation = const Duration(milliseconds: 300);
  static Duration smoothAnimation = const Duration(milliseconds: 500);
  static Duration elegantAnimation = const Duration(milliseconds: 700);
  
  static Curve luxuryCurve = Curves.easeOutCubic;
  static Curve smoothCurve = Curves.easeInOutCubic;
}