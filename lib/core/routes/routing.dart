import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
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
      default:
        route = GetPageRoute(
          page: () => SplashScreen(),
        );
    }

    return route;
  }
}
