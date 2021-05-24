import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/feature/dashboard/bloc/dashboard_bloc_events.dart';
import 'package:letsgupshup/feature/dashboard/bloc/dashboard_bloc_state.dart';
import 'package:letsgupshup/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc({
    required this.repository,
  }) : super(UserLoading()) {
    this.add(LoadUser());
  }

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    try {
      if (event is LoadUser) {
        yield UserLoading();

        final user = await repository.getUsersList();
        yield user.fold((List<UserModel> value) {
          return UsersLoaded(value);
        }, (Failure fail) {
          return DashboardError(this.state.model, fail.message);
        });
      }
    } catch (_) {
      yield DashboardError(this.state.model, "Please Login to continue.");
    }
  }
}
