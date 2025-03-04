import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';

part 'sitter_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SitterApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String address;
  final String? password;

  const SitterApiModel({
    this.id,
    this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.password,
  });

  factory SitterApiModel.fromJson(Map<String, dynamic> json) =>
      _$SitterApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SitterApiModelToJson(this);

  // To Entity
  PetSitterEntity toEntity() {
    return PetSitterEntity(
      sitterId: id,
      name: name,
      email: email,
      phone: phone,
      address: address,
      password: password,
      image: image,
    );
  }

  // From Entity
  factory SitterApiModel.fromEntity(PetSitterEntity entity) {
    return SitterApiModel(
      id: entity.sitterId,
      image: entity.image,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      password: entity.password,
    );
  }

  static List<PetSitterEntity> toEntityList(List<SitterApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [id, name, email, phone, address, image, password];
}
