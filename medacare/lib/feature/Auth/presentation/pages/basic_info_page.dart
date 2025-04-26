import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'medical_info_page.dart';

class BasicInfoPage extends StatefulWidget {
  @override
  _BasicInfoPageState createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> profileData = {}; // Store collected data here
  final TextEditingController _dateOfBirthController = TextEditingController();

  String? gender, occupation, region, city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text("Complete Your Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Basic Info", style: TextStyle(fontWeight: FontWeight.w600)),
                const Divider(),

                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(labelText: "Date of Birth (yyyy-MM-dd)"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        _dateOfBirthController.text = formattedDate;
                        profileData['dateOfBirth'] = formattedDate; // Save formatted date
                      });
                    }
                  },
                ),
                DropdownButtonFormField<String>(
                  value: gender,
                  hint: const Text("Select Gender"),
                  items: ["Male", "Female", "Other"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (value) {
                    setState(() => gender = value);
                    profileData['gender'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => profileData['contactNumber'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Emergency Contact Name"),
                  onChanged: (value) => profileData['emergencyContactName'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Emergency Contact Number"),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => profileData['emergencyContactNumber'] = value,
                ),
                DropdownButtonFormField<String>(
                  value: occupation,
                  hint: const Text("Occupation"),
                  items: ["Student", "Engineer", "Doctor", "Other"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (val) {
                    setState(() => occupation = val);
                    profileData['occupation'] = val;
                  },
                ),
                DropdownButtonFormField<String>(
                  hint: const Text("Preferred Language"),
                  items: ["English", "Amharic", "Afan Oromo"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (value) => profileData['preferredLanguage'] = value,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text("Marital Status"),
                  items: ["Single", "Married", "Divorced"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (value) => profileData['maritalStatus'] = value,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text("Region/Woreda"),
                  items: ["Addis Ababa", "Oromia", "Tigray"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (val) {
                    setState(() => region = val);
                    profileData['region'] = val;
                  },
                ),
                DropdownButtonFormField<String>(
                  hint: const Text("City/Wereda"),
                  items: ["Bole", "Lideta", "Yeka"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (val) {
                    setState(() => city = val);
                    profileData['city'] = val;
                  },
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MedicalInfoPage(profileData: profileData),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  child: const Text("NEXT", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}