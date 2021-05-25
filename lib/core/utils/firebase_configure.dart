import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FireBaseConfig {
  static firebase_core.FirebaseApp? firebaseApp;

  initFirebase() async {
    await _initializeFirebase();
  }

  static const String FIREBASE_APP_NAME = "LetsGupShup";
  // ignore: missing_return
  Future<void> _initializeFirebase() async {
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
    } on Exception catch (exception) {
      debugPrint("$exception");
      firebaseApp = firebase_core.Firebase.apps.first;
    } on Error catch (error) {
      debugPrint("$error");
    }
  }

  Future<List<DocumentSnapshot>> getQueryDocs(
    String query,
  ) async {
    List<DocumentSnapshot> docs = [];
    QuerySnapshot<Map<String, dynamic>> queries =
        await FirebaseFirestore.instanceFor(app: firebaseApp!)
            .collection(query)
            .limit(20)
            .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> querySnapshot
        in queries.docs) {
      docs.add(querySnapshot);
      // break;
    }

    return docs;
  }

  Future<void> update(
    String collection,
    String docid,
    Map<String, dynamic> updatedValues,
  ) async {
    var getdocs = await FirebaseFirestore.instanceFor(app: firebaseApp!)
        .collection(collection)
        .doc(docid)
        .get();

    if (getdocs.exists) {
      await FirebaseFirestore.instanceFor(app: firebaseApp!)
          .collection(collection)
          .doc(docid)
          .update(updatedValues);
    } else {
      await FirebaseFirestore.instanceFor(app: firebaseApp!)
          .collection(collection)
          .doc(docid)
          .set(updatedValues);
    }
  }

  void sendMessage(String type, String content, String peerId, String id,
      String groupChatId) {
    var documentReference = FirebaseFirestore.instanceFor(app: firebaseApp!)
        .collection('chats')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instanceFor(app: firebaseApp!)
        .runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'idFrom': id,
          'idTo': peerId,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': content,
          'type': type
        },
      );
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String groupChatId) {
    return FirebaseFirestore.instanceFor(app: firebaseApp!)
        .collection('chats')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  uploadFile(String filePath, Function(String) urlFunction) {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instanceFor(
      app: firebaseApp,
      bucket: "gs://letsgupshups.appspot.com",
    );
    firebase_storage.Reference ref = storage.ref().child(fileName);
    final firebase_storage.UploadTask uploadTask = (ref.putFile(
      File(filePath),
      firebase_storage.SettableMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'profile_image': 'test'},
      ),
    ));

    uploadTask.snapshotEvents.listen((event) async {
      if (uploadTask.snapshot.state == firebase_storage.TaskState.success) {
        String url = await ref.getDownloadURL();
        urlFunction(url);
        uploadTask.cancel();
      }
    });
  }
}
