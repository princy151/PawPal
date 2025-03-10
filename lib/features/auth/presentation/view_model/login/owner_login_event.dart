part of 'owner_login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class NavigateRegisterScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateRegisterScreenEvent({
    required this.context,
    required this.destination,
  });
}

class NavigateHomeScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeScreenEvent({
    required this.context,
    required this.destination,
  });
}

class NavigateSitterHomeScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateSitterHomeScreenEvent({
    required this.context,
    required this.destination,
  });
}

class LoginOwnerEvent extends LoginEvent {
  final BuildContext context;
  final String username;
  final String password;

  const LoginOwnerEvent({
    required this.context,
    required this.username,
    required this.password,
  });
}
