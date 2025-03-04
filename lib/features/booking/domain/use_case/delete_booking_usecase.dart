import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/booking/domain/repository/booking_repository.dart';


class DeleteBookingParams extends Equatable {
  final String bookingId;

  const DeleteBookingParams({required this.bookingId});

  const DeleteBookingParams.empty() : bookingId = '_empty.string';

  @override
  List<Object?> get props => [bookingId];
}

class DeleteBookingUsecase implements UsecaseWithParams<void, DeleteBookingParams> {
  final IBookingRepository bookingRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteBookingUsecase({
    required this.bookingRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteBookingParams params) async {
    // Get token from Shared Preferences and send it to the server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await bookingRepository.deleteBooking(params.bookingId, r);
    });
  }
}
