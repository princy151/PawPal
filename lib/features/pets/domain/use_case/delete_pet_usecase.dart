import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/pets/domain/repository/pet_repository.dart';

class DeletePetParams extends Equatable {
  final String ownerId;
  final String petId;

  const DeletePetParams({required this.ownerId, required this.petId});

  const DeletePetParams.empty()
      : ownerId = '_empty.string',
        petId = '_empty.string';

  @override
  List<Object?> get props => [ownerId, petId];
}

class DeletePetUsecase implements UsecaseWithParams<void, DeletePetParams> {
  final IPetRepository petRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeletePetUsecase({
    required this.petRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeletePetParams params) async {
    // Get token from Shared Preferences and send it to the server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await petRepository.deletePet(params.petId, params.ownerId, r);
    });
  }
}
