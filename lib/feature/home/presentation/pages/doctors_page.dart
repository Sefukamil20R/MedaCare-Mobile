import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widget/recommended_doctors.dart';
import '../widget/search_bar_widget.dart';
import 'doctors_detail.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch all physicians
    context.read<HomeBloc>().add(GetAllPhysiciansEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
      Navigator.pop(context, true); // Return true on system back
      return false;
    },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: const Color(0xFFEFF9FF),
        elevation: 0,
        leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Color(0xFF1C665E)),
      onPressed: () {
        Navigator.pop(context, true); // Send signal to refresh on HomePage
      },
        ),
        title: const Text(
      'All Physicians',
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
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AllPhysiciansLoaded) {
                    final physicians = state.physicians;
      
                    if (physicians.isEmpty) {
                      return const Center(child: Text('No physicians available.'));
                    }
      
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: physicians.length,
                      itemBuilder: (context, index) {
                        final physician = physicians[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhysicianDetailsPage(
                                  id: physician.id, // Pass the physician ID
                                  image: physician.profilePhotoUrl ?? 'assets/images/Doctor.png',
                                  name: '${physician.firstName} ${physician.lastName}',
                                  specialization: physician.specialization,
                                  rating: physician.rating,
                                  experience: physician.experience,
                                ),
                              ),
                            );
                          },
                          child: PhysicianCard(
                            image: physician.profilePhotoUrl ?? 'assets/images/Doctor.png',
                            name: '${physician.firstName} ${physician.lastName}',
                            specialization: physician.specialization,
                            rating: physician.rating,
                            experience: physician.experience,
                          ),
                        );
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  }
      
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 2,
          selectedItemColor: const Color(0xFF1D586E),
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'My Appointments'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'All Doctors'),
            BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'All Hospitals'),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}