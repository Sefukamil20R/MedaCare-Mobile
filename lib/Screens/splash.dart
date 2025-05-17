import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    

    _navigateToNextScreen();
  }

Future<void> _navigateToNextScreen() async {
  // Simulate a delay for the splash screen
  await Future.delayed(const Duration(seconds: 10)); // Reduced delay for better UX

  // Get SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();

  // Check if it's the first launch
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    // Navigate to onboarding screens
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnBoardingall()),
    );
  } else {
    // Check if the user is logged in
    final token = prefs.getString('jwt_token'); // Use the correct key for the token

    if (token != null && token.isNotEmpty) {
      // User is logged in, navigate to the home page
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // User is not logged in, navigate to the sign-in page
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Bottom Gradient Positioned
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/MedaCare_Gradient.png',
              fit: BoxFit.cover,
              height: 350, // Adjust based on the image height
            ),
          ),

          // Centered Logo & Tagline
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/medaCare_logo.png',
                    height: 120,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your Health, Anywhere',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1D586E),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}