import 'package:dartz/dartz.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/repository/owner_repository.dart';

class GetAllOwnerUseCase implements UsecaseWithoutParams<List<PetOwnerEntity>> {
  final IOwnerRepository ownerRepository;

  GetAllOwnerUseCase({required this.ownerRepository});

  @override
  Future<Either<Failure, List<PetOwnerEntity>>> call() {
    print('GetAllOwnerUseCase called');
    return ownerRepository.getOwners();
  }
}
