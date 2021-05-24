abstract class DashboardEvent {}

class LoadUser extends DashboardEvent {}

class Loading extends DashboardEvent {}

class UserLoaded extends DashboardEvent {
  UserLoaded();
}

class DashboardErrors extends DashboardEvent {
  DashboardErrors();
}
