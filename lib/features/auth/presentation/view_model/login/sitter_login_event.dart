part of 'sitter_login_bloc.dart';

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

class NavigateSitterHomeScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateSitterHomeScreenEvent({
    required this.context,
    required this.destination,
  });
}

class LoginSitterEvent extends LoginEvent {
  final BuildContext context;
  final String username;
  final String password;

  const LoginSitterEvent({
    required this.context,
    required this.username,
    required this.password,
  });
}
