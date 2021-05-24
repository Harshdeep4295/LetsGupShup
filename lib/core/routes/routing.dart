import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:letsgupshup/core/routes/route_names.dart';
import 'package:letsgupshup/core/utils/injector.dart';
import 'package:letsgupshup/core/widgets/my_custom_text_widget.dart';
import 'package:letsgupshup/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:letsgupshup/feature/dashboard/data/datasource/dashboard_data_source_imp.dart';
import 'package:letsgupshup/feature/dashboard/data/repository/dashboard_repo_impl.dart';
import 'package:letsgupshup/feature/dashboard/screen/dashboard.dart';
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
        route = GetPageRoute(
          page: () => BlocProvider(
            create: (context) => getLoginBloc(),
            child: LoginScreen(
              bloc: getLoginBloc(),
            ),
          ),
        );
        break;
      case DASHBOARD_SCREEN:
        DashboardBloc _dashboardBloc = DashboardBloc(
          repository: DashBoardRepositoryImpl(
            source: DashboardDataSourceImp(),
          ),
        );
        route = GetPageRoute(
          page: () => BlocProvider(
            create: (context) => _dashboardBloc,
            child: Dashboard(bloc: _dashboardBloc),
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
