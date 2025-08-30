import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/modern_skills_section.dart';
import '../widgets/education_section.dart';
import '../widgets/company_section.dart';
import '../widgets/ferrari_contact_section.dart';
import '../widgets/floating_action_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _scrollController = context.read<NavigationProvider>().scrollController;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomNavigationBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                HeroSection(),
                ModernSkillsSection(),
                EducationSection(),
                CompanySection(),
                FerrariContactSection(),
              ],
            ),
          ),
          const FloatingActionButtons(),
        ],
      ),
    );
  }
}