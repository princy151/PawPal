import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pawpal/features/booking/domain/entity/booking_entity.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? bookingId;
  final String ownerId;
  final String sitterId;
  final String petId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final DateTime? createdAt;

  const BookingApiModel({
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
  BookingApiModel.empty()
      : bookingId = '',
        ownerId = '',
        sitterId = '',
        petId = '',
        startDate = null,
        endDate = null,
        status = "pending",
        createdAt = null;

  // From Json
  factory BookingApiModel.fromJson(Map<String, dynamic> json) {
    try {
      return BookingApiModel(
        bookingId: json['_id']?.toString() ?? '',
        ownerId: json['ownerId']?.toString() ?? '',
        sitterId: json['sitterId']?.toString() ?? '',
        petId: json['petId']?.toString() ?? '',
        startDate: json['startDate'] != null
            ? DateTime.parse(json['startDate'].toString())
            : null,
        endDate: json['endDate'] != null
            ? DateTime.parse(json['endDate'].toString())
            : null,
        status: json['status']?.toString() ?? "pending",
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'].toString())
            : null,
      );
    } catch (e) {
      print('BookingApiModel.fromJson: $e');
      return BookingApiModel.empty();
    }
  }

  // To Json
  Map<String, dynamic> toJson() {
    return {
      '_id': bookingId,
      'ownerId': ownerId,
      'sitterId': sitterId,
      'petId': petId,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Convert API Object to Entity
  BookingEntity toEntity() => BookingEntity(
        bookingId: bookingId,
        ownerId: ownerId,
        sitterId: sitterId,
        petId: petId,
        startDate: startDate,
        endDate: endDate,
        status: status,
        createdAt: createdAt,
      );

  // Convert Entity to API Object
  static BookingApiModel fromEntity(BookingEntity entity) => BookingApiModel(
        bookingId: entity.bookingId,
        ownerId: entity.ownerId,
        sitterId: entity.sitterId,
        petId: entity.petId,
        startDate: entity.startDate,
        endDate: entity.endDate,
        status: entity.status,
        createdAt: entity.createdAt,
      );

  // Convert API List to Entity List
  static List<BookingEntity> toEntityList(List<BookingApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        bookingId,
        ownerId,
        sitterId,
        petId,
        startDate,
        endDate,
        status,
        createdAt,
      ];
}