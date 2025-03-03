import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/auth/domain/use_case/get_all_sitters_usecase.dart';

part 'owner_dashboard_event.dart';
part 'owner_dashboard_state.dart';

class OwnerDashboardBloc extends Bloc<OwnerDashboardEvent, OwnerDashboardState> {
  final GetAllSitterUseCase _getAllSitterUseCase;


  OwnerDashboardBloc({
    
    required GetAllSitterUseCase getAllSitterUseCase,
    
  })  : 
        _getAllSitterUseCase = getAllSitterUseCase,
        
        super(OwnerDashboardState.initial()) {
    on<LoadSitters>(_onLoadSitters);


    // Call this event whenever the bloc is created to load the Sitters
    add(LoadSitters());
  }

  Future<void> _onLoadSitters(LoadSitters event, Emitter<OwnerDashboardState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllSitterUseCase.call();
    print('Result: $result');
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (sitters) => emit(state.copyWith(isLoading: false, sitters: sitters)),
    );
  }
}