part of 'owner_signup_bloc.dart';

class OwnerSignupState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final String? petImage;

  const OwnerSignupState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    this.petImage,
  });

  const OwnerSignupState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        petImage = null;

  OwnerSignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    String? petImage,
  }) {
    return OwnerSignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      petImage: petImage ?? this.petImage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName, petImage];
}
