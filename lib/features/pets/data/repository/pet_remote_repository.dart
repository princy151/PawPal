import 'package:dartz/dartz.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/pets/data/data_source/remote_datasource/pet_remote_datasource.dart';
import 'package:pawpal/features/pets/domain/repository/pet_repository.dart';

class PetRemoteRepository implements IPetRepository {
  final PetRemoteDataSource remoteDataSource;

  PetRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createPet(PetEntity pet, String ownerId) async {
    try {
      remoteDataSource.createPet(pet, ownerId);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deletePet(String ownerId, String petId, String? token) async {
    try {
      remoteDataSource.deletePet(ownerId, petId,  token);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

}
