import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SingleChildScrollView(
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
