import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

part 'pets_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PetApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? petId;
  final String petname;
  final String type;
  final String? petimage;
  final String? petinfo;
  final String openbooking;
  final String booked;

  const PetApiModel({
    this.petId,
    required this.petname,
    required this.type,
    this.petimage,
    this.petinfo,
    this.openbooking = 'no',
    this.booked = 'no',
  });

  factory PetApiModel.fromJson(Map<String, dynamic> json) =>
      _$PetApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetApiModelToJson(this);

  // To Entity
  PetEntity toEntity() {
    return PetEntity(
      petId: petId,
      petname: petname,
      type: type,
      petimage: petimage,
      petinfo: petinfo,
      openbooking: openbooking,
      booked: booked,
    );
  }

  // From Entity
  factory PetApiModel.fromEntity(PetEntity entity) {
    return PetApiModel(
      petId: entity.petId,
      petname: entity.petname,
      type: entity.type,
      petimage: entity.petimage,
      petinfo: entity.petinfo,
      openbooking: entity.openbooking,
      booked: entity.booked,

    );
  }

  static List<PetEntity> toEntityList(List<PetApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props =>
      [petId, petname, type, petimage, petinfo, openbooking, booked];
}
