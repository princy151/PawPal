import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/core/common/my_snackbar.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_home_cubit.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Pet Owner',
            style: TextStyle(color: Colors.white)), // White text
        centerTitle: true,
        backgroundColor: Colors.black, // Black app bar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // White icon
            onPressed: () {
              showMySnackBar(
                context: context,
                message: 'Logging out...',
                color: Colors.red,
              );
              context.read<OwnerHomeCubit>().logout(context);
            },
          ),
          Switch(
            value: _isDarkTheme,
            onChanged: (value) {
              // Handle theme change
            },
            activeColor: Colors.white, // White switch color
          ),
        ],
      ),
      body: BlocBuilder<OwnerHomeCubit, OwnerHomeState>(
        builder: (context, state) {
          return state.views
              .elementAt(state.selectedIndex); // Keep the inside as is
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
            backgroundColor: Colors.black, // Black navigation bar
            currentIndex: state.selectedIndex,
            selectedItemColor: Colors.black, // White for selected item
            unselectedItemColor: Colors.grey, // Grey for unselected items
            onTap: (index) {
              context.read<OwnerHomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}
