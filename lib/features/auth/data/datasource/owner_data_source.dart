import 'dart:io';

import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

abstract interface class IOwnerDataSource {
  Future<String> loginOwner(String username, String password);

  Future<void> registerOwner(PetOwnerEntity owner);

  Future<PetOwnerEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
