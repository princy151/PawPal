import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/booking/domain/entity/booking_entity.dart';
import 'package:pawpal/features/booking/domain/repository/booking_repository.dart';

class CreateBookingParams extends Equatable {
  final String? bookingId;
  final String ownerId;
  final String sitterId;
  final String petId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final DateTime? createdAt;

  const CreateBookingParams({
    this.bookingId,
    required this.ownerId,
    required this.sitterId,
    required this.petId,
    this.startDate,
    this.endDate,
    this.status = "pending",
    this.createdAt,
  });

  // Empty constructor
  const CreateBookingParams.empty()
      : bookingId = '_empty.string',
        ownerId = '_empty.string',
        sitterId = '_empty.string',
        petId = '_empty.string',
        startDate = null,
        endDate = null,
        status = "pending",
        createdAt = null;

  @override
  List<Object?> get props => [bookingId, ownerId, sitterId, petId, startDate, endDate, status, createdAt];
}

class CreateBookingUseCase
    implements UsecaseWithParams<void, CreateBookingParams> {
  final IBookingRepository bookingRepository;

  CreateBookingUseCase({required this.bookingRepository});

  @override
  Future<Either<Failure, void>> call(CreateBookingParams params) async {
    return await bookingRepository.createBooking(
      BookingEntity(
        bookingId: params.bookingId,
        ownerId: params.ownerId,
        sitterId: params.sitterId,
        petId: params.petId,
        startDate: params.startDate,
        endDate: params.endDate,
        status: params.status,
        createdAt: params.createdAt,
      ),
    );
  }
}
