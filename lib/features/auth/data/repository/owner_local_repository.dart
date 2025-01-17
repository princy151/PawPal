import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/data/datasource/local_data_source/owner_local_data_source.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/repository/owner_repository.dart';


class OwnerLocalRepository implements IOwnerRepository {
  final OwnerLocalDataSource _ownerLocalDataSource;

  OwnerLocalRepository(this._ownerLocalDataSource);

  @override
  Future<Either<Failure, PetOwnerEntity>> getCurrentUser() async {
    try {
      final currentUser = await _ownerLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginOwner(
    String email,
    String password,
  ) async {
    try {
      final token = await _ownerLocalDataSource.loginOwner(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerOwner(PetOwnerEntity owner) async {
    try {
      return Right(_ownerLocalDataSource.registerOwner(owner));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
