import 'package:flutter/material.dart';

class PetOwnerDashboardView extends StatefulWidget {
  const PetOwnerDashboardView({super.key});

  @override
  State<PetOwnerDashboardView> createState() => _PetOwnerDashboardViewState();
}

class _PetOwnerDashboardViewState extends State<PetOwnerDashboardView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Pet Owner dashboard'),
    );
  }
}
