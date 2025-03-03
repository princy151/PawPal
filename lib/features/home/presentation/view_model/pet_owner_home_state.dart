import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/features/auth/domain/use_case/get_all_sitters_usecase.dart';
import 'package:pawpal/features/dashboard/presentation/view/pet_owner_dashboard_view.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/owner_dashboard_bloc.dart';

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
        const Center(
          child: Text('My Pets'),
        ),
        const Center(
          child: Text('Bookings'),
        ),
        const Center(
          child: Text('Account'),
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
