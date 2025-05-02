import 'package:flutter/material.dart';
import '../widget/recommended_institutions.dart'; // Import InstitutionCard widget
import '../widget/reviewcard.dart'; // Import ReviewCard widget

class InstitutionDetailsPage extends StatelessWidget {
  const InstitutionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF9FF),
        elevation: 0,
        title: const Text(
          'Institution Details',
          style: TextStyle(
            color: Color(0xFF1C665E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Institution Card
            const InstitutionCard(
              image: 'assets/images/inst.png',
              name: 'Addis Care Hospital',
              location: 'Addis Ababa, Ethiopia',
              specialization: 'Multi Super Specialty Hospital',
            ),
            const SizedBox(height: 26),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA55D68),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Rectangular shape
                      ),
                    ),
                    child: const Text(
                      'VIEW ALL DOCTORS',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA55D68),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Rectangular shape
                      ),
                    ),
                    child: const Text(
                      'CALL',
                      style: TextStyle(color: Colors.white),
                    ),
                    
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // About Hospital
            const Text(
              'About Hospital',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF174666),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Addis Care Hospital is a leading healthcare institution in Ethiopia, providing comprehensive medical services with state-of-the-art facilities and a team of highly skilled professionals. '
              'The hospital specializes in cardiology, neurology, orthopedics, and pediatrics, offering a wide range of treatments and diagnostic services. '
              'With a patient-centered approach, Addis Care Hospital ensures the highest quality of care for all its patients.',
              style: TextStyle(
                height: 1.4,
                fontSize: 12,
                color: Color(0xFF949494),
              ),
            ),
            const SizedBox(height: 40), // Add extra space to push reviews down

            // Reviews
            const Text(
              'Reviews (23)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ReviewCard(
                    name: 'John Doe',
                    date: '12/12/2023',
                    rating: 5,
                    comment:
                        'Excellent facilities and professional staff. Highly recommended!',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ReviewCard(
                    name: 'Jane Smith',
                    date: '10/10/2023',
                    rating: 4.5,
                    comment:
                        'Great experience! The doctors and nurses were very attentive.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}