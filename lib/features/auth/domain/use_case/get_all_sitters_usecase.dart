import 'package:dartz/dartz.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/auth/domain/repository/sitter_repository.dart';

class GetAllSitterUseCase
    implements UsecaseWithoutParams<List<PetSitterEntity>> {
  final ISitterRepository sitterRepository;

  GetAllSitterUseCase({required this.sitterRepository});

  @override
  Future<Either<Failure, List<PetSitterEntity>>> call() {
    print('GetAllSitterUseCase called');
    return sitterRepository.getSitters();
  }
}
