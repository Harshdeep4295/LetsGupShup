import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letsgupshup/core/utils/firebase_configure.dart';
import 'package:letsgupshup/core/utils/injector.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel?> logIn();
  Future<void> logOut();
  Future<void> addUserToFireStore(UserModel model);
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

  @override
  Future<void> addUserToFireStore(UserModel model) async {
    final userReference =
        FirebaseFirestore.instanceFor(app: FireBaseConfig.firebaseApp!)
            .collection('users');
    // user.add(model.toJson());

    FirebaseFirestore.instanceFor(app: FireBaseConfig.firebaseApp!)
        .runTransaction((transaction) async {
      transaction.set(
        userReference.doc(),
        model.toJson(),
      );
    });
  }
}
