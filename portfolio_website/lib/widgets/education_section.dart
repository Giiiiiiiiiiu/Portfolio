import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.grey[800],
      child: const Center(
        child: Text(
          'Education Section - Coming Soon',
          style: TextStyle(color: Colors.white, fontSize: 48),
        ),
      ),
    );
  }
}