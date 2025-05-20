import 'package:flutter/material.dart';
import 'app.dart';
import 'feature/Auth/data/services/auth_service.dart';
import 'injection_container.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await setupLocator();
  
  // ✅ Debugging: Check token BEFORE runApp
  final authService = sl<AuthService>();
  final token = await authService.getToken();
  print('Token at app startup: $token');
 // ✅ Ping the backend to wake it up
  await _initializeBackend();
  runApp(const MedaCareApp(initialRoute: '/splash')); 

}
Future<void> _initializeBackend() async {
  const String backendUrl = 'https://medacare-be.onrender.com/api/hello';

  try {
    print('Pinging backend at $backendUrl...');
    final response = await http.get(Uri.parse(backendUrl));

    if (response.statusCode == 200) {
      print('Backend is awake: ${response.body}');
    } else {
      print('Failed to wake up backend. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error while pinging backend: $e');
  }
}
