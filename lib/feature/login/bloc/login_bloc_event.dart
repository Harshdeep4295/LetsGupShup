abstract class LoginEvent {}

class MakeUserLoginEvent extends LoginEvent {}

class UserLogInSuccess extends LoginEvent {
  final bool loggedIn;
  UserLogInSuccess({required this.loggedIn});
}

class UserLogInError extends LoginEvent {
  final String error;
  UserLogInError(this.error);
}
