import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/core/common/my_snackbar.dart';
import 'package:pawpal/features/auth/domain/use_case/owner_register_usecase.dart';

part 'owner_signup_event.dart';
part 'owner_signup_state.dart';

class OwnerSignupBloc extends Bloc<OwnerSignupEvent, OwnerSignupState> {
  final OwnerRegisterUsecase _ownerRegisterUseCase;

  OwnerSignupBloc({
    required OwnerRegisterUsecase ownerRegisterUsecase,
  })  : _ownerRegisterUseCase = ownerRegisterUsecase,
        super(OwnerSignupState.initial()) {
    on<RegisterOwner>(_onOwnerRegisterEvent);
  }

  void _onOwnerRegisterEvent(
    RegisterOwner event,
    Emitter<OwnerSignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _ownerRegisterUseCase.call(OwnerRegisterUserParams(
      name: event.name,
      email: event.email,
      password: event.password,
      petname: event.petname,
      type: event.type,
      address: event.address,
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
}
