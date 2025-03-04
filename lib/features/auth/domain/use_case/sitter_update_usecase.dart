import 'package:dartz/dartz.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/auth/domain/repository/sitter_repository.dart';


class UpdateSitterUsecase implements UsecaseWithParams<void, PetSitterEntity> {
  final ISitterRepository repository;

  UpdateSitterUsecase(this.repository);

  @override
  Future<Either<Failure, PetSitterEntity>> call(PetSitterEntity params) async {
    try {
      final sitterEntity = PetSitterEntity(
        name: params.name,
        email: params.email,
        phone: params.phone,
        address: params.address,
        image: params.image,
      );
      print('AUTHENTITY::: $sitterEntity');
      return repository.updateSitter(sitterEntity);
    } catch (e) {
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
