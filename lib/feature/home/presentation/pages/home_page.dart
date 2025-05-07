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
      SpecialtyCard(image: 'assets/images/general.png', label: 'Cardiology'),
      SpecialtyCard(image: 'assets/images/Naphrologist.png', label: 'Naphrologist'),
      SpecialtyCard(image: 'assets/images/Cardiology.png', label: 'Cardiology'),
      SpecialtyCard(image: 'assets/images/Neurologist.png', label: 'Neurologist'),
      SpecialtyCard(image: 'assets/images/Dentist.png', label: 'Dentist'),
      SpecialtyCard(image: 'assets/images/Gynecologist.png', label: 'Gynecologist'),
      SpecialtyCard(image: 'assets/images/Pediatrician.png', label: 'Pediatrician'),
      SpecialtyCard(image: 'assets/images/surgeon.png', label: 'Surgeon'),
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
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
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
                          onTap: () {},
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
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 3,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
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
                          width: 200,
                          child: institutions[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 80), // Extra space so AI button doesn't overlap
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                color: const Color(0xFFEFF9FF),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 30),
                child: const TopGreeting(),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SearchBarWidget(),
              ),
            ],
          ),
          // AI Floating Button (Positioned above bottom nav)
          Positioned(
            bottom: 1, // distance from bottom of screen
            right: 16,  // distance from right side
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/ai_back.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/images/ai_icon.png'),
                    onPressed: () {
                      // Handle AI button action
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        color: Colors.white,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          selectedItemColor: const Color(0xFF1D586E),
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'My Appointments'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'All Doctors'),
            BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'All Hospitals'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
