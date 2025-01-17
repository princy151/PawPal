import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PetOwnerDashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const PetOwnerDashboardState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static PetOwnerDashboardState initial() {
    return PetOwnerDashboardState(
      selectedIndex: 0,
      views: [
        const Center(
          child: Text('Dashboard'),
        ),
        const Center(
          child: Text('Account'),
        ),
      ],
    );
  }

  PetOwnerDashboardState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return PetOwnerDashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
