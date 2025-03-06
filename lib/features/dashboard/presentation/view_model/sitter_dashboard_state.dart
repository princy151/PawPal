part of 'sitter_dashboard_bloc.dart';

class SitterDashboardState extends Equatable {
  final List<PetOwnerEntity> owners;
  final bool isLoading;
  final String? error;

  const SitterDashboardState({
    required this.owners,
    required this.isLoading,
    this.error,
  });

  factory SitterDashboardState.initial() {
    return const SitterDashboardState(
      owners: [],
      isLoading: false,
    );
  }

  SitterDashboardState copyWith({
    List<PetOwnerEntity>? owners,
    bool? isLoading,
    String? error,
  }) {
    return SitterDashboardState(
      owners: owners ?? this.owners, // Use `this.sitters` if `sitters` is null
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [owners, isLoading, error];
}
