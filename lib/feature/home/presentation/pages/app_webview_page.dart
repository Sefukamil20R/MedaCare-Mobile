import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebViewPage extends StatelessWidget {
  final String url;
  final String? title;
  const AppWebViewPage({super.key, required this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    title ?? 'WebView',
    style: const TextStyle(
      color: Color(0xFF1C665E),
      fontWeight: FontWeight.bold,
    ),
  ),
  backgroundColor: const Color(0xFFEFF9FF),
  foregroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Color(0xFF1C665E), // <-- Set back button color here
  ),
),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url)),
      ),
    );
  }
}