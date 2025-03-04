import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/auth/domain/use_case/get_sitter_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/sitter_update_usecase.dart';


part 'sitter_profile_event.dart';
part 'sitter_profile_state.dart';

class SitterProfileBloc extends Bloc<ProfileEvent, SitterProfileState> {
  final GetSitterUsecase getSitterUsecase;
  final UpdateSitterUsecase updateSitterUsecase;
  TokenSharedPrefs tokenSharedPrefs;
  SitterProfileBloc({
    required TokenSharedPrefs tokenSharedPrefs,
    required UpdateSitterUsecase updateSitterUsecase,
    required GetSitterUsecase getSitterUsecase,
  })  : tokenSharedPrefs = tokenSharedPrefs,
        getSitterUsecase = getSitterUsecase,
        updateSitterUsecase = updateSitterUsecase,
        super(
          const SitterProfileState.initial(),
        ) {
    on<NavigatetoProfile>((event, emit) {
      final sitterprofileBloc = getIt<SitterProfileBloc>();
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: sitterprofileBloc, child: event.destination),
        ),
      );
});
    on<UpdateSitterEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final result = await updateSitterUsecase.call(event.sitter);
        print('RESULT:: $result');
        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
          },
          (sitter) {
            emit(state.copyWith(
                isLoading: false,
                isSuccess: true,
                sitter: sitter)); 
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
      final result = await getSitterUsecase.call();
      print('RESULT:::::: $result');
      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
        },
        (sitter) {
          // print('sitter::: $sitter');
          emit(state.copyWith(isLoading: false, sitter: sitter));
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
