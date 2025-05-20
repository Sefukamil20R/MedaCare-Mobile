import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'app_webview_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppointmentsPage extends StatefulWidget {
  const MyAppointmentsPage({super.key});

  @override
  State<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  @override
  void initState() {
    super.initState();
    // Dispatch event to load appointments
    context.read<HomeBloc>().add(GetMyAppointmentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.pop(context, true); // <-- Return true on system back
      return false;
    },
      child: Scaffold(
       appBar: AppBar(
        title: const Text('My Appointments',  style: TextStyle(
        color: Color(0xFF1C665E),
        fontWeight: FontWeight.bold,
      ),),
        backgroundColor:  const Color(0xFFEFF9FF),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Color(0xFF1C665E)),
      onPressed: () {
        Navigator.pop(context, true); // <-- Return true to signal refresh
      },
        ),
      ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/MedaCare_Gradient.png',
                fit: BoxFit.cover,
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is MyAppointmentsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MyAppointmentsLoaded) {
                  if (state.appointments.isEmpty) {
                    return const Center(child: Text('No appointments found.', style: TextStyle(color: Color(0xFF1D586E))));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.appointments.length,
                    itemBuilder: (context, index) {
                      final appt = state.appointments[index];
                      final physician = appt['physician'];
                      final date = appt['appointmentDate'] ?? '';
                      final startTime = appt['appointmentStartTime'] ?? '';
                      final endTime = appt['appointmentEndTime'] ?? '';
                      final meetingLink = appt['meetingLink'];
                      final physicianName = '${physician?['firstName'] ?? ''} ${physician?['lastName'] ?? ''}';
      
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, color: Color(0xFF1D586E)),
                                  const SizedBox(width: 8),
                                  Text(
                                    '$date, $startTime - $endTime',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1D586E),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.person, color: Color(0xFFA55D68)),
                                  const SizedBox(width: 8),
                                  Text(
                                    physicianName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF1D586E),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if (meetingLink != null && meetingLink.toString().isNotEmpty)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFA55D68),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    icon: const Icon(Icons.link, color: Colors.white),
                                    label: const Text('Join Meeting', style: TextStyle(color: Colors.white)),
                                  onPressed: () async {
  final uri = Uri.parse(meetingLink);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // This opens in the default browser
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open meeting link')),
    );
  }
},
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is MyAppointmentsError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}