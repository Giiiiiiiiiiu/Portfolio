import 'package:flutter/material.dart';

class CompanySection extends StatelessWidget {
  const CompanySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.grey[900],
      child: const Center(
        child: Text(
          'Companies Section - Coming Soon',
          style: TextStyle(color: Colors.white, fontSize: 48),
        ),
      ),
    );
  }
}