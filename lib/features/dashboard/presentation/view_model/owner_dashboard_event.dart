part of 'owner_dashboard_bloc.dart';

@immutable
sealed class OwnerDashboardEvent extends Equatable {
  const OwnerDashboardEvent();

  @override
  List<Object> get props => [];
}

final class LoadSitters extends OwnerDashboardEvent {}

class LoadImage extends OwnerDashboardEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

final class AddOwners extends OwnerDashboardEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String? image;

  const AddOwners(this.name, this.email, this.phone, this.password,
      this.address, this.image);

  @override
  List<Object> get props => [name, email, phone, password, address];
}
