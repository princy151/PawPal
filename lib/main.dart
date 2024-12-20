import 'package:flutter/material.dart';
import 'package:pawpal/core/app_theme/app_theme.dart';
import 'package:pawpal/core/common/splash_screen.dart';
import 'package:pawpal/view/login_view.dart';
import 'package:pawpal/view/onboarding_view.dart';
import 'package:pawpal/view/pet_owner_dashboard_view.dart';
import 'package:pawpal/view/pet_sitter_dashboard_view.dart';
import 'package:pawpal/view/registration_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: getApplicationTheme(),
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboard': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegistrationView(),
        '/petsitter': (context) => const PetSitterDashboardView(),
        '/petowner': (context) => const PetOwnerDashboardView(),
      },
    );
  }
}
