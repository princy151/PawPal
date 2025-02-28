import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/repository/owner_repository.dart';

class OwnerRegisterUserParams extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String password;
  final String? image;
  final List<PetEntity> pets;

  const OwnerRegisterUserParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    this.image,
    this.pets = const [],
  });

  @override
  List<Object?> get props =>
      [name, email, phone, password, address, image, pets];
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
      phone: params.phone,
      address: params.address,
      image: params.image,
      password: params.password,
      pets: params.pets,
    );
    return repository.registerOwner(ownerEntity);
  }
}
