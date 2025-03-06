import 'dart:math'; // To use sqrt for magnitude calculation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/core/common/my_snackbar.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_home_cubit.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_home_state.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Import the sensors_plus package

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final bool _isDarkTheme = false;
  final double _shakeThreshold = 15.0; // Shake threshold
  final List<double> _accelerometerValues = []; // To hold accelerometer values

  @override
  void initState() {
    super.initState();
    // Listen for user accelerometer changes
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      // Calculate the magnitude of the acceleration
      double magnitude =
          sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));

      // If the magnitude exceeds the threshold, trigger logout
      if (magnitude > _shakeThreshold) {
        _onShake();
      }
    });
  }

  void _onShake() {
    // Handle the shake event to trigger logout
    showMySnackBar(
      context: context,
      message: 'Logging out...',
      color: Colors.red,
    );
    context.read<OwnerHomeCubit>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Pet Owner',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showMySnackBar(
                context: context,
                message: 'Logging out...',
                color: Colors.red,
              );
              context.read<OwnerHomeCubit>().logout(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<OwnerHomeCubit, OwnerHomeState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<OwnerHomeCubit, OwnerHomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Sitters',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'My Pets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            backgroundColor: Colors.black,
            currentIndex: state.selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              context.read<OwnerHomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}
