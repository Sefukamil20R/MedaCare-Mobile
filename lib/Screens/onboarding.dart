import 'package:flutter/material.dart';
import '/feature/Auth/presentation/pages/Signup_page.dart';

class OnBoardingall extends StatefulWidget {
  const OnBoardingall({super.key});

  @override
  State<OnBoardingall> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnBoardingall> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    OnboardingPage(
      image: 'assets/images/onboarding1.png',
      title: 'Healthcare that\nreaches you.',
      subtitle: 'Get quality care anywhere, no internet\nneeded.',
    ),
    OnboardingPage(
      image: 'assets/images/onboarding2.png',
      title: 'Your health,\nour priority.',
      subtitle: 'Access personalized care at your\nfingertips.',
    ),
    OnboardingPage(
      image: 'assets/images/onboarding3u.png',
      title: 'AI Support,\nAnytime',
      subtitle: 'Get answers to your health questions\n24/7.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/MedaCare_Gradient.png',
              fit: BoxFit.cover,
            ),
            bottom: 140,
            left: 10,
          ),

          // PageView for swiping between pages
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),

          // Page Indicator at the top
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => buildDot(index == _currentPage),
              ),
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 20,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
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
                      if (_currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignupScreen()),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(bool isActive) {
    return Container(
      height: 6,
      width: isActive ? 16 : 6,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1D586E) : Colors.grey[300],
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100), // Adjusted spacing for the page indicator
        Image.asset(
          image,
          height: 270,
          width: 270,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 50),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D586E),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}