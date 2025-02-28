// import 'dart:io';

// import 'package:pawpal/core/network/hive_service.dart';
// import 'package:pawpal/features/auth/data/datasource/owner_data_source.dart';
// import 'package:pawpal/features/auth/data/model/owner_hive_model.dart';
// import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

// class OwnerLocalDataSource implements IOwnerDataSource {
//   final HiveService _hiveService;

//   OwnerLocalDataSource(this._hiveService);

//   @override
//   Future<PetOwnerEntity> getCurrentUser() async {
//     try {
//       final authHiveModel = await _hiveService.getUser();
//       return authHiveModel.toEntity();  // Convert to PetOwnerEntity
//     } catch (e) {
//       // If user not found or any other error, return a default or empty entity
//       return PetOwnerEntity(
//         ownerId: "1",  // Default or mock id
//         name: "",
//         email: "",
//         password: "",
//         petname: "",
//         type: "",
//         address: "",
//         phone: "",  // Added phone number
//         image: "",
//         pets: [],
//       );
//     }
//   }

//   @override
//   Future<String> loginOwner(String email, String password) async {
//     try {
//       // Authenticate via the Hive service or some local logic
//       await _hiveService.login(email, password);
//       return "Success"; // On successful login
//     } catch (e) {
//       return Future.error("Login failed: $e");
//     }
//   }

//   @override
//   Future<void> registerOwner(PetOwnerEntity owner) async {
//     try {
//       // Convert PetOwnerEntity to OwnerHiveModel
//       final ownerHiveModel = OwnerHiveModel.fromEntity(owner);

//       await _hiveService.register(ownerHiveModel);  // Register user via Hive service
//       return Future.value();
//     } catch (e) {
//       return Future.error("Registration failed: $e");
//     }
//   }

//   @override
//   Future<String> uploadProfilePicture(File file) async {
//     throw UnimplementedError();  // Local storage might not handle profile picture upload
//   }
// }
