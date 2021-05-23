import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:letsgupshup/core/routes/route_names.dart';
import 'package:letsgupshup/core/widgets/my_custom_text_widget.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc.dart';
import 'package:letsgupshup/feature/login/data/data_source/login_repo_imp.dart';
import 'package:letsgupshup/feature/login/data/repository_imp/login_repository_imp.dart';
import 'package:letsgupshup/feature/login/screen/login_screen.dart';
import 'package:letsgupshup/feature/splash_screen/splash_screen.dart';

class AppRouting {
  static void navigateTo(String name) {
    Get.offAndToNamed(name);
  }

  static getBack() {
    Get.back();
  }
}

class RoutesGeneration {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    Route<dynamic> route;
    String? navigateToRouteName = settings.name;

    switch (navigateToRouteName) {
      case LOGIN_SCREEN:
        LoginBloc _loginBloc = LoginBloc(
          repository: LoginRepositoryImpl(dataSource: LoginDataSourceImp()),
        );
        route = GetPageRoute(
          page: () => BlocProvider(
            create: (context) => _loginBloc,
            child: LoginScreen(bloc: _loginBloc),
          ),
        );
        break;
      case DASHBOARD_SCREEN:
        route = GetPageRoute(
          page: () => Container(
            child: MediumTextView("Welcome to dashboard"),
          ),
        );
        break;
      default:
        route = GetPageRoute(
          page: () => SplashScreen(),
        );
    }

    return route;
  }
}
