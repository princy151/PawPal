import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/splash/presentation/view_model/onboarding_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                _currentPage.value = index;
              },
              children: [
                _buildOnboardingPage(
                  title: 'Welcome to PawPal',
                  description:
                      'Your ultimate companion for managing pet care, sitters, and reminders!',
                  imagePath: 'assets/images/onboarding1.png',
                ),
                _buildOnboardingPage(
                  title: 'Track Your Pets',
                  description:
                      'Easily add, monitor, and manage your pets’ profiles and care schedules.',
                  imagePath: 'assets/images/onboarding2.png',
                ),
                _buildOnboardingPage(
                  title: 'Find Sitters',
                  description:
                      'Browse experienced pet sitters and connect with the best match for your pet.',
                  imagePath: 'assets/images/onboarding3.png',
                ),
                _buildOnboardingPage(
                  title: 'Stay Connected',
                  description:
                      'Chat with sitters, receive notifications, and manage your appointments seamlessly.',
                  imagePath: 'assets/images/onboarding4.png',
                ),
              ],
            ),
          ),
          _buildBottomNavigation(context),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 250,
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB55C50),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              context.read<OnboardingCubit>().goToLogin(context);
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: Color(0xFFB55C50)),
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (context, currentPage, _) {
              return Row(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: currentPage == index
                          ? const Color(0xFFB55C50)
                          : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
          ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (context, currentPage, _) {
              return IconButton(
                onPressed: () {
                  if (currentPage == 3) {
                    // Navigate to login on the last page
                    context.read<OnboardingCubit>().goToLogin(context);
                  } else {
                    // Move to the next page
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                icon: Icon(
                  currentPage == 3
                      ? Icons.check // Show "check" icon on the last page
                      : Icons.arrow_forward,
                  color: const Color(0xFFB55C50),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
