import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/data/datasource/remote_data_source/owner_remote_data_source.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/repository/owner_repository.dart';


class OwnerRemoteRepository implements IOwnerRepository {
  final OwnerRemoteDataSource _ownerRemoteDatasource;
  OwnerRemoteRepository(this._ownerRemoteDatasource);

  @override
  Future<Either<Failure, PetOwnerEntity>> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginOwner(
      String email, String password) async {
    try {
      final result = await _ownerRemoteDatasource.loginOwner(email, password);
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _ownerRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerOwner(PetOwnerEntity user) async {
    try {
      return Right(_ownerRemoteDatasource.registerOwner(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
