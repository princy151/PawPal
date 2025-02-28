import 'package:equatable/equatable.dart';

class PetSitterEntity extends Equatable {
  final String? sitterId;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String? image;

  const PetSitterEntity({
    this.sitterId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [sitterId, name, email, phone, address, image];
}
