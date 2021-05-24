import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

class DisplayUsers extends UserModel {
  String firebaseId;
  final String id;
  final String email;
  final String name;
  final String deviceToken;
  final bool status;
  final int timestamp;
  final String? photoUrl;
  DisplayUsers({
    required this.firebaseId,
    required this.id,
    required this.email,
    required this.name,
    required this.deviceToken,
    required this.status,
    required this.timestamp,
    this.photoUrl,
  }) : super(
          id: id,
          email: email,
          name: name,
          deviceToken: deviceToken,
          password: "", // enabling sign in wih google
          status: status,
          timestamp: timestamp,
        );

  static DisplayUsers fromJson(Map<String, dynamic> data) {
    UserModel model = UserModel.fromJson(data);
    return DisplayUsers(
      firebaseId: data["id"],
      email: model.email,
      id: model.id,
      deviceToken: model.deviceToken,
      name: model.name,
      status: model.status,
      timestamp: model.timestamp,
      photoUrl: model.photoUrl,
    );
  }
}
