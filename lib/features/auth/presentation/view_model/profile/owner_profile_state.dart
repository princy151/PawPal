part of 'owner_profile_bloc.dart';

class OwnerProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final PetOwnerEntity? owner;
  final String? errorMessage;

  const OwnerProfileState({
    required this.isLoading,
    required this.isSuccess,
    this.owner,
    this.errorMessage,
  });

  const OwnerProfileState.initial()
      : isLoading = false,
        isSuccess = false,
        owner = null,
        errorMessage = null;

  OwnerProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    PetOwnerEntity? owner,
    String? errorMessage,
  }) {
    return OwnerProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      owner: owner ?? this.owner,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, owner, errorMessage];
}