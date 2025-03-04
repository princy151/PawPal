import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';

class GetSitterUsecase implements UsecaseWithoutParams<PetSitterEntity> {
  final TokenSharedPrefs _tokenSharedPrefs;

  GetSitterUsecase({
    required TokenSharedPrefs tokenSharedPrefs,
  }) : _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, PetSitterEntity>> call() async {
    try {
      final sitterMap = await _tokenSharedPrefs.getSitter();
      print('USER MAP:: ${sitterMap.runtimeType}');

      if (sitterMap == null) {
        return const Left(SharedPrefsFailure(message: "User data not found"));
      }
      print('USER MAP CONTENTS:: $sitterMap');
      // Convert the Map into an AuthEntity instance
      final sitter = PetSitterEntity.fromJson(sitterMap);
      print('USER:: $sitter');
      return Right(sitter);
    } catch (e) {
      print("Why error: ${e.toString()}");
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
