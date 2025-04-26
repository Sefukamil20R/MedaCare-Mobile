import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_bloc.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_event.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_state.dart';

class MedicalInfoPage extends StatelessWidget {
  final Map<String, dynamic> profileData; // Receive data from BasicInfoPage

  MedicalInfoPage({required this.profileData});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfileCompletionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile completed successfully!")),
          );
          Navigator.pop(context); // Navigate back or to another page
        } else if (state is ProfileCompletionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Complete Your Profile",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Medical Info", style: TextStyle(fontWeight: FontWeight.w600)),
                  const Divider(),

                  DropdownButtonFormField<String>(
                    hint: const Text("Blood Type"),
                    items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+"]
                        .map((e) => DropdownMenuItem(child: Text(e), value: e))
                        .toList(),
                    onChanged: (value) => profileData['bloodType'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Height (in meters)"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => profileData['heightInMeters'] = double.tryParse(value),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Weight (in kg)"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => profileData['weightInKg'] = double.tryParse(value),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Allergies"),
                    onChanged: (value) => profileData['allergies'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Medications"),
                    onChanged: (value) => profileData['medications'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Past Diagnosis",
                      hintText: "Write short descriptions of your diagnosis here...",
                    ),
                    maxLines: 3,
                    onChanged: (value) => profileData['pastDiagnosis'] = value,
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Dispatch the event to complete the profile
                        context.read<AuthBloc>().add(CompletePatientProfileEvent(profileData));
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                    child: const Text("COMPLETE", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}