// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/booking_bloc.dart';
// import 'confirmation_page.dart';

// class PaymentConfirmationPage extends StatelessWidget {
//   final int slotId;
//   const PaymentConfirmationPage({super.key, required this.slotId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Payment Confirmation')),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Have you completed the payment?',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 // Dispatch finalize event
//                 context.read<BookingBloc>().add(FinalizeBookingEvent(slotId));
//                 // Navigate to confirmation page
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ConfirmationPage(slotId: slotId),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFB94A57),
//               ),
//               child: const Text('Yes, I have paid', style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }