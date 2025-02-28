import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/core/common/my_snackbar.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart'; // Import the entity
import 'package:pawpal/features/auth/domain/use_case/owner_register_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/upload_image_usecase.dart';

part 'owner_signup_event.dart';
part 'owner_signup_state.dart';

class OwnerSignupBloc extends Bloc<OwnerSignupEvent, OwnerSignupState> {
  final OwnerRegisterUsecase _ownerRegisterUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  OwnerSignupBloc({
    required OwnerRegisterUsecase ownerRegisterUsecase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _ownerRegisterUseCase = ownerRegisterUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        super(OwnerSignupState.initial()) {
    on<RegisterOwner>(_onOwnerRegisterEvent);
    on<LoadImage>(_onLoadImage);
    on<LoadPetImage>(_onLoadPetImage);
  }

  void _onOwnerRegisterEvent(
    RegisterOwner event,
    Emitter<OwnerSignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Create PetOwnerEntity with PetEntity list
    final petEntities = event.pets
        .map((pet) => PetEntity(
              petname: pet.petname,
              type: pet.type,
              petimage: state.petImage,
              petinfo: pet.petinfo,
              openbooking: pet.openbooking,
              booked: pet.booked,
            ))
        .toList();

    // Create an instance of PetOwnerEntity
    // final petOwnerEntity = PetOwnerEntity(
    //   name: event.name,
    //   email: event.email,
    //   phone: event.phone,
    //   address: event.address,
    //   password: event.password,
    //   image:
    //       state.imageName, // Assuming the image name is passed from the state
    //   pets: petEntities,
    // );

    final result = await _ownerRegisterUseCase.call(OwnerRegisterUserParams(
      name: event.name,
      email: event.email,
      phone: event.phone,
      address: event.address,
      password: event.password,
      image:
          state.imageName, // Assuming the image name is passed from the state
      pets: petEntities,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }

  void _onLoadImage(
    LoadImage event,
    Emitter<OwnerSignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }

  void _onLoadPetImage(
    LoadPetImage event,
    Emitter<OwnerSignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, petImage: r));
      },
    );
  }
}
