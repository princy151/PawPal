import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/use_case/get_owner_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/owner_update_usecase.dart';

part 'owner_profile_event.dart';
part 'owner_profile_state.dart';

class OwnerProfileBloc extends Bloc<ProfileEvent, OwnerProfileState> {
  final GetOwnerUsecase getOwnerUsecase;
  final UpdateOwnerUsecase updateOwnerUsecase;
  TokenSharedPrefs tokenSharedPrefs;
  OwnerProfileBloc({
    required TokenSharedPrefs tokenSharedPrefs,
    required UpdateOwnerUsecase updateOwnerUsecase,
    required GetOwnerUsecase getOwnerUsecase,
  })  : tokenSharedPrefs = tokenSharedPrefs,
        getOwnerUsecase = getOwnerUsecase,
        updateOwnerUsecase = updateOwnerUsecase,
        super(
          const OwnerProfileState.initial(),
        ) {
    on<NavigatetoProfile>((event, emit) {
      final ownerprofileBloc = getIt<OwnerProfileBloc>();
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: ownerprofileBloc, child: event.destination),
        ),
      );
    });
    on<UpdateOwnerEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final result = await updateOwnerUsecase.call(event.owner);
        print('RESULT:: $result');
        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
          },
          (owner) {
            emit(state.copyWith(
                isLoading: false, isSuccess: true, owner: owner));
          },
        );
      } catch (e) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        print("Exception occurred: $e");
      }
    });
  }

  Future<void> loadClient() async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await getOwnerUsecase.call();
      print('RESULT:::::: $result');
      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
        },
        (owner) {
          emit(state.copyWith(isLoading: false, owner: owner));
        },
      );
      //   },
    } catch (e) {
      emit(state.copyWith(isLoading: false, isSuccess: false));
      print("Exception occurred: $e");

      // return Left(e.toString());
    }
  }
}
