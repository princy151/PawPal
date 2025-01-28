import 'package:equatable/equatable.dart';

class PetOwnerEntity extends Equatable {
  final String? ownerId;
  final String name;
  final String email;
  final String password;
  final String petname;
  final String type;
  final String address;
  final String? image;

  const PetOwnerEntity({
    this.ownerId,
    required this.name,
    required this.email,
    required this.password,
    required this.petname,
    required this.type,
    required this.address,
    this.image,
  });

  @override
  List<Object?> get props =>
      [ownerId, name, email, password, petname, type, address, image];
}
