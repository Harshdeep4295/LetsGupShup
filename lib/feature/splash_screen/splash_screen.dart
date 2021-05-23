import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letsgupshup/core/routes/route_names.dart';
import 'package:letsgupshup/core/routes/routing.dart';
import 'package:letsgupshup/core/utils/injector.dart';
import 'package:letsgupshup/core/widgets/my_custom_text_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkUserLogin();
  }

  checkUserLogin() async {
    bool value = await getSharedPrefernce().isUserLoggedIn;

    if (value) {
      AppRouting.navigateTo(DASHBOARD_SCREEN);
    } else {
      AppRouting.navigateTo(LOGIN_SCREEN);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialising the screenutils
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      orientation: Orientation.portrait,
      designSize: Size(480, 810),
    );

    return Scaffold(
      body: Container(
        child: Center(
          child: MediumTextView('Welcome to Lets GupShup'),
        ),
      ),
    );
  }
}
