import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letsgupshup/core/utils/firebase_configure.dart';
import 'package:letsgupshup/core/utils/injector.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel?> logIn();
  Future<UserModel?> logInUsingEmail(String email, String password);
  Future<void> logOut();
  Future<void> addUserToFireStore(UserModel model);
  Future<UserModel?> signupUsingEmail(String email, password);
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
    DocumentSnapshot<Map<String, dynamic>> userReference =
        await FirebaseFirestore.instanceFor(app: FireBaseConfig.firebaseApp!)
            .collection('users')
            .doc(model.id)
            .get();
    // user.add(model.toJson());

    if (!userReference.exists) {
      FirebaseFirestore.instanceFor(app: FireBaseConfig.firebaseApp!)
          .runTransaction((transaction) async {
        transaction.set(
          userReference.reference,
          model.toJson(),
        );
      });
    }
  }

  @override
  Future<UserModel?> logInUsingEmail(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    user = userCredential.user;

    if (user != null) {
      UserModel model = UserModel.copyWith(user);

      return model;
    }
    return null;
  }

  @override
  Future<UserModel?> signupUsingEmail(String email, password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;

    if (user != null) {
      UserModel model = UserModel.copyWith(user);

      return model;
    }
    return null;
  }
}
