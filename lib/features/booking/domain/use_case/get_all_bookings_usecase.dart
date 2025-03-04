import 'package:dartz/dartz.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/booking/domain/entity/booking_entity.dart';
import 'package:pawpal/features/booking/domain/repository/booking_repository.dart';


class GetAllBookingsUseCase implements UsecaseWithoutParams<List<BookingEntity>> {
  final IBookingRepository bookingRepository;

  GetAllBookingsUseCase({required this.bookingRepository});

  @override
  Future<Either<Failure, List<BookingEntity>>> call() {
    print('GetAllBookingUseCase called');
    return bookingRepository.getBookings();
  }
}
