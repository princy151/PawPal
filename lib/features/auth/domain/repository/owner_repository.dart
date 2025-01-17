import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

abstract interface class IOwnerRepository {
  Future<Either<Failure, void>> registerOwner(PetOwnerEntity student);

  Future<Either<Failure, String>> loginOwner(String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, PetOwnerEntity>> getCurrentUser();
}
