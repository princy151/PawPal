import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/auth/domain/use_case/get_all_owners_usecase.dart';
import 'package:pawpal/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:pawpal/features/booking/presentation/view_model/bookings_bloc.dart';

part 'sitter_dashboard_event.dart';
part 'sitter_dashboard_state.dart';

class SitterDashboardBloc
    extends Bloc<SitterDashboardEvent, SitterDashboardState> {
  final BookingsBloc _bookingBloc;
  final GetAllOwnerUseCase _getAllOwnerUseCase;
  final CreateBookingUseCase _createBookingUseCase;

  SitterDashboardBloc({
    required GetAllOwnerUseCase getAllOwnerUseCase,
    required CreateBookingUseCase createBookingUseCase,
    required BookingsBloc bookingsBloc,
  })  : _getAllOwnerUseCase = getAllOwnerUseCase,
        _createBookingUseCase = createBookingUseCase,
        _bookingBloc = bookingsBloc,
        super(SitterDashboardState.initial()) {
    on<LoadOwners>(_onLoadOwners);
    on<AddBooking>(_onAddBooking);
    on<NavigatetoItem>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(providers: [
                    BlocProvider.value(value: _bookingBloc),
                  ], child: event.destination)));
    });

    // Call this event whenever the bloc is created to load the Owners
    add(LoadOwners());
  }

  Future<void> _onLoadOwners(
      LoadOwners event, Emitter<SitterDashboardState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllOwnerUseCase.call();
    print('Result: $result');
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (owners) => emit(state.copyWith(isLoading: false, owners: owners)),
    );
  }

  Future<void> _onAddBooking(
      AddBooking event, Emitter<SitterDashboardState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createBookingUseCase.call(CreateBookingParams(
      ownerId: event.ownerId,
      sitterId: event.sitterId,
      petId: event.petId,
      startDate: event.startDate,
      endDate: event.endDate,
      status: event.status,
      createdAt: event.createdAt,
    ));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (bookings) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBookings());
      },
    );
  }
}
