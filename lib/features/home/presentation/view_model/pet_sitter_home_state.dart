import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/features/auth/presentation/view/sitter_profile_view.dart';
import 'package:pawpal/features/auth/presentation/view_model/profile/sitter_profile_bloc.dart';
import 'package:pawpal/features/booking/presentation/view/sitter_booking_view.dart';
import 'package:pawpal/features/booking/presentation/view_model/bookings_bloc.dart';
import 'package:pawpal/features/dashboard/presentation/view/pet_sitter_dashboard_view.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/sitter_dashboard_bloc.dart';

class SitterHomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const SitterHomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static SitterHomeState initial() {
    return SitterHomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<SitterDashboardBloc>(),
          child: const PetSitterDashboardView(),
        ),
        BlocProvider(
          create: (context) => getIt<BookingsBloc>(),
          child: const BookingsPage(),
        ),
        BlocProvider(
          create: (context) => getIt<SitterProfileBloc>(),
          child: const SitterProfilePage(),
        ),
        // const Center(
        //   child: Text('My Pets'),
        // ),
      ],
    );
  }

  SitterHomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return SitterHomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
