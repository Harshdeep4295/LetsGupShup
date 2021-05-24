import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

abstract class DashboardState {
  List<UserModel>? model;
  DashboardState(this.model);
}

class UserLoading extends DashboardState {
  UserLoading() : super(null);
}

class UsersLoaded extends DashboardState {
  UsersLoaded(List<UserModel>? model) : super(model);
}

class DashboardError extends DashboardState {
  final String error;
  DashboardError(List<UserModel>? model, this.error) : super(model);
}
