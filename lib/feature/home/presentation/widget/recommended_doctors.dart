import 'package:flutter/material.dart';

class PhysicianCard extends StatelessWidget {
  final String image;
  final String name;
  final String specialization;
  final double rating;
  final int experience;

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
      padding: const EdgeInsets.all(16), // Adjusted padding for better layout
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
        children: [
          // Doctor's Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 80, // Adjusted image size
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  size: 80,
                  color: Colors.grey,
                ); // Fallback for broken image URLs
              },
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
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                  maxLines: 1, // Limit to one line
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
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                  maxLines: 1, // Limit to one line
                ),
                const SizedBox(height: 6),
                // Experience
                Text(
                  '${experience.toStringAsFixed(experience.truncateToDouble() == experience ? 0 : 1)} years of experience',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey, // Very light color for experience
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                  maxLines: 1, // Limit to one line
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
                rating.toStringAsFixed(1), // Ensure one decimal place
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