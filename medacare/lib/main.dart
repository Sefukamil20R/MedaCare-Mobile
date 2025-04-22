import 'package:flutter/material.dart';
import 'package:medacare/app.dart';
import 'package:medacare/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MedaCareApp(initialRoute: '/splash')); 
}