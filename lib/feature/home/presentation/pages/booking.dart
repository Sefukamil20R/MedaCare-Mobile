// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/booking_bloc.dart';
// import 'payment_webview_page.dart'; // Import your WebView page

// class BookingPage extends StatefulWidget {
//   final int physicianId;

//   const BookingPage({super.key, required this.physicianId});

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   String? selectedDate;
//   int? selectedDuration;
//   int? selectedSlotId;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<BookingBloc>().add(FetchAvailableDatesEvent(widget.physicianId));
//     });
//   }

//   void _fetchAvailableSlots() {
//     if (selectedDate != null && selectedDuration != null) {
//       context.read<BookingBloc>().add(
//             FetchAvailableSlotsEvent(
//               widget.physicianId,
//               selectedDate!,
//               selectedDuration!,
//             ),
//           );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE7F5FC),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFE7F5FC),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Schedule Physician',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: BlocBuilder<BookingBloc, BookingState>(
//         builder: (context, state) {
//           if (state is BookingLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is AvailableDatesLoaded) {
//             return _buildBookingContent(context, state.dates, null, null);
//           } else if (state is AvailableSlotsLoaded) {
//             return _buildBookingContent(context, null, state.slots, null);
//           } else if (state is PaymentUrlLoaded) {
//             // Navigate to WebView automatically
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => PaymentWebViewPage(paymentUrl: state.paymentUrl, slotId: selectedSlotId!),
//                 ),
//               );
//             });
//             return const Center(child: Text("Redirecting to payment..."));
//           } else if (state is BookingError) {
//             return Center(child: Text(state.message));
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   Widget _buildBookingContent(
//     BuildContext context,
//     List<String>? availableDates,
//     List<Map<String, dynamic>>? slots,
//     String? _,
//   ) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (availableDates != null) ...[
//             const Text('Choose A Date'),
//             const SizedBox(height: 8),
//             SizedBox(
//               height: 40,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: availableDates.length,
//                 itemBuilder: (context, index) {
//                   final date = availableDates[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: ChoiceChip(
//                       label: Text(date),
//                       selected: selectedDate == date,
//                       onSelected: (selected) {
//                         setState(() {
//                           selectedDate = date;
//                           selectedDuration = null;
//                           selectedSlotId = null;
//                         });
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],

//           if (selectedDate != null) ...[
//             const Text('Choose Duration'),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: selectedDuration == 30 ? Colors.blue : Colors.grey,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.white,
//                     ),
//                     child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           selectedDuration = 30;
//                           _fetchAvailableSlots();
//                         });
//                       },
//                       child: const Text(
//                         '30 Min\nQuick Consultation',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: selectedDuration == 60 ? Colors.blue : Colors.grey,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.white,
//                     ),
//                     child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           selectedDuration = 60;
//                           _fetchAvailableSlots();
//                         });
//                       },
//                       child: const Text(
//                         '60 Min\nStandard Consultation',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//           ],

//           if (slots != null) ...[
//             const Text('Select A Time Slot'),
//             const SizedBox(height: 8),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: slots.length,
//               itemBuilder: (context, index) {
//                 final slot = slots[index];
//                 return ListTile(
//                   title: Text('${slot['startTime']} - ${slot['endTime']}'),
//                   selected: selectedSlotId == slot['id'],
//                   onTap: () {
//                     setState(() {
//                       selectedSlotId = slot['id'];
//                     });
//                   },
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//           ],

//           if (selectedSlotId != null) ...[
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   context.read<BookingBloc>().add(BookSlotEvent(selectedSlotId!));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF8C2F39),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//                 child: const Text(
//                   'PROCEED',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking_bloc.dart';
import 'payment_webview_page.dart';

class BookingPage extends StatefulWidget {
  final int physicianId;

  const BookingPage({super.key, required this.physicianId});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? selectedDate;
  int? selectedDuration;
  int? selectedSlotId;

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
      backgroundColor: const Color(0xFFE7F5FC),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/Doctor.png'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Dr Abeba Kebede',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('MBBS, MD', style: TextStyle(fontSize: 12)),
                      Text('Cardiologist', style: TextStyle(fontSize: 12)),
                      Text('42 Year Experience', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.star, color: Colors.amber),
                const Text('4.5'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Choose a Date Section
          if (availableDates != null) ...[
            const Text('Choose A Date'),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableDates.length,
                itemBuilder: (context, index) {
                  final date = availableDates[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(date),
                      selected: selectedDate == date,
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
            const Text('Choose Duration'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedDuration == 30 ? Colors.blue : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
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
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedDuration == 60 ? Colors.blue : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '$selectedDate | $selectedDuration Min | $availableSlotCount Slots Available',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Select A Time Slot'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF38AAD4)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: slots.length,
                itemBuilder: (context, index) {
                  final slot = slots[index];
                  return ListTile(
                    title: Text('${slot['startTime']} - ${slot['endTime']}'),
                    selected: selectedSlotId == slot['id'],
                    onTap: () {
                      setState(() {
                        selectedSlotId = slot['id'];
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Proceed Button
          if (selectedSlotId != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<BookingBloc>().add(BookSlotEvent(selectedSlotId!));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8C2F39),
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