import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String email;
  final String password;
  final String petname;
  final String type;
  final String? image;
  final String address;

  const AuthApiModel({
    this.id,
    this.image,
    required this.name,
    required this.email,
    required this.password,
    required this.petname,
    required this.type,
    required this.address,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  PetOwnerEntity toEntity() {
    return PetOwnerEntity(
      ownerId: id,
      name: name,
      email: email,
      petname: petname,
      type: type,
      address: address,
      password: password,
      image: image,
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(PetOwnerEntity entity) {
    return AuthApiModel(
      image: entity.image,
      name: entity.name,
      email: entity.email,
      petname: entity.petname,
      type: entity.type,
      address: entity.address,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props =>
      [name, image, email, petname, type, address, password];
}
