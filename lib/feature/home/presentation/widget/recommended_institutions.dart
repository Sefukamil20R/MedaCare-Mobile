import 'package:flutter/material.dart';

class InstitutionCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String? specialization;

  const InstitutionCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
     this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make the card take full width
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Institution Image
          AspectRatio(
            aspectRatio: 16 / 9, // Maintain a 16:9 aspect ratio
            child: ClipRRect(
              
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.cover, // Ensure the image covers the space without stretching
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Institution Name
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),

          // Institution Location
         // Institution Location
Row(
  children: [
    const Icon(Icons.location_on, size: 16, color: Colors.black),
    const SizedBox(width: 2),
    Expanded(
      child: Text(
        location,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
),
          const SizedBox(height: 4),

          // Institution Specialization
          // Text(
          //   specialization,
          //   style: const TextStyle(
          //     fontSize: 14,
          //     color: Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }
}