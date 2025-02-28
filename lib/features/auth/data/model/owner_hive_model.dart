// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:pawpal/app/constants/hive_table_constant.dart';
// import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
// import 'package:uuid/uuid.dart';

// part 'owner_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.sitterTableId)
// class OwnerHiveModel extends Equatable {
//   @HiveField(0)
//   final String? ownerId;
//   @HiveField(1)
//   final String name;
//   @HiveField(2)
//   final String email;
//   @HiveField(3)
//   final String password;
//   @HiveField(4)
//   final String phone;
//   @HiveField(5)
//   final String address;
//   @HiveField(6)
//   final String? image;
//   @HiveField(7)
//   final List<PetEntityHiveModel> pets;

//   OwnerHiveModel({
//     String? ownerId,
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.phone,
//     required this.address,
//     this.image,
//     this.pets = const [],
//   }) : ownerId = ownerId ?? const Uuid().v4();

//   // Initial Constructor
//   const OwnerHiveModel.initial()
//       : ownerId = '',
//         name = '',
//         email = '',
//         password = '',
//         phone = '',
//         address = '',
//         image = null,
//         pets = const [];

//   // From Entity
//   factory OwnerHiveModel.fromEntity(PetOwnerEntity entity) {
//     return OwnerHiveModel(
//       ownerId: entity.ownerId,
//       name: entity.name,
//       email: entity.email,
//       password: entity.password,
//       phone: entity.phone,
//       address: entity.address,
//       image: entity.image,
//       pets: entity.pets.map((pet) => PetEntityHiveModel.fromEntity(pet)).toList(),
//     );
//   }

//   // To Entity
//   PetOwnerEntity toEntity() {
//     return PetOwnerEntity(
//       ownerId: ownerId,
//       name: name,
//       email: email,
//       password: password,
//       phone: phone,
//       address: address,
//       image: image,
//       pets: pets.map((pet) => pet.toEntity()).toList(),
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [ownerId, name, email, password, phone, address, image, pets];
// }

// @HiveType(typeId: 2)  // This should match the table ID for PetEntity
// class PetEntityHiveModel extends Equatable {
//   @HiveField(0)
//   final String petname;
//   @HiveField(1)
//   final String type;
//   @HiveField(2)
//   final String? petimage;
//   @HiveField(3)
//   final String? petinfo;
//   @HiveField(4)
//   final bool openbooking;
//   @HiveField(5)
//   final bool booked;

//   const PetEntityHiveModel({
//     required this.petname,
//     required this.type,
//     this.petimage,
//     this.petinfo,
//     this.openbooking = false,
//     this.booked = false,
//   });

//   // From Entity
//   factory PetEntityHiveModel.fromEntity(PetEntity entity) {
//     return PetEntityHiveModel(
//       petname: entity.petname,
//       type: entity.type,
//       petimage: entity.petimage,
//       petinfo: entity.petinfo,
//       openbooking: entity.openbooking,
//       booked: entity.booked,
//     );
//   }

//   // To Entity
//   PetEntity toEntity() {
//     return PetEntity(
//       petname: petname,
//       type: type,
//       petimage: petimage,
//       petinfo: petinfo,
//       openbooking: openbooking,
//       booked: booked,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [petname, type, petimage, petinfo, openbooking, booked];
// }
