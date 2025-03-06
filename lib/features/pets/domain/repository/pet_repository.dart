import 'package:dartz/dartz.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

abstract interface class IPetRepository {
  Future<Either<Failure, void>> createPet(PetEntity pet, String ownerId);
  Future<Either<Failure, void>> deletePet(String ownerId, String petId, String? token);
}
