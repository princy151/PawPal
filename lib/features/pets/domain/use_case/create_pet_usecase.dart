import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/pets/domain/repository/pet_repository.dart';

class CreatePetParams extends Equatable {
  final String petname;
  final String type;
  final String? petimage;
  final String? petinfo;
  final String openbooking;
  final String booked;
  final String? petId;

  const CreatePetParams({
    required this.petname,
    required this.type,
    this.petimage,
    this.petinfo,
    this.openbooking = 'no',
    this.booked = 'no',
    this.petId,
  });

  // Empty constructor
  const CreatePetParams.empty()
      : petname = '_empty.string',
        type = '_empty.string',
        petimage = '_empty.string',
        petinfo = '_empty.string',
        openbooking = 'no',
        booked = 'no',
        petId = '';

  @override
  List<Object?> get props =>
      [petId, petname, type, petimage, petinfo, openbooking, booked];
}

class CreatePetUseCase implements UsecaseWithParams<void, CreatePetParams> {
  final IPetRepository PetRepository;

  CreatePetUseCase({required this.PetRepository});

  @override
  Future<Either<Failure, void>> call(CreatePetParams params) async {
    return await PetRepository.createPet(
      PetEntity(
        petname: params.petname,
        type: params.type,
        petimage: params.petimage,
        petinfo: params.petinfo,
        openbooking: params.openbooking,
        booked: params.booked,
        petId: params.petId,
      ),
      PetOwnerEntity(
        name: 'Owner Name',
        email: 'owner@example.com',
        phone: '1234567890',
        address: 'Owner Address',
      ) as String, // ownerId
    );
  }
}
