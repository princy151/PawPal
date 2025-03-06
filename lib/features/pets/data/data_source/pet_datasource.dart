import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

abstract interface class IPetDataSource {
  // Future<List<PetEntity>> getPets();
  Future<void> createPet(PetEntity item,String ownerId);
  Future<void> deletePet(String ownerId, String petId, String? token);
}
