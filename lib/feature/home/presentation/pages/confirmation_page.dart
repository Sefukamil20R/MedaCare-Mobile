// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/booking_bloc.dart';

// class ConfirmationPage extends StatefulWidget {
//   final int slotId;

//   const ConfirmationPage({super.key, required this.slotId});

//   @override
//   State<ConfirmationPage> createState() => _ConfirmationPageState();
// }

// class _ConfirmationPageState extends State<ConfirmationPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Dispatch the FinalizeBookingEvent when the page loads
//     context.read<BookingBloc>().add(FinalizeBookingEvent(widget.slotId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Confirmation'),
//         backgroundColor: const Color(0xFFE7F5FC),
//       ),
//       body: BlocBuilder<BookingBloc, BookingState>(
//         builder: (context, state) {
//           if (state is BookingLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is BookingFinalized) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Appointment booking finalized successfully. Appointment link will be sent to your email.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context); // Go back to the previous page
//                     },
//                     child: const Text('OK'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is BookingError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     state.message,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 16, color: Colors.red),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context); // Go back to the previous page
//                     },
//                     child: const Text('OK'),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking_bloc.dart';

class ConfirmationPage extends StatefulWidget {
  final int slotId;

  const ConfirmationPage({super.key, required this.slotId});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(FinalizeBookingEvent(widget.slotId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient image
          Positioned.fill(
            child: Image.asset(
              'assets/images/MedaCare_Gradient.png',
              fit: BoxFit.cover,
            ),
          ),
          BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              if (state is BookingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BookingFinalized || state is BookingError) {
                final bool isError = state is BookingError;
                final String message = isError
                    ? (state as BookingError).message
                    : "Appointment booking finalized successfully. Appointment link will be sent to your email.";
                final IconData icon = isError ? Icons.error : Icons.check_circle;
                final Color iconColor = isError ? Colors.red : Colors.green;

                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: iconColor, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          isError ? 'Booking Failed' : 'Booking Confirmed!',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB94A57),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
