import 'package:pawpal/features/booking/domain/entity/booking_entity.dart';

abstract interface class IBookingDataSource {
  Future<List<BookingEntity>> getBookings();
  Future<void> createBooking(BookingEntity booking);
  Future<void> deleteBooking(String id, String? token);
}
