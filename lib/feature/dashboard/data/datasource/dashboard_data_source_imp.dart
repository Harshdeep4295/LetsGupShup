import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letsgupshup/core/utils/firebase_configure.dart';
import 'package:letsgupshup/feature/dashboard/data/model/user_model_firebase.dart';
import 'package:letsgupshup/feature/dashboard/domain/usecase/usecase.dart';

class DashboardDataSourceImp extends DashboardDataSource {
  @override
  Future<List<DisplayUsers>> getUsersList() async {
    List<DocumentSnapshot<Object?>> userQuery =
        await FireBaseConfig().getQueryDocs('users');

    List<DisplayUsers> users = [];

    for (DocumentSnapshot snapshot in userQuery) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (!data["id"].toString().endsWith(
            FirebaseAuth.instance.currentUser!.uid,
          ))
        users.add(
            DisplayUsers.fromJson(snapshot.data() as Map<String, dynamic>));
    }

    return users;
  }
}
