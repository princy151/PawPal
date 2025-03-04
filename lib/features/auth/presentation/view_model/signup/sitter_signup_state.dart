part of 'sitter_signup_bloc.dart';

class SitterSignupState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageNamee;

  const SitterSignupState({
    required this.isLoading,
    required this.isSuccess,
    this.imageNamee,
  });

  const SitterSignupState.initial()
      : isLoading = false,
        isSuccess = false,
        imageNamee = null;

  SitterSignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageNamee,
  }) {
    return SitterSignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageNamee: imageNamee ?? this.imageNamee,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        imageNamee,
      ];
}
