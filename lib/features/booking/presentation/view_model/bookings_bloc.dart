import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/features/booking/domain/entity/booking_entity.dart';
import 'package:pawpal/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:pawpal/features/booking/domain/use_case/delete_booking_usecase.dart';
import 'package:pawpal/features/booking/domain/use_case/get_all_bookings_usecase.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingState> {
  final CreateBookingUseCase _createBookingUseCase;
  final GetAllBookingsUseCase _getAllBookingsUseCase;
  final DeleteBookingUsecase _deleteBookingUsecase;

  BookingsBloc({
    required CreateBookingUseCase createBookingUseCase,
    required GetAllBookingsUseCase getAllBookingsUseCase,
    required DeleteBookingUsecase deleteBookingUsecase,
  })  : _createBookingUseCase = createBookingUseCase,
        _getAllBookingsUseCase = getAllBookingsUseCase,
        _deleteBookingUsecase = deleteBookingUsecase,
        super(BookingState.initial()) {
    on<LoadBookings>(_onLoadBookings);
    on<AddBooking>(_onAddBooking);
    on<DeleteBooking>(_onDeleteBooking);

    // Call this event whenever the bloc is created to load the Bookings
    add(LoadBookings());
  }

  Future<void> _onLoadBookings(
      LoadBookings event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllBookingsUseCase.call();
    print('Result: $result');
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (bookings) => emit(state.copyWith(isLoading: false, bookings: bookings)),
    );
  }

  Future<void> _onAddBooking(
      AddBooking event, Emitter<BookingState> emit) async {
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

  Future<void> _onDeleteBooking(
      DeleteBooking event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteBookingUsecase
        .call(DeleteBookingParams(bookingId: event.bookingId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBookings());
      },
    );
  }
}
