abstract class LoginEvent {}

class MakeUserLoginEvent extends LoginEvent {}

class NotLoaded extends LoginEvent {}

class UserLogInSuccess extends LoginEvent {
  final bool loggedIn;
  UserLogInSuccess({required this.loggedIn});
}

class UserLogInError extends LoginEvent {
  final String error;
  UserLogInError(this.error);
}

class SignInWithEmail extends LoginEvent {
  final String email;
  final String password;
  SignInWithEmail({required this.email, required this.password});
}

class CreateUserWithEmail extends LoginEvent {
  final String email;
  final String password;
  CreateUserWithEmail({required this.email, required this.password});
}
