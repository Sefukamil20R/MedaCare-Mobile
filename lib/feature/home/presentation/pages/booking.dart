
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking_bloc.dart';
import '../widget/recommended_doctors.dart';
import 'payment_webview_page.dart';

class BookingPage extends StatefulWidget {
  final int physicianId;
  final String image;
  final String name;
  final String specialization;
  final double rating;
  final int experience;

 const BookingPage({
    super.key,
    required this.physicianId,
    required this.image,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? selectedDate;
  int? selectedDuration;
  int? selectedSlotId;
  bool termsAccepted = false;
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingBloc>().add(FetchAvailableDatesEvent(widget.physicianId));
    });
  }

  void _fetchAvailableSlots() {
    if (selectedDate != null && selectedDuration != null) {
      context.read<BookingBloc>().add(
            FetchAvailableSlotsEvent(
              widget.physicianId,
              selectedDate!,
              selectedDuration!,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7F5FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Schedule Physician',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AvailableDatesLoaded) {
            return _buildBookingContent(context, state.dates, null, null);
          } else if (state is AvailableSlotsLoaded) {
            return _buildBookingContent(context, null, state.slots, null);
          } else if (state is PaymentUrlLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentWebViewPage(paymentUrl: state.paymentUrl, slotId: selectedSlotId!),
                ),
              );
            });
            return const Center(child: Text("Redirecting to payment..."));
          } else if (state is BookingError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBookingContent(
    BuildContext context,
    List<String>? availableDates,
    List<Map<String, dynamic>>? slots,
    String? _,
  ) {
    final int availableSlotCount = slots?.length ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Info Section
        // ...existing code...
PhysicianCard(
  image: widget.image,
  name: widget.name,
  specialization: widget.specialization,
  rating: widget.rating,
  experience: widget.experience,
),
// ...existing code...
          const SizedBox(height: 16),

          // Choose a Date Section
      // ...existing code...

// Choose a Date Section
if (availableDates != null) ...[
  const Text(
    'Choose A Date',
    style: TextStyle(
      color: Color(0xFF1D586E),
      fontWeight: FontWeight.bold,
    ),
  ),
  const SizedBox(height: 8),
  SizedBox(
    height: 40,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: availableDates.length,
      itemBuilder: (context, index) {
        final date = availableDates[index];
        final isSelected = selectedDate == date;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(
              date,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: isSelected,
            selectedColor: const Color(0xFFEFF9FF),
            backgroundColor: Colors.white,
            shape: StadiumBorder(
              side: BorderSide(
                color: const Color(0xFF1D586E),
                width: 1.5,
              ),
            ),
            onSelected: (selected) {
              setState(() {
                selectedDate = date;
                selectedDuration = null;
                selectedSlotId = null;
              });
            },
          ),
        );
      },
    ),
  ),
  const SizedBox(height: 16),
],

// Choose Duration Section
if (selectedDate != null) ...[
  const Text('Choose Duration', style: TextStyle(
      color: Color(0xFF1D586E),
      fontWeight: FontWeight.bold,)),
  const SizedBox(height: 8),
  Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF1D586E),
            ),
            borderRadius: BorderRadius.circular(12),
            color: selectedDuration == 30 ? const Color(0xFFEFF9FF) : Colors.white,
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                selectedDuration = 30;
                _fetchAvailableSlots();
              });
            },
            child: const Text(
              '30 Min\nQuick Consultation',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF1D586E),
            ),
            borderRadius: BorderRadius.circular(12),
            color: selectedDuration == 60 ? const Color(0xFFEFF9FF) : Colors.white,
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                selectedDuration = 60;
                _fetchAvailableSlots();
              });
            },
            child: const Text(
              '60 Min\nStandard Consultation',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    ],
  ),
  const SizedBox(height: 16),
],

// Available Slots Section
if (slots != null) ...[
  Container(
  width: double.infinity,
  height: 90,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Color(0xFFF5F5F5),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        selectedDate ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
                    color: Color(0xFF2A7FBA),

        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        '$availableSlotCount Slots Available',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Color(0xFF2A7FBA),
        ),
        textAlign: TextAlign.center,
      ),
    ],
  ),
),
  const SizedBox(height: 16),
  const Text('Select A Time Slot', style: TextStyle(
      color: Color(0xFF1D586E),
      fontWeight: FontWeight.bold,)),
  const SizedBox(height: 8),
  Container(
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF1D586E)),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    constraints: const BoxConstraints(maxHeight: 200),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isSelected = selectedSlotId == slot['id'];
        return Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEFF9FF) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFF1D586E).withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              '${slot['startTime']} - ${slot['endTime']}',
              style: const TextStyle(color: Colors.black),
            ),
            selected: isSelected,
            selectedTileColor: const Color(0xFFEFF9FF),
            onTap: () {
              setState(() {
                selectedSlotId = slot['id'];
              });
            },
          ),
        );
      },
    ),
  ),
  const SizedBox(height: 16),
],
// ...existing code...

          // Proceed Button
          if (selectedSlotId != null) ...[
  const SizedBox(height: 16),
  Column(
  crossAxisAlignment: CrossAxisAlignment.center,

    children: [
      const Text(
        'Terms And Conditions',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      const Text(
        'The document governing the contractual relationship between the provider of a service and its user. On the web, this document is often also called “Terms of Service” (ToS).',
        style: TextStyle(fontSize: 10, color: Colors.grey),
      ),
    ],
  ),
  const SizedBox(height: 8),
  Row(
    children: [
      Checkbox(
        value: termsAccepted,
         fillColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xFFA55D68); // Your custom color when checked
      }
      return Colors.grey; // Default color when unchecked
    },
  ),
        
        onChanged: (val) {
          setState(() {
            termsAccepted = val ?? false;
          });
        },
      ),
      const Expanded(
        child: Text(
          'Share All Previous Medical Files With The Doctor',
          style: TextStyle(fontSize: 12),
        ),
      )
    ],
  ),
  if (termsAccepted)
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<BookingBloc>().add(BookSlotEvent(selectedSlotId!));
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Color(0xFFA55D68),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'PROCEED',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
],
        ],
      ),
    );
  }
}