import 'package:flutter/material.dart';
import 'dart:ui';

import '../widget/recommended_doctors.dart';
import '../widget/search_bar_widget.dart';
import 'doctors_detail.dart'; // Import the Doctor Details Page

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyData = [
      PhysicianCard(
        image: 'assets/images/Doctor.png',
        name: 'Dr. John Doe',
        specialization: 'Cardiologist',
        rating: 4.5,
        experience: 10,
      ),
      PhysicianCard(
        image: 'assets/images/Doctor.png',
        name: 'Dr. Jane Smith',
        specialization: 'Dermatologist',
        rating: 4.8,
        experience: 8,
      ),
      PhysicianCard(
        image: 'assets/images/Doctor.png',
        name: 'Dr. Jane Smith',
        specialization: 'Dermatologist',
        rating: 4.8,
        experience: 8,
      ),
      PhysicianCard(
        image: 'assets/images/Doctor.png',
        name: 'Dr. Jane Smith',
        specialization: 'Dermatologist',
        rating: 4.8,
        experience: 8,
      ),
      // Add more dummy data as needed
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF9FF),
        elevation: 0,
        title: const Text(
          'ALL Physicians',
          style: TextStyle(
            color: Color(0xFF1C665E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SearchBarWidget(),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dummyData.length,
              itemBuilder: (context, index) {
                // Wrap the PhysicianCard in a GestureDetector
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PhysicianDetailsPage(), // Navigate to Doctor Details Page
                      ),
                    );
                  },
                  child: dummyData[index],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure labels are always visible
        currentIndex: 2,
        selectedItemColor: const Color(0xFF1D586E), // Active color
        unselectedItemColor: Colors.black, // Black for unselected items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'My Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'All Doctors'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'All Hospitals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}