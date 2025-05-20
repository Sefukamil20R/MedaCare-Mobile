import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widget/recommended_institutions.dart';
import '../widget/search_bar_widget.dart';
import 'instutuitions_detal.dart';

class InstitutionsPage extends StatefulWidget {
  const InstitutionsPage({super.key});

  @override
  _InstitutionsPageState createState() => _InstitutionsPageState();
}

class _InstitutionsPageState extends State<InstitutionsPage> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch all institutions
    context.read<HomeBloc>().add(GetAllInstitutionsEvent());
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
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AllInstitutionsLoaded) {
                    final institutions = state.institutions;
      
                    if (institutions.isEmpty) {
                      return const Center(child: Text('No institutions available.'));
                    }
      
                    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: institutions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 25), // 16 pixels vertical space
        itemBuilder: (context, index) {
      final institution = institutions[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InstitutionDetailsPage(
                image: institution.companyLogo ?? 'assets/images/inst.png',
                name: institution.name,
                specialization: institution.offeredSpecializations,
                location: '${institution.subCityOrDistrict}, ${institution.regionOrState}',
              ),
            ),
          );
        },
        child: InstitutionCard(
          image: institution.companyLogo ?? 'assets/images/inst.png',
          name: institution.name,
          specialization: institution.offeredSpecializations ?? '',
          location: '${institution.subCityOrDistrict ?? ''}, ${institution.regionOrState ?? ''}',
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
          currentIndex: 3,
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