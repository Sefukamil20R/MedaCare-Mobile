import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false); // Set first launch to false

    // Navigate to the sign-in screen
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children:[
          Positioned.fill(
            child: Image.asset(
              'assets/images/MedaCare_Gradient.png',
              fit: BoxFit.cover,
            ),
            bottom: 140,
          ),
           SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
        
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDot(false),
                  const SizedBox(width: 6),
                  buildDot(false),
                  const SizedBox(width: 6),
                  buildDot(true),
                ],
              ),
        
              const SizedBox(height: 140),
        
              // Blob image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/images/onboarding3u.png',
                  height: 250,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
        
  const SizedBox(height: 50),
                const Spacer(),        
              // Headline
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'For Every\nCommunity',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D586E), // Primary Teal
                  ),
                ),
              ),
        
              const SizedBox(height: 12),
        
              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Designed for rural Ethiopia in your language, for your needs.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
        
  const SizedBox(height: 50),
                const Spacer(),        
              // Bottom Controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      // onTap: () => _completeOnboarding(context),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF9D5B66),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Navigate to the sign-in screen
                          // Navigator.pushReplacementNamed(context, '/signin');
                         _completeOnboarding(context);

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }

  Widget buildDot(bool isActive) {
    return Container(
      height: 6,
      width: isActive ? 16 : 6,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1D586E) : Colors.grey[300],
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}