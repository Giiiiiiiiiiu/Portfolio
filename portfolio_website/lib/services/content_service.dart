import 'dart:convert';
import 'package:flutter/services.dart';

class ContentService {
  static final ContentService _instance = ContentService._internal();
  factory ContentService() => _instance;
  ContentService._internal();

  Map<String, dynamic>? _homeContent;
  Map<String, dynamic>? _skillsContent;
  Map<String, dynamic>? _navigationContent;

  Future<void> loadAllContent() async {
    await Future.wait([
      loadHomeContent(),
      loadSkillsContent(),
      loadNavigationContent(),
    ]);
  }

  Future<Map<String, dynamic>> loadHomeContent() async {
    if (_homeContent != null) return _homeContent!;
    
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/resources/home_content.json'
      );
      _homeContent = json.decode(jsonString);
      return _homeContent!;
    } catch (e) {
      print('Error loading home content: $e');
      return _getDefaultHomeContent();
    }
  }

  Future<Map<String, dynamic>> loadSkillsContent() async {
    // Always reload to get latest content
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/resources/skills_content.json'
      );
      _skillsContent = json.decode(jsonString);
      return _skillsContent!;
    } catch (e) {
      print('Error loading skills content: $e');
      return _getDefaultSkillsContent();
    }
  }

  Future<Map<String, dynamic>> loadNavigationContent() async {
    if (_navigationContent != null) return _navigationContent!;
    
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/resources/navigation_content.json'
      );
      _navigationContent = json.decode(jsonString);
      return _navigationContent!;
    } catch (e) {
      print('Error loading navigation content: $e');
      return _getDefaultNavigationContent();
    }
  }

  Map<String, dynamic> _getDefaultHomeContent() {
    return {
      'hero': {
        'name': 'SERGEY KOTENKOV',
        'titles': [
          'LUXURY DEVELOPER',
          'PREMIUM DESIGNER',
          'DIGITAL ARCHITECT',
          'CODE ARTIST'
        ],
        'description': 'Creating exceptional digital experiences with cutting-edge technology.',
      }
    };
  }

  Map<String, dynamic> _getDefaultSkillsContent() {
    return {
      'title': 'TECHNICAL EXPERTISE',
      'categories': {}
    };
  }

  Map<String, dynamic> _getDefaultNavigationContent() {
    return {
      'logo': 'KOTENKOV',
      'menuItems': []
    };
  }

  // Getter methods for easy access
  Map<String, dynamic>? get homeContent => _homeContent;
  Map<String, dynamic>? get skillsContent => _skillsContent;
  Map<String, dynamic>? get navigationContent => _navigationContent;
  
  // Hero Section
  String get heroName => _homeContent?['hero']?['name'] ?? 'SERGEY KOTENKOV';
  List<String> get heroTitles => List<String>.from(_homeContent?['hero']?['titles'] ?? []);
  String get heroDescription => _homeContent?['hero']?['description'] ?? '';
  
  // Skills Section
  String get skillsTitle => _skillsContent?['title'] ?? 'TECHNICAL EXPERTISE';
  Map<String, dynamic> get skillCategories => _skillsContent?['categories'] ?? {};
  
  // Navigation
  String get logo => _navigationContent?['logo'] ?? 'KOTENKOV';
  List<dynamic> get menuItems => _navigationContent?['menuItems'] ?? [];
  List<dynamic> get socialLinks => _navigationContent?['socialLinks'] ?? [];
}