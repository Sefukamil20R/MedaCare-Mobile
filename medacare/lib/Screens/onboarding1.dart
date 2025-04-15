import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medacare/Screens/onboarding2.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDot(true),
                const SizedBox(width: 6),
                buildDot(false),
              ],
            ),

            const SizedBox(height: 140),

            // Blob image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                'assets/images/onboarding1.png',
                height: 250,
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
const SizedBox(height: 120),

            // Headline
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),

              child: Text(
                'Healthcare that\nreaches you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D586E), // Primary Teal
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Get quality care anywhere, no internet\nneeded.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Bottom Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreenTwo()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
