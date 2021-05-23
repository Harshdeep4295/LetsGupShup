import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsgupshup/core/routes/route_names.dart';
import 'package:letsgupshup/core/routes/routing.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc_event.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc_states.dart';

import 'package:letsgupshup/feature/login/domain/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({
    required this.repository,
  }) : super(UserNotLoggedInState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is MakeUserLoginEvent) {
        yield LoadingState();

        final user = await repository.signInWithGoogle();
        yield user.fold((bool value) {
          AppRouting.navigateTo(DASHBOARD_SCREEN);
          return LoadingState();
        }, (Failure fail) {
          return UserLoggedInFailed(fail.message);
        });
        // if (value is bool && value) {

        // } else
        //   yield UserLoggedInFailed("Please Login to continue.");
      }
    } catch (_) {
      yield UserLoggedInFailed("Please Login to continue.");
    }
  }
}
