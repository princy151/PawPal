import 'package:dartz/dartz.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/auth/domain/repository/owner_repository.dart';


class UpdateOwnerUsecase implements UsecaseWithParams<void, PetOwnerEntity> {
  final IOwnerRepository repository;

  UpdateOwnerUsecase(this.repository);

  @override
  Future<Either<Failure, PetOwnerEntity>> call(PetOwnerEntity params) async {
    try {
      final ownerEntity = PetOwnerEntity(
        name: params.name,
        email: params.email,
        phone: params.phone,
        address: params.address,
        image: params.image,
        password: params.password,
      );
      print('AUTHENTITY::: $ownerEntity');
      return repository.updateOwner(ownerEntity);
    } catch (e) {
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
