import 'package:get/instance_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letsgupshup/core/utils/firebase_configure.dart';
import 'package:letsgupshup/core/utils/shared_pref.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc.dart';
import 'package:letsgupshup/feature/login/data/data_source/login_repo_imp.dart';
import 'package:letsgupshup/feature/login/data/repository_imp/login_repository_imp.dart';

// final sl = Get.create(() => null)
final GoogleSignIn googleSignIn = GoogleSignIn();
Future<void> init() async {
  AppPreferences prefernce = AppPreferences();
  Get.lazyPut(() => prefernce, fenix: true);
  setLoginBloc();
  await FireBaseConfig().initFirebase();
}

AppPreferences getSharedPrefernce() {
  return Get.find();
}

void setLoginBloc() {
  LoginBloc loginBloc = LoginBloc(
    repository: LoginRepositoryImpl(dataSource: LoginDataSourceImp()),
  );
  Get.lazyPut(() => loginBloc, fenix: true);
}

LoginBloc getLoginBloc() {
  return Get.find();
}
