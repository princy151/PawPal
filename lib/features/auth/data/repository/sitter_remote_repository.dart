import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/data/datasource/remote_data_source/sitter_remote_data_source.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/auth/domain/repository/sitter_repository.dart';

class SitterRemoteRepository implements ISitterRepository {
  final SitterRemoteDataSource _sitterRemoteDatasource;
  SitterRemoteRepository(this._sitterRemoteDatasource);

  @override
  Future<Either<Failure, PetSitterEntity>> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginSitter(
      String email, String password) async {
    try {
      final token = await _sitterRemoteDatasource.loginSitter(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName =
          await _sitterRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerSitter(PetSitterEntity user) async {
    try {
      return Right(_sitterRemoteDatasource.registerSitter(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
