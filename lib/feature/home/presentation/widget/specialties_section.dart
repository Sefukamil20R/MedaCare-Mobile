import 'package:flutter/material.dart';

class SpecialtyCard extends StatelessWidget {
  final String image;
  final String label;

  const SpecialtyCard({
    required this.image,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 53,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF9FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Image.asset(
              image,
              width: 36,
              height: 36,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
