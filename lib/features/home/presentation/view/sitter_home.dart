// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pawpal/core/common/my_snackbar.dart';


// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   final bool _isDarkTheme = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Infinistone',
//             style: TextStyle(color: Colors.white)), // White text
//         centerTitle: true,
//         backgroundColor: Colors.black, // Black app bar
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.white), // White icon
//             onPressed: () {
//               showMySnackBar(
//                 context: context,
//                 message: 'Logging out...',
//                 color: Colors.red,
//               );
//               context.read<HomeCubit>().logout(context);
//             },
//           ),
//           Switch(
//             value: _isDarkTheme,
//             onChanged: (value) {
//               // Handle theme change
//             },
//             activeColor: Colors.white, // White switch color
//           ),
//         ],
//       ),
//       body: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           return state.views
//               .elementAt(state.selectedIndex); // Keep the inside as is
//         },
//       ),
//       bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           return BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.dashboard),
//                 label: 'Dashboard',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.search),
//                 label: 'Browse',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.remove_red_eye),
//                 label: 'Visualizer',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.account_circle),
//                 label: 'Account',
//               ),
//             ],
//             backgroundColor: Colors.black, // Black navigation bar
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.black, // White for selected item
//             unselectedItemColor: Colors.grey, // Grey for unselected items
//             onTap: (index) {
//               context.read<HomeCubit>().onTabTapped(index);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
