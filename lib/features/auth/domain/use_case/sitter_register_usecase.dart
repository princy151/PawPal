import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/auth/domain/repository/sitter_repository.dart';

class SitterRegisterUserParams extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String password;
  final String? image;

  const SitterRegisterUserParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [name, email, phone, password, address, image];
}

class SitterRegisterUsecase
    implements UsecaseWithParams<void, SitterRegisterUserParams> {
  final ISitterRepository repository;

  SitterRegisterUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SitterRegisterUserParams params) {
    final sitterEntity = PetSitterEntity(
      name: params.name,
      email: params.email,
      phone: params.phone,
      address: params.address,
      image: params.image,
      password: params.password,
    );
    return repository.registerSitter(sitterEntity);
  }
}
