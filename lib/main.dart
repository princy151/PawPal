import 'package:flutter/material.dart';
import 'package:pawpal/view/login_view.dart';
import 'package:pawpal/view/pet_owner_dashboard_view.dart';
import 'package:pawpal/view/pet_sitter_dashboard_view.dart';
import 'package:pawpal/view/registration_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegistrationView(),
        '/petsitter': (context) => const PetSitterDashboardView(),
        '/petowner': (context) => const PetOwnerDashboardView(),
      },
    );
  }
}
