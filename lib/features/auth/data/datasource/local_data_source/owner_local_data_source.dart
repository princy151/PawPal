import 'dart:io';

import 'package:pawpal/core/network/hive_service.dart';
import 'package:pawpal/features/auth/data/datasource/owner_data_source.dart';
import 'package:pawpal/features/auth/data/model/owner_hive_model.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

class OwnerLocalDataSource implements IOwnerDataSource {
  final HiveService _hiveService;

  OwnerLocalDataSource(this._hiveService);

  @override
  Future<PetOwnerEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(PetOwnerEntity(
      ownerId: "1",
      name: "",
      email: "",
      password: "",
      petname: "",
      type: "",
      address: "",
    ));
  }

  @override
  Future<String> loginOwner(String username, String password) async {
    try {
      await _hiveService.login(username, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerOwner(PetOwnerEntity student) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = OwnerHiveModel.fromEntity(student);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
}
