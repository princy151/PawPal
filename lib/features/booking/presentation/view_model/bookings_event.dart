part of 'bookings_bloc.dart';

@immutable
sealed class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

final class LoadBookings extends BookingsEvent {}

class LoadImage extends BookingsEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

final class AddBooking extends BookingsEvent {
  final BuildContext context;
  final String? bookingId;
  final String ownerId;
  final String sitterId;
  final String petId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final DateTime? createdAt;

  const AddBooking(
    this.bookingId,
    this.context,
    this.ownerId,
    this.sitterId,
    this.petId,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
  );

  @override
  List<Object> get props => [context, ownerId, sitterId, petId, status];
}

final class DeleteBooking extends BookingsEvent {
  final String bookingId;

  const DeleteBooking({required this.bookingId});

  @override
  List<Object> get props => [bookingId];
}
