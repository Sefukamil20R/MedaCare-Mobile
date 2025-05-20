import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/errors/utility.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../home/presentation/pages/home_page.dart';


class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  int currentStep = 0;
  final Map<String, dynamic> profileData = {}; // Store collected data here
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>(); // Add form validation

  final List<String> genders = ['Male', 'Female'];
  final List<String> languages = ['Amharic', 'Afan Oromo', 'Tigrigna', 'English'];
  final List<String> regions = ['Addis Ababa', 'Oromia', 'Amhara', 'Tigray', 'SNNP', 'Afar', 'Benishangul-Gumuz'];
  final List<String> maritalStatusOptions = ['Single', 'Married', 'Divorced', 'Widowed'];
  final List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfileCompletionSuccess) {
          showCustomSnackBar(
      context,
      "Profile completed successfully!",
      Colors.green,
    );
            context.read<AuthBloc>().add(GetUserProfileEvent());

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(), 
            ),
          );
        } else if (state is ProfileCompletionError) {
          showCustomSnackBar(
      context,
      state.message,
      Colors.red,
    );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey, // Wrap the form with a GlobalKey for validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Complete Your Profile',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D586E), // Title color
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      stepIndicator('Basic Info', currentStep >= 0),
                      const SizedBox(width: 16),
                      stepIndicator('Medical Info', currentStep >= 1),
                    ],
                  ),
                  const SizedBox(height: 24),
                  currentStep == 0 ? buildBasicInfoForm() : buildMedicalInfoForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget stepIndicator(String label, bool completed) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: completed ? Colors.green : Colors.black),
        ),
        if (completed)
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20,
          ),
      ],
    );
  }

  Widget buildBasicInfoForm() {
    return Column(
      children: [
        buildDateField(
          label: 'Date of Birth',
          hint: '2024-04-20',
          onChanged: (value) {
            profileData['dateOfBirth'] = value;
            _formKey.currentState!.validate(); // Revalidate the form dynamically
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your date of birth';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        buildDropdownField('Gender', genders, 'gender', 'Please select your gender'),
        const SizedBox(height: 16),
        IntlPhoneField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
          initialCountryCode: 'ET',
          onChanged: (phone) {
            profileData['contactNumber'] = phone.completeNumber;
            _formKey.currentState!.validate(); // Revalidate the form dynamically
          },
        ),
        const SizedBox(height: 16),
        buildTextField(
          label: 'Emergency Contact Name',
          hint: 'John Doe',
          onChanged: (value) {
            profileData['emergencyContactName'] = value;
            _formKey.currentState!.validate(); // Revalidate the form dynamically
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an emergency contact name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        IntlPhoneField(
          decoration: const InputDecoration(
            labelText: 'Emergency Contact Number',
            border: OutlineInputBorder(),
          ),
          initialCountryCode: 'ET',
          onChanged: (phone) {
            profileData['emergencyContactNumber'] = phone.completeNumber;
            _formKey.currentState!.validate(); // Revalidate the form dynamically
          },
        ),
        const SizedBox(height: 16),
        buildDropdownField('Preferred Language', languages, 'preferredLanguage', 'Please select a language'),
        const SizedBox(height: 16),
        buildDropdownField('Marital Status', maritalStatusOptions, 'maritalStatus', 'Please select your marital status'),
        const SizedBox(height: 16),
        buildDropdownField('Region/State', regions, 'region', 'Please select your region/state'),
        const SizedBox(height: 16),
        buildTextField(
          label: 'City/District',
          hint: 'City Name',
          onChanged: (value) {
            profileData['city'] = value;
            _formKey.currentState!.validate(); // Revalidate the form dynamically
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your city/district';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        buildTextField(
          label: 'Subcity',
          hint: 'Subcity Name',
          onChanged: (value) {
            profileData['subCity'] = value;
            _formKey.currentState!.validate(); // Revalidate the form dynamically
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your subcity';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA55D68),
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                currentStep = 1;
                _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
              });
            }
          },
          child: const Text(
            'NEXT',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildMedicalInfoForm() {
    return Column(
      children: [
        buildDropdownField('Blood Type', bloodTypes, 'bloodType', 'Please select your blood type'),
        const SizedBox(height: 16),
        buildTextField(
          label: 'Height (meters)',
          hint: '1.70',
          onChanged: (value) {
            profileData['heightInMeters'] = double.tryParse(value);
            _formKey.currentState!.validate(); // Revalidate the form dynamically
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your height';
            }
            final height = double.tryParse(value);
            if (height == null || height < 0.5 || height > 2.5) {
              return 'Please enter a valid height between 0.5 and 2.5 meters';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        buildTextField(
          label: 'Weight (kg)',
          hint: '70',
          onChanged: (value) {
            profileData['weightInKg'] = double.tryParse(value);
            _formKey.currentState!.validate(); // Revalidate the form dynamically
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your weight';
            }
            final weight = double.tryParse(value);
            if (weight == null || weight <= 0) {
              return 'Please enter a valid weight';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        buildTextField(
          label: 'Allergies (if any)',
          hint: 'Peanuts, penicillin',
          onChanged: (value) => profileData['allergies'] = value,
        ),
        const SizedBox(height: 16),
        buildTextField(
          label: 'Medical History',
          hint: 'List previous illnesses',
          onChanged: (value) => profileData['medicalHistory'] = value,
        ),
        const SizedBox(height: 16),
        buildTextField(
          label: 'Past Diagnosis',
          hint: 'Write a detailed description...',
          onChanged: (value) => profileData['pastDiagnosis'] = value,
          maxLines: 5,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA55D68),
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(CompletePatientProfileEvent(profileData));
            }
          },
          child: const Text(
            'COMPLETE',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        onChanged(value);
        _formKey.currentState!.validate(); // Revalidate the form dynamically
      },
      validator: validator,
      maxLines: maxLines,
    );
  }

  Widget buildDropdownField(String label, List<String> options, String key, String errorMessage) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: options.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        profileData[key] = newValue;
        _formKey.currentState!.validate(); // Revalidate the form dynamically
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  Widget buildDateField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    final TextEditingController _dateController = TextEditingController();
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              _dateController.text = formattedDate;
              onChanged(formattedDate);
            }
          },
        ),
      ),
      onChanged: (value) {
        onChanged(value);
        _formKey.currentState!.validate(); // Revalidate the form dynamically
      },
      validator: validator,
    );
  }
}