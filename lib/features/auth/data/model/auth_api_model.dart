import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String address;
  final String? password;
  final List<PetEntity> pets;

  const AuthApiModel({
    this.id,
    this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.password,
    required this.pets,
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
      phone: phone,
      address: address,
      password: password,
      image: image,
      pets: pets,
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(PetOwnerEntity entity) {
    return AuthApiModel(
      id: entity.ownerId,
      image: entity.image,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      password: entity.password,
      pets: entity.pets,
    );
  }

  static List<PetOwnerEntity> toEntityList(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props =>
      [id, name, email, phone, address, image, pets, password];
}
