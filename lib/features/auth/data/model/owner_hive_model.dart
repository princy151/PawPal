import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pawpal/app/constants/hive_table_constant.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:uuid/uuid.dart';

part 'owner_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.sitterTableId)
class OwnerHiveModel extends Equatable {
  @HiveField(0)
  final String? ownerId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String petname;
  @HiveField(5)
  final String type;
  @HiveField(6)
  final String address;

  OwnerHiveModel({
    String? ownerId,
    required this.name,
    required this.email,
    required this.password,
    required this.petname,
    required this.type,
    required this.address,
  }) : ownerId = ownerId ?? const Uuid().v4();

  // Initial Constructor
  const OwnerHiveModel.initial()
      : ownerId = '',
        name = '',
        email = '',
        password = '',
        petname = '',
        type = '',
        address = '';

  // From Entity
  factory OwnerHiveModel.fromEntity(PetOwnerEntity entity) {
    return OwnerHiveModel(
      ownerId: entity.ownerId,
      name: entity.name,
      email: entity.email,
      password: entity.password,
      petname: entity.petname,
      type: entity.type,
      address: entity.address,
    );
  }

  // To Entity
  PetOwnerEntity toEntity() {
    return PetOwnerEntity(
      ownerId: ownerId,
      name: name,
      email: email,
      password: password,
      petname: petname,
      type: type,
      address: address,
    );
  }

  @override
  List<Object?> get props =>
      [ownerId, name, email, password, petname, type, address];
}
