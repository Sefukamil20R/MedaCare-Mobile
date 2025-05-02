import 'package:flutter/material.dart';

class PhysicianCard extends StatelessWidget {
  final String image;
  final String name;
  final String specialization;
  final double rating;
  final double experience;

  const PhysicianCard({
    super.key,
    required this.image,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32; // 16px margin each side

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.all(19), // Increased padding for more height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          // Doctor's Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 80, // Slightly larger image
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Doctor's Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1C665E), // Custom color for name
                  ),
                ),
                const SizedBox(height: 6),
                // Specialization
                Text(
                  specialization,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1C665E), // Custom color for specialization
                  ),
                ),
                const SizedBox(height: 6),
                // Experience
                Text(
                  '${experience.toStringAsFixed(experience.truncateToDouble() == experience ? 0 : 1)} years of experience',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey, // Very light color for experience
                  ),
                ),
              ],
            ),
          ),
          // Rating Section
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 20,
                color: Colors.orange, // Yellow star for rating
              ),
              const SizedBox(height: 4),
              Text(
                rating.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Rating',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey, // Very light color for "Rating" text
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}