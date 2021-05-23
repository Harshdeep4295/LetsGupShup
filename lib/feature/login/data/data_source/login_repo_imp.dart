import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letsgupshup/core/utils/injector.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel?> logIn();
  Future<void> logOut();
}

class LoginDataSourceImp extends LoginDataSource {
  @override
  Future<UserModel?> logIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);

    user = userCredential.user;

    if (user != null) {
      UserModel model = UserModel.copyWith(user);

      return model;
    }
    return null;
  }

  @override
  Future<void> logOut() async {
    await googleSignIn.signOut();
  }
}
