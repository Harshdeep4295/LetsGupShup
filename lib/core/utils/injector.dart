import 'package:get/instance_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letsgupshup/core/utils/firebase_configure.dart';
import 'package:letsgupshup/core/utils/shared_pref.dart';

// final sl = Get.create(() => null)
final GoogleSignIn googleSignIn = GoogleSignIn();
Future<void> init() async {
  AppPreferences prefernce = AppPreferences();
  Get.lazyPut(() => prefernce);

  await FireBaseConfig().initFirebase();
}

AppPreferences getSharedPrefernce() {
  return Get.find();
}
