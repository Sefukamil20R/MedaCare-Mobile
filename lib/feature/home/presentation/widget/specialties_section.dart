import 'package:flutter/material.dart';

class SpecialtyCard extends StatelessWidget {
  final String image;
  final String label;

  const SpecialtyCard({required this.image, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            image,
            width: 70,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
