part of 'owner_signup_bloc.dart';

sealed class OwnerSignupEvent extends Equatable {
  const OwnerSignupEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends OwnerSignupEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class LoadPetImage extends OwnerSignupEvent {
  final File file;

  const LoadPetImage({
    required this.file,
  });
}

class RegisterOwner extends OwnerSignupEvent {
  final BuildContext context;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final List<PetEntity> pets; // List of PetEntity
  final String? image;

  const RegisterOwner({
    required this.context,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.pets, // Pass pets here
    this.image,
  });

  @override
  List<Object> get props =>
      [context, name, email, password, address, pets, image ?? ''];
}
