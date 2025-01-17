part of 'owner_signup_bloc.dart';

sealed class OwnerSignupEvent extends Equatable {
  const OwnerSignupEvent();

  @override
  List<Object> get props => [];
}

class RegisterOwner extends OwnerSignupEvent {
  final BuildContext context;
  final String name;
  final String email;
  final String password;
  final String petname;
  final String type;
  final String address;

  const RegisterOwner({
    required this.context,
    required this.name,
    required this.email,
    required this.password,
    required this.petname,
    required this.type,
    required this.address,
  });
}
