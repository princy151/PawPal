part of 'pet_bloc.dart';

class PetState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<PetEntity> pets;

  const PetState({
    required this.isLoading,
    this.error,
    required this.pets,
  });

  factory PetState.initial() => const PetState(
        isLoading: false,
        pets: [],
      );

  PetState copyWith({
    bool? isLoading,
    String? error,
    List<PetEntity>? pets,
  }) {
    return PetState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      pets: pets ?? this.pets,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, pets];
}