import 'package:flutter/material.dart';
import '../widget/recommended_doctors.dart'; // Import PhysicianCard widget

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<String> dates = ['Today', 'Tomorrow', '12 June', '13 June', '14 June'];
  int selectedDateIndex = 0;

  int selectedHour = 4;
  int selectedMinute = 15;
  bool isPm = true;
  bool shareMedicalFiles = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF9FF),
        elevation: 0,
        title: const Text(
          'Schedule Physician',
          style: TextStyle(
            color: Color(0xFF1C665E),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Physician Card
                const PhysicianCard(
                  image: 'assets/images/Doctor.png',
                  name: 'Dr. Abeba Kebede',
                  specialization: 'Cardiologist',
                  rating: 4.5,
                  experience: 12,
                ),
                const SizedBox(height: 20),

                // Choose a Date Section
                const Text(
                  "Choose A Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(dates.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(dates[index]),
                          selected: selectedDateIndex == index,
                          onSelected: (val) {
                            setState(() {
                              selectedDateIndex = index;
                            });
                          },
                          selectedColor: Colors.teal,
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),

                // Time Info
                Center(
                  child: const Text(
                    "Today\n10/6/2024\n9 Slots Available\n4 PM - 6 PM",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // Pick A Time
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFEFF9FF), width: 2), // Increased border weight
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Centered the title
                    children: [
                      const Text(
                        "Pick a time",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Divider(color: Color(0xFFEFF9FF), thickness: 1),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberPicker(
                            value: selectedHour,
                            minValue: 1,
                            maxValue: 12,
                            onChanged: (value) => setState(() => selectedHour = value),
                          ),
                          const SizedBox(width: 10),
                          NumberPicker(
                            value: selectedMinute,
                            minValue: 0,
                            maxValue: 59,
                            step: 15,
                            onChanged: (value) => setState(() => selectedMinute = value),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () => setState(() => isPm = false),
                                child: Text(
                                  "AM",
                                  style: TextStyle(color: !isPm ? Colors.teal : Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () => setState(() => isPm = true),
                                child: Text(
                                  "PM",
                                  style: TextStyle(color: isPm ? Colors.teal : Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity, // Full width for the button
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA55D68), // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // Rectangular shape
                            ),
                          ),
                          child: const Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Terms and Conditions
                Center(
                  child: const Text(
                    "Terms and Conditions",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "The Document Governing The Contractual Relationship Between The Provider Of A Service And Its User. On This View, This Document Is Often Also Called “Terms Of Service” (TOS).",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                // Checkbox
                CheckboxListTile(
                  value: shareMedicalFiles,
                  onChanged: (value) => setState(() => shareMedicalFiles = value ?? false),
                  title: const Text(
                    "Share All Previous Medical Files With The Doctor",
                    style: TextStyle(color: Colors.black),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: const Color(0xFFA55D68), // Checkbox color when selected
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 10),

                // Proceed Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA55D68),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Rectangular shape
                      ),
                    ),
                    child: const Text(
                      "PROCEED",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper Widget for number picking
class NumberPicker extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final int step;
  final Function(int) onChanged;

  const NumberPicker({
    super.key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    this.step = 1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final values = List.generate(((maxValue - minValue) ~/ step + 1), (i) => minValue + i * step);

    return DropdownButton<int>(
      value: value,
      items: values.map((e) => DropdownMenuItem(child: Text(e.toString()), value: e)).toList(),
      onChanged: (val) => onChanged(val!),
    );
  }
}