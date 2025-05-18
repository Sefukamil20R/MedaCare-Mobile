import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../bloc/booking_bloc.dart';
import '../widget/recommended_doctors.dart';
import '../widget/reviewcard.dart';
import 'booking.dart';

class PhysicianDetailsPage extends StatelessWidget {
  final String image;
  final String name;
  final String specialization;
  final double rating;
  final int experience;
  final int id; // Add the physician ID


  const PhysicianDetailsPage({
    super.key,
    required this.id, // Initialize the physician ID
    required this.image,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
  });

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
            PhysicianCard(
              image: image,
              name: name,
              specialization: specialization,
              rating: rating,
              experience: experience,
            ),
            const SizedBox(height: 16),
            
      BlocConsumer<BookingBloc, BookingState>(
  listener: (context, state) {
    if (state is RatingSubmitted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your rating!')),
      );
    } else if (state is RatingError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit rating: ${state.message}')),
      );
    }
  },
  builder: (context, state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rate this physician:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            context.read<BookingBloc>().add(
              SubmitRatingEvent(physicianId: id, rating: rating.toInt()),
            );
          },
        ),
        if (state is RatingSubmitting)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: LinearProgressIndicator(),
          ),
      ],
    );
  },
),
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
                        Text('• General Health Check-Ins' , 
                            style: TextStyle(
                                 color: Colors.lightBlue,
)),
                        Text('• Chronic Condition Management' ,  style: TextStyle(
                                 color: Colors.lightBlue,
)),
                        Text('• E-Prescriptions' ,  style: TextStyle(
                                 color: Colors.lightBlue,
)),
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
                   // doctors_detail.dart
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookingPage(
        physicianId: id,
        image: image,
        name: name,
        specialization: specialization,
        rating: rating,
        experience: experience,
      ),
    ),
  );
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