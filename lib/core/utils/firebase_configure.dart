import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';

class FireBaseConfig {
  static firebase_core.FirebaseApp? firebaseApp;

  initFirebase() async {
    await _initializeFirebase();
  }

  static const String FIREBASE_APP_NAME = "LetsGupShup";
  // ignore: missing_return
  Future<firebase_core.FirebaseApp?> _initializeFirebase() async {
    try {
      firebaseApp = await firebase_core.Firebase.initializeApp(
        name: FIREBASE_APP_NAME,
        options: firebase_core.FirebaseOptions(
          appId: "1:687868420895:android:66559dd365caa751d1462a",
          messagingSenderId: "687868420895",
          apiKey: "AIzaSyAdgHJeaKqEq9lePmg_ds8gkth-4voLYHA",
          projectId: "letsgupshups",
        ),
      );
      return firebaseApp;
    } on Exception catch (exception) {
      debugPrint("$exception");
    } on Error catch (error) {
      debugPrint("$error");
    }

    return null;
  }
}
