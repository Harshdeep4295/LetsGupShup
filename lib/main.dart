import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:letsgupshup/core/routes/routing.dart';
import 'package:letsgupshup/core/utils/injector.dart';

void main() {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await init();
    runApp(AppContext());
  });
}

class AppContext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      onGenerateRoute: (settings) => RoutesGeneration.generateRoutes(settings),
    );
  }
}
