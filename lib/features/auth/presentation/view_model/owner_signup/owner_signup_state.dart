part of 'owner_signup_bloc.dart';

class OwnerSignupState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  const OwnerSignupState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });

  const OwnerSignupState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;

  OwnerSignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
  }) {
    return OwnerSignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName];
}
