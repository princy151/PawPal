part of 'sitter_dashboard_bloc.dart';

@immutable
sealed class SitterDashboardEvent extends Equatable {
  const SitterDashboardEvent();

  @override
  List<Object> get props => [];
}

final class LoadOwners extends SitterDashboardEvent {}

final class LoadBookings extends SitterDashboardEvent {}

class LoadImage extends SitterDashboardEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class NavigatetoItem extends SitterDashboardEvent {
  final BuildContext context;
  final Widget destination;
  final PetSitterEntity product;

  const NavigatetoItem(
      {required this.context,
      required this.destination,
      required this.product});
}

final class AddSitters extends SitterDashboardEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String? image;

  const AddSitters(this.name, this.email, this.phone, this.password,
      this.address, this.image);

  @override
  List<Object> get props => [name, email, phone, password, address];
}

final class AddBooking extends SitterDashboardEvent {
  final String ownerId;
  final String sitterId;
  final String petId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final DateTime? createdAt;

  const AddBooking(
    this.ownerId,
    this.sitterId,
    this.petId,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
  );

  @override
  List<Object> get props => [ownerId, sitterId, petId, status];
}
