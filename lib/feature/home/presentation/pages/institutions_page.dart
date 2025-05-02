import 'package:flutter/material.dart';
import '../widget/recommended_institutions.dart'; // Import InstitutionCard widget
import '../widget/search_bar_widget.dart';
import 'instutuitions_detal.dart'; // Import Institution Details Page

class InstitutionsPage extends StatelessWidget {
  const InstitutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyData = [
      InstitutionCard(
        image: 'assets/images/inst.png',
        name: 'MedaCare International Hospital',
        specialization: 'Multi Super Specialty Hospital',
        location: 'Addis Ababa, Ethiopia',
      ),
      InstitutionCard(
        image: 'assets/images/inst.png',
        name: 'Unity Medical Center',
        specialization: 'General Hospital',
        location: 'Bole, Addis Ababa',
      ),
      InstitutionCard(
        image: 'assets/images/inst.png',
        name: 'Tikur Anbessa Hospital',
        specialization: 'Teaching Hospital',
        location: 'Piazza, Addis Ababa',
      ),
       InstitutionCard(
        image: 'assets/images/inst.png',
        name: 'Tikur Anbessa Hospital',
        specialization: 'Teaching Hospital',
        location: 'Piazza, Addis Ababa',
      ),
      // Add more dummy data as needed
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF9FF),
        elevation: 0,
        title: const Text(
          'All Institutions',
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
                // Wrap the InstitutionCard in a GestureDetector
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InstitutionDetailsPage(), // Navigate to Institution Details Page
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
        currentIndex: 3,
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