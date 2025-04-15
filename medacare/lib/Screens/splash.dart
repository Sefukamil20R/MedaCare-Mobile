import 'package:flutter/material.dart';
import 'package:medacare/Screens/onboarding1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 10 seconds and navigate to the next screen
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()), 
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              // Logo Image
              Image.asset(
                'assets/images/medaCare_logo.png',
                height: 120, 
              ),
              const SizedBox(height: 20),

              // Tagline
              const Text(
                'Your Health, Anywhere',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1D586E), // Teal
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}