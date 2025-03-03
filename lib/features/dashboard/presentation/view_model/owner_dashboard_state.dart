part of 'owner_dashboard_bloc.dart';

class OwnerDashboardState extends Equatable {
  final List<PetSitterEntity> sitters;
  final bool isLoading;
  final String? error;

  const OwnerDashboardState({
    required this.sitters,
    required this.isLoading,
    this.error,
  });

  factory OwnerDashboardState.initial() {
    return const OwnerDashboardState(
      sitters: [],
      isLoading: false,
    );
  }

  OwnerDashboardState copyWith({
    List<PetSitterEntity>? sitters,
    bool? isLoading,
    String? error,
  }) {
    return OwnerDashboardState(
      sitters:
          sitters ?? this.sitters, // Use `this.sitters` if `sitters` is null
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [sitters, isLoading, error];
}
