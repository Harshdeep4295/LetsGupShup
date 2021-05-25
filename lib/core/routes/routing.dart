import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:letsgupshup/core/routes/route_names.dart';
import 'package:letsgupshup/core/utils/injector.dart';
import 'package:letsgupshup/feature/chat/bloc/chat_bloc.dart';
import 'package:letsgupshup/feature/chat/data/datasource/use_case_impl.dart';
import 'package:letsgupshup/feature/chat/data/repoistory_imp/chat_repoistory_impl.dart';
import 'package:letsgupshup/feature/chat/screen/chat.dart';
import 'package:letsgupshup/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:letsgupshup/feature/dashboard/data/datasource/dashboard_data_source_imp.dart';
import 'package:letsgupshup/feature/dashboard/data/repository/dashboard_repo_impl.dart';
import 'package:letsgupshup/feature/dashboard/screen/dashboard.dart';
import 'package:letsgupshup/feature/login/screen/login_screen.dart';
import 'package:letsgupshup/feature/splash_screen/splash_screen.dart';

class AppRouting {
  static void navigateTo(String name) {
    Get.offAndToNamed(name);
  }

  static getBack() {
    Get.back();
  }

  static void navigateWithArgumentTo(String name, arguments) {
    Get.toNamed(
      name,
      arguments: arguments,
    );
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
      case CHAT_SCREEN:
        print((settings.arguments as Map)["peerAvatar"]);
        Map mapData = (settings.arguments as Map);
        ChatBloc chatBloc = ChatBloc(
          repository: ChatRepositoryImp(
            source: ChatDataSourceImp(),
          ),
        );
        route = GetPageRoute(
          page: () => BlocProvider(
            create: (context) => chatBloc,
            child: ChatOneOnOne(
              peerAvatar: mapData["peerAvatar"],
              peerId: mapData["peerId"],
              peerName: mapData["peerName"],
              bloc: chatBloc,
            ),
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
