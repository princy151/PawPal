import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String? bookingId;
  final String ownerId;
  final String sitterId;
  final String petId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final DateTime? createdAt;

  const BookingEntity({
    this.bookingId,
    required this.ownerId,
    required this.sitterId,
    required this.petId,
    this.startDate,
    this.endDate,
    this.status = "pending",
    this.createdAt,
  });

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

  // Convert JSON to BookingEntity
  factory BookingEntity.fromJson(Map<String, dynamic> json) {
    return BookingEntity(
      bookingId: json['_id'],
      ownerId: json['ownerId'],
      sitterId: json['sitterId'],
      petId: json['petId'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      status: json['status'] ?? "pending",
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  // Convert BookingEntity to JSON
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
}