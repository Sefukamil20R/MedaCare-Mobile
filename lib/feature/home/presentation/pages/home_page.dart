import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-dispatch events to fetch recommended physicians and institutions
    context.read<HomeBloc>().add(GetRecommendedPhysiciansEvent());
    context.read<HomeBloc>().add(GetRecommendedInstitutionsEvent());
  }

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

                  // Combined BlocBuilder for Recommended Physicians and Institutions
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      print('Home State: $state'); // Debugging log

                      if (state is HomeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is HomeCombinedLoaded) {
                        final recommendedPhysicians = state.recommendedPhysicians ?? [];
                        final recommendedInstitutions = state.recommendedInstitutions ?? [];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Recommended Physicians Section
                            if (recommendedPhysicians.isNotEmpty) ...[
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
                                      onTap: () async {
  final shouldRefresh = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DoctorsPage()),
  );

  if (shouldRefresh == true) {
    context.read<HomeBloc>().add(GetRecommendedPhysiciansEvent());
    context.read<HomeBloc>().add(GetRecommendedInstitutionsEvent());
  }
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
                                  children: recommendedPhysicians.map((physician) {
                                    print('Displaying Physician: ${physician.firstName} ${physician.lastName}'); // Debugging log
                                    return PhysicianCard(
                                      image: physician.profilePhotoUrl ?? 'assets/images/Doctor.png',
                                      name: '${physician.firstName} ${physician.lastName}',
                                      specialization: physician.specialization,
                                      rating: physician.rating,
                                      experience: physician.experience,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],

                            // Recommended Institutions Section
                            if (recommendedInstitutions.isNotEmpty) ...[
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
                                      onTap: () async {
  final shouldRefresh = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const InstitutionsPage()),
  );

  if (shouldRefresh == true) {
    context.read<HomeBloc>().add(GetRecommendedPhysiciansEvent());
    context.read<HomeBloc>().add(GetRecommendedInstitutionsEvent());
  }
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
                                  itemCount: recommendedInstitutions.length,
                                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    final institution = recommendedInstitutions[index];
                                    return SizedBox(
                                      width: 200,
                                      child: InstitutionCard(
                                        image: institution.companyLogo ?? 'assets/images/inst.png',
                                        name: institution.name,
                                        location: '${institution.subCityOrDistrict}, ${institution.regionOrState}',
                                        specialization: institution.offeredSpecializations,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ],
                        );
                      } else if (state is HomeError) {
                        return Center(child: Text(state.message));
                      }

                      return const SizedBox.shrink();
                    },
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
            right: 16, // distance from right side
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