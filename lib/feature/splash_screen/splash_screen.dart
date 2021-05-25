import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:letsgupshup/core/routes/route_names.dart';
import 'package:letsgupshup/core/routes/routing.dart';
import 'package:letsgupshup/core/styles/app_dimens.dart';
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
    await Future.delayed(Duration(seconds: 3));
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
      backgroundColor: Colors.amber.shade700,
      body: Container(
        child: Hero(
          tag: "spashIcon",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                FontAwesomeIcons.chartPie,
                size: height(100),
              ),
              SizedBox(
                height: height(20),
              ),
              LargeTextView(
                "Lets Gup Sup",
                textColor: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
