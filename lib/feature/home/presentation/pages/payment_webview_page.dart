
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'confirmation_page.dart'; // Import the confirmation page

class PaymentWebViewPage extends StatelessWidget {
  final String paymentUrl;
  final int slotId; // Pass the slot ID to finalize the booking

  const PaymentWebViewPage({super.key, required this.paymentUrl, required this.slotId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Payment' , style: TextStyle(
      color: Color(0xFF1C665E),
      fontWeight: FontWeight.bold,
    ),),
        backgroundColor: const Color(0xFFE7F5FC),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the confirmation page when the back button is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmationPage(slotId: slotId),
              ),
            );
          },
        ),
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(paymentUrl)),
      ),
    );
  }
}