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
      final token = await _ownerRemoteDatasource.loginOwner(email, password);
      return Right(token);
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

  @override
  Future<Either<Failure, List<PetOwnerEntity>>> getOwners() async {
    try {
      final owners = await _ownerRemoteDatasource.getOwners();
      return Right(owners);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PetOwnerEntity>> getCurrentOwner(
      String? token, String userID) async {
    try {
      final user = await _ownerRemoteDatasource.getCurrentOwner(token, userID);
      print("USERRR:: $user");
      return Right(user);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PetOwnerEntity>> updateOwner(PetOwnerEntity owner) async {
    print('User update response:::::::');
    try {
      // var newUser = AuthEntity(
      //   fname: user.fname,
      //   lname: user.lname,
      //   email: user.email,
      //   phoneNo: user.phoneNo,
      //   address: user.address,
      //   username: user.address,
      //   password: currentUser.,
      // );
      final response = await _ownerRemoteDatasource.updateOwner(owner);
      print("User update response::: $response");
      return Right(response);
    } catch (e) {
      print('ERROR $e');
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
