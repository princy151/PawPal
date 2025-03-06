import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/features/auth/presentation/view/owner_profile_view.dart';
import 'package:pawpal/features/auth/presentation/view_model/profile/owner_profile_bloc.dart';
import 'package:pawpal/features/booking/presentation/view/owner_booking_view.dart';
import 'package:pawpal/features/booking/presentation/view_model/bookings_bloc.dart';
import 'package:pawpal/features/dashboard/presentation/view/pet_owner_dashboard_view.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/owner_dashboard_bloc.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/sitter_dashboard_bloc.dart';
import 'package:pawpal/features/pets/presentation/view/pet_view.dart';

class OwnerHomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const OwnerHomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static OwnerHomeState initial() {
    return OwnerHomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<OwnerDashboardBloc>(),
          child: const OwnerDashboardPage(),
        ),
        BlocProvider(
          create: (context) => getIt<SitterDashboardBloc>(),
          child: AllPetsPage(
            tokenSharedPrefs: getIt<
                TokenSharedPrefs>(), 
          ),
        ),
        BlocProvider(
          create: (context) => getIt<BookingsBloc>(),
          child: const OwnerBookingView(),
        ),
        BlocProvider(
          create: (context) => getIt<OwnerProfileBloc>(),
          child: const OwnerProfilePage(),
        ),
      ],
    );
  }

  OwnerHomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return OwnerHomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
