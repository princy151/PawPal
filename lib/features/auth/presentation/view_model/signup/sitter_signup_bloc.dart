import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/core/common/my_snackbar.dart';
import 'package:pawpal/features/auth/domain/use_case/sitter_register_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/upload_image_usecase.dart';

part 'sitter_signup_event.dart';
part 'sitter_signup_state.dart';

class SitterSignupBloc extends Bloc<SitterSignupEvent, SitterSignupState> {
  final SitterRegisterUsecase _sitterRegisterUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  SitterSignupBloc({
    required SitterRegisterUsecase sitterRegisterUsecase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _sitterRegisterUseCase = sitterRegisterUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        super(SitterSignupState.initial()) {
    on<RegisterSitter>(_onSitterRegisterEvent);
    on<LoadImagee>(_onLoadImagee);
  }

  void _onSitterRegisterEvent(
    RegisterSitter event,
    Emitter<SitterSignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _sitterRegisterUseCase.call(SitterRegisterUserParams(
      name: event.name,
      email: event.email,
      phone: event.phone,
      address: event.address,
      password: event.password,
      image:
          state.imageNamee, // Assuming the image name is passed from the state
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

  void _onLoadImagee(
    LoadImagee event,
    Emitter<SitterSignupState> emit,
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
        emit(state.copyWith(isLoading: false, isSuccess: true, imageNamee: r));
      },
    );
  }
}
