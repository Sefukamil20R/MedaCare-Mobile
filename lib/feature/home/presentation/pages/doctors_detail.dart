import 'package:flutter/material.dart';
import '../widget/recommended_doctors.dart';
import '../widget/reviewcard.dart'; 

class PhysicianDetailsPage extends StatelessWidget {
  const PhysicianDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF9FF),
        elevation: 0,
        title: const Text(
          'Physicians Details',
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
            // Physician Card
            const PhysicianCard(
              image: 'assets/images/Doctor.png',
              name: 'Dr. Abeba Kebede',
              specialization: 'Cardiologist',
              rating: 4.5,
              experience: 12,
            ),
            const SizedBox(height: 16),

            // Virtual Consultation Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[700],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Virtual Consultation',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Consulting Fee: 500 Birr',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Google Meet / Zoom',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• General Health Check-Ins'),
                        Text('• Chronic Condition Management'),
                        Text('• E-Prescriptions'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Free Consult Follow-Up 7 Days Post Consultation',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/booking');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA55D68),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Rectangular shape
                      ),
                    ),
                    child: const Text('BOOK NOW',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
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
                    child: const Text('CALL',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // About Doctor
            const Text(
              'About Doctor',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF174666)),
            ),
            const SizedBox(height: 8),
            const Text(
              'A Career As A Doctor Is A Clinical Professional That Involves Providing Services In Healthcare Facilities. Individuals In The Doctor’s Career Path Are Responsible For Diagnosing, Examining, And Identifying Diseases, Disorders, And Illnesses Of Patients.',
              style: TextStyle(
                  height: 1.4, fontSize: 12, color: Color(0xFF949494)),
            ),
            const SizedBox(height: 20),

            // Reviews
            const Text(
              'Reviews (23)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ReviewCard(
                    name: 'Sam Curren',
                    date: '12/12/2023',
                    rating: 5,
                    comment:
                        'Responsible For Diagnosing, Examining, Disorders, Diseases Or Patients.',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ReviewCard(
                    name: 'Sara Lemi',
                    date: '10/10/2023',
                    rating: 4.5,
                    comment:
                        'Very professional and kind. Helped me with my condition.',
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