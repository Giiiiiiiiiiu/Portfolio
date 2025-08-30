import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  
  int get currentIndex => _currentIndex;
  ScrollController get scrollController => _scrollController;
  
  final List<String> sections = [
    'Home',
    'Skills',
    'Education',
    'Company',
    'Contact',
  ];
  
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
  
  void scrollToSection(int index) {
    _currentIndex = index;
    notifyListeners();
    
    final double offset = index * 800.0;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}