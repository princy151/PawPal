import 'dart:io';

import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';

abstract interface class ISitterDataSource {
  Future<String> loginSitter(String username, String password);

  Future<void> registerSitter(PetSitterEntity sitter);

  // Future<PetSitterEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);

  Future<List<PetSitterEntity>> getSitters();

  Future<PetSitterEntity> getCurrentSitter(String? token, String userId);


  Future<PetSitterEntity> updateSitter(PetSitterEntity userId);
}
