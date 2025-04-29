import 'package:flutter/material.dart';

import '../feature/Auth/presentation/pages/Signup_page.dart';
import 'onboarding3.dart';


class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
                  buildDot(true),
                ],
              ),
        
              const SizedBox(height: 140),
        
              // Blob image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/images/onboarding2.png', 
                  height: 270,
                ),
              ),
        
                const SizedBox(height: 50),
                const Spacer(),
        
              // Headline
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'AI Support,\nAnytime',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172635), 
                  ),
                ),
              ),
        
              const SizedBox(height: 12),
        
              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Our AI assistant helps you manage your\nhealth, offline or online.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8E8E8E), 
                  ),
                ),
              ),
        
                const Spacer(),        
              // Bottom Controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                      },
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
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Navigate to the next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OnboardingScreenThree(), 
                            ),
                          );
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
        color: isActive ? Color(0xFF1D586E) : Colors.grey[300],
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
