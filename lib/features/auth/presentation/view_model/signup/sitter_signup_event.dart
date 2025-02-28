part of 'sitter_signup_bloc.dart';

sealed class SitterSignupEvent extends Equatable {
  const SitterSignupEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends SitterSignupEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class LoadPetImage extends SitterSignupEvent {
  final File file;

  const LoadPetImage({
    required this.file,
  });
}

class RegisterSitter extends SitterSignupEvent {
  final BuildContext context;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String? image;

  const RegisterSitter({
    required this.context,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    this.image,
  });

  @override
  List<Object> get props =>
      [context, name, email, password, address, image ?? ''];
}
