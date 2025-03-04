part of 'sitter_profile_bloc.dart';

class SitterProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final PetSitterEntity? sitter;
  final String? errorMessage;

  const SitterProfileState({
    required this.isLoading,
    required this.isSuccess,
    this.sitter,
    this.errorMessage,
  });

  const SitterProfileState.initial()
      : isLoading = false,
        isSuccess = false,
        sitter = null,
        errorMessage = null;

  SitterProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    PetSitterEntity? sitter,
    String? errorMessage,
  }) {
    return SitterProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      sitter: sitter ?? this.sitter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, sitter, errorMessage];
}