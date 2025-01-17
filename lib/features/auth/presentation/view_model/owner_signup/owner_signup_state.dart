part of 'owner_signup_bloc.dart';

class OwnerSignupState {
  final bool isLoading;
  final bool isSuccess;

  OwnerSignupState({
    required this.isLoading,
    required this.isSuccess,
  });

  OwnerSignupState.initial()
      : isLoading = false,
        isSuccess = false;

  OwnerSignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return OwnerSignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}


