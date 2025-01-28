import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/repository/owner_repository.dart';

class OwnerRegisterUserParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String petname;
  final String type;
  final String address;
  final String? image;

  const OwnerRegisterUserParams({
    required this.name,
    required this.email,
    required this.password,
    required this.petname,
    required this.type,
    required this.address,
    this.image,
  });

  //intial constructor
  const OwnerRegisterUserParams.initial({
    required this.name,
    required this.email,
    required this.password,
    required this.petname,
    required this.type,
    required this.address,
    this.image,
  });

  @override
  List<Object?> get props =>
      [name, email, password, petname, type, address, image];
}

class OwnerRegisterUsecase
    implements UsecaseWithParams<void, OwnerRegisterUserParams> {
  final IOwnerRepository repository;

  OwnerRegisterUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(OwnerRegisterUserParams params) {
    final ownerEntity = PetOwnerEntity(
      name: params.name,
      email: params.email,
      password: params.password,
      petname: params.petname,
      type: params.type,
      address: params.address,
      image: params.image,
    );
    return repository.registerOwner(ownerEntity);
  }
}
