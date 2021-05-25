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
          return UserLoggedInState(message: 'Sign in successfully');
        }, (Failure fail) {
          return UserLoggedInFailed(fail.message);
        });
      } else if (event is SignInWithEmail) {
        yield LoadingState();

        final user =
            await repository.signInWithEmail(event.email, event.password);
        yield user.fold((bool value) {
          AppRouting.navigateTo(DASHBOARD_SCREEN);
          return UserLoggedInState(message: 'Sign in successfully');
        }, (Failure fail) {
          return UserLoggedInFailed(fail.message.contains("user-not-found")
              ? "Please Register First."
              : "Wrong password try again!");
        });
      } else if (event is CreateUserWithEmail) {
        yield LoadingState();

        final user =
            await repository.createUserWithEmail(event.email, event.password);
        yield user.fold((bool value) {
          AppRouting.navigateTo(DASHBOARD_SCREEN);
          return UserLoggedInState(message: 'Sign in successfully');
        }, (Failure fail) {
          return UserLoggedInFailed(fail.message);
        });
      }
    } on Exception catch (ex) {
      yield UserLoggedInFailed("Please Login to continue.");
    } on Error catch (error) {
      yield UserLoggedInFailed("Please Login to continue.");
    }
  }
}
