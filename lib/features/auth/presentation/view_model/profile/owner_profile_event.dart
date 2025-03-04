part of 'owner_profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class NavigatetoProfile extends ProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigatetoProfile({required this.context, required this.destination});
}

class UpdateProfilePicture extends ProfileEvent {}

class UpdateOwnerEvent extends ProfileEvent {
  final PetOwnerEntity owner;

  const UpdateOwnerEvent({required this.owner});

  @override
  List<Object> get props => [owner];
}
