part of 'sitter_signup_bloc.dart';

class SitterSignupState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  const SitterSignupState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });

  const SitterSignupState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;

  SitterSignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
  }) {
    return SitterSignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        imageName,
      ];
}
