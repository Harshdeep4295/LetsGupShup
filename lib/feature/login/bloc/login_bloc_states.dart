abstract class LoginState {}

class UserNotLoggedInState extends LoginState {}

class UserLoggedInState extends LoginState {
  final String message;

  UserLoggedInState({required this.message});
}

class LoadingState extends LoginState {}

class UserLoggedInFailed extends LoginState {
  final String message;

  UserLoggedInFailed(this.message);
}
