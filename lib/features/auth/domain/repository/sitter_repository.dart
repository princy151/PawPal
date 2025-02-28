import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';

abstract interface class ISitterRepository {
  Future<Either<Failure, void>> registerSitter(PetSitterEntity student);

  Future<Either<Failure, String>> loginSitter(String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, PetSitterEntity>> getCurrentUser();
}
