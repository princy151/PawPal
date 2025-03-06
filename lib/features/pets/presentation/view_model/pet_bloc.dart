import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/use_case/get_all_owners_usecase.dart';
import 'package:pawpal/features/pets/domain/use_case/create_pet_usecase.dart';
import 'package:pawpal/features/pets/domain/use_case/delete_pet_usecase.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final GetAllOwnerUseCase _getAllOwnerUseCase;
  final CreatePetUseCase _createPetUseCase;
  final DeletePetUsecase _deletePetUsecase;

  PetBloc(
      {required GetAllOwnerUseCase getAllOwnerUseCase,
      required CreatePetUseCase createPetUseCase,
      required DeletePetUsecase deletePetUsecase})
      : _getAllOwnerUseCase = getAllOwnerUseCase,
        _createPetUseCase = createPetUseCase,
        _deletePetUsecase = deletePetUsecase,
        super(PetState.initial()) {
    on<LoadPets>(_onLoadPets);
    on<AddPet>(_onAddPet);
  }

  Future<void> _onLoadPets(LoadPets event, Emitter<PetState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllOwnerUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (owners) {
        // Extract all pets from all owners
        final allPets = owners.expand((owner) => owner.pets).toList();
        emit(state.copyWith(isLoading: false, pets: allPets));
      },
    );
  }

  Future<void> _onAddPet(AddPet event, Emitter<PetState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createPetUseCase.call(CreatePetParams(
        petname: event.petname,
        type: event.type,
        petinfo: event.petinfo,
        openbooking: event.openbooking));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (pets) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadPets());
      },
    );
  }
}
