import 'package:flutter/material.dart';

import '../widget/recommended_doctors.dart';
import '../widget/recommended_institutions.dart';
import '../widget/search_bar_widget.dart';
import '../widget/specialties_section.dart';
import '../widget/top_greeting.dart';
import 'booking.dart';
import 'doctors_detail.dart';
import 'doctors_page.dart';
import 'institutions_page.dart';
import 'instutuitions_detal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final specialities = [
      SpecialtyCard(image: 'assets/images/specialist.png', label: 'Cardiology'),
      SpecialtyCard(image: 'assets/images/specialist.png', label: 'Dermatology'),
      SpecialtyCard(image: 'assets/images/specialist.png', label: 'Neurology'),
      SpecialtyCard(image: 'assets/images/specialist.png', label: 'Pediatrics'),
      SpecialtyCard(image: 'assets/images/specialist.png', label: 'Orthopedics'),
      SpecialtyCard(image: 'assets/images/specialist.png', label: 'Dentistry'),
      SpecialtyCard(image: 'assets/images/specialist.png', label: 'ENT'),
      SpecialtyCard(image: 'assets/images/specialist.png', label: 'Surgeon'),
    ];

    final physicians = [
      PhysicianCard(
        image: 'assets/images/Doctor.png',
        name: 'Dr. Hana Ali',
        specialization: 'Cardiologist',
        rating: 4.8,
        experience: 5,
      ),
      PhysicianCard(
        image: 'assets/images/Doctor.png',
        name: 'Dr. Eyob Mekonnen',
        specialization: 'Dermatologist',
        rating: 4.7,
        experience: 10,
      ),
      PhysicianCard(
        image: 'assets/images/Doctor.png',
        name: 'Dr. Selam Tesfaye',
        specialization: 'Neurologist',
        rating: 4.9,
        experience: 8,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: const EdgeInsets.only(top: 180), // Adjust for fixed header and search bar
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Specialties Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF1C665E), Color(0xFFA1DFD8)],
                          ).createShader(bounds),
                          child: const Text(
                            'Top Specialities',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to all specialties
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFA55D68),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: specialities,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Recommended Physicians Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF1C665E), Color(0xFFA1DFD8)],
                          ).createShader(bounds),
                          child: const Text(
                            'Recommended Physicians',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const DoctorsPage()),
                            );
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFA55D68),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: physicians,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Recommended Institutions Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF1C665E), Color(0xFFA1DFD8)],
                          ).createShader(bounds),
                          child: const Text(
                            'Recommended Institutions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const InstitutionsPage()),
                            );
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFA55D68),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200, // Increased height to avoid overflow
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16), // Add padding around the list
                      itemCount: 3, // Number of cards
                      separatorBuilder: (context, index) => const SizedBox(width: 12), // Space between cards
                      itemBuilder: (context, index) {
                        final institutions = [
                          InstitutionCard(
                            image: 'assets/images/inst.png',
                            name: 'Addis Care Hospital',
                            location: 'Addis Ababa, Ethiopia',
                          ),
                          InstitutionCard(
                            image: 'assets/images/inst.png',
                            name: 'Unity Medical Center',
                            location: 'Bole, Addis Ababa',
                          ),
                          InstitutionCard(
                            image: 'assets/images/inst.png',
                            name: 'Tikur Anbessa Hospital',
                            location: 'Piazza, Addis Ababa',
                          ),
                        ];
                        return SizedBox(
                          width: 200, // Fixed width for each card
                          child: institutions[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),

          // Fixed Header (Top Greeting and Search Bar)
          Column(
            children: [
              Container(
                color: const Color(0xFFEFF9FF),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 30), // Adjust for status bar
                child: const TopGreeting(),
              ),
              const SizedBox(height: 10), // Space between header and search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const SearchBarWidget(),
              ),
            ],
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure labels are always visible
        currentIndex: 0,
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