import 'package:equatable/equatable.dart';

class PetSitterEntity extends Equatable {
  final String? sitterId;
  final String name;
  final String email;
  final String phone;
  final String? password;
  final String address;
  final String? image;

  const PetSitterEntity({
    this.sitterId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.password,
    this.image,
  });

  @override
  List<Object?> get props => [sitterId, name, email, phone, address, image];

  static fromJson(Map<String, dynamic> userMap) {
    return PetSitterEntity(
      sitterId: userMap['sitterId'],
      name: userMap['name'] ?? '',
      email: userMap['email'] ?? '',
      phone: userMap['phone'] ?? '',
      address: userMap['address'] ?? '',
      image: userMap['image'],
      password: '',
    );
  }
}
