part of 'bookings_bloc.dart';

class BookingState extends Equatable {
  final List<BookingEntity> bookings;
  final bool isLoading;
  final String? error;

  const BookingState({
    required this.bookings,
    this.isLoading = false,
    this.error,
  });

  factory BookingState.initial() {
    return const BookingState(
      bookings: [],
      isLoading: false,
    );
  }

  BookingState copyWith({
    List<BookingEntity>? bookings,
    bool? isLoading,
    String? error,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [bookings, isLoading, error];
}
