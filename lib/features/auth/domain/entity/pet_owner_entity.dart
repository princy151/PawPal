import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet_owner_entity.g.dart'; // or wherever the PetEntity file is

@JsonSerializable()
class PetEntity extends Equatable {
  final String petname;
  final String type;
  final String? petimage;
  final String? petinfo;
  final String openbooking;
  final String booked;

  const PetEntity({
    required this.petname,
    required this.type,
    this.petimage,
    this.petinfo,
    this.openbooking = 'no',
    this.booked = 'no',
  });

  factory PetEntity.fromJson(Map<String, dynamic> json) =>
      _$PetEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PetEntityToJson(this);

  @override
  List<Object?> get props =>
      [petname, type, petimage, petinfo, openbooking, booked];
}

class PetOwnerEntity extends Equatable {
  final String? ownerId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? password;
  final String? image;
  final List<PetEntity> pets;

  const PetOwnerEntity({
    this.ownerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.password,
    this.image,
    this.pets = const [],
  });

  @override
  List<Object?> get props =>
      [ownerId, name, email, phone, address, image, pets];

  static fromJson(Map<String, dynamic> userMap) {
    return PetOwnerEntity(
      ownerId: userMap['userId'],
      name: userMap['name'] ?? '',
      email: userMap['email'] ?? '',
      phone: userMap['phone'] ?? '',
      address: userMap['address'] ?? '',
      image: userMap['image'],
      password: '',
    );
  }
}
