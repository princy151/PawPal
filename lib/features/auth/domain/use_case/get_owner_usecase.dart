import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

class GetOwnerUsecase implements UsecaseWithoutParams<PetOwnerEntity> {
  final TokenSharedPrefs _tokenSharedPrefs;

  GetOwnerUsecase({
    required TokenSharedPrefs tokenSharedPrefs,
  }) : _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, PetOwnerEntity>> call() async {
    try {
      final ownerMap = await _tokenSharedPrefs.getOwner();
      print('USER MAP:: ${ownerMap.runtimeType}');

      if (ownerMap == null) {
        return const Left(SharedPrefsFailure(message: "User data not found"));
      }
      print('USER MAP CONTENTS:: $ownerMap');
      // Convert the Map into an AuthEntity instance
      final owner = PetOwnerEntity.fromJson(ownerMap);
      print('USER:: $owner');
      return Right(owner);
    } catch (e) {
      print("Why error: ${e.toString()}");
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
