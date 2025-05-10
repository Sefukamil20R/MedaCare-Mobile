import 'package:flutter/material.dart';
import 'app.dart';
import 'feature/Auth/data/services/auth_service.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  // ✅ Debugging: Check token BEFORE runApp
  final authService = sl<AuthService>();
  final token = await authService.getToken();
  print('Token at app startup: $token');

  runApp(const MedaCareApp(initialRoute: '/splash')); 
}
