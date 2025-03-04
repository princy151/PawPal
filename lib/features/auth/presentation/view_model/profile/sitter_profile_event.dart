part of 'sitter_profile_bloc.dart';

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

class UpdateSitterEvent extends ProfileEvent {
  final PetSitterEntity sitter;

  const UpdateSitterEvent({required this.sitter});

  @override
  List<Object> get props => [sitter];
}
