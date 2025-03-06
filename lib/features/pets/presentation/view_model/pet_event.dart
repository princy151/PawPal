part of 'pet_bloc.dart';

abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object?> get props => [];
}

class LoadPets extends PetEvent {}

final class AddPet extends PetEvent {
  final String petname;
  final String type;
  final String? petimage;
  final String? petinfo;
  final String openbooking;
  final String booked;

  const AddPet(this.petname, this.type, this.petimage, this.petinfo,
      {this.openbooking = "no", this.booked = "no"});

  @override
  List<Object> get props => [petname, type, openbooking, booked];
}
