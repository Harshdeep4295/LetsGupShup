import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String deviceToken;
  final String password;
  final bool status;
  final int timestamp;
  final String? photoUrl;
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.deviceToken,
    required this.password,
    required this.status,
    required this.timestamp,
    this.photoUrl,
  });
  @override
  List<Object?> get props => [id, email, name, deviceToken];

  static UserModel copyWith(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? "-",
      name: user.displayName ?? "-",
      deviceToken: user.refreshToken ?? "-",
      password: "--",
      status: user.emailVerified,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      photoUrl: user.photoURL,
    );
  }

  toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "photoUrl": this.photoUrl,
      "timestamp": this.timestamp,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        email: json["email"],
        name: json["name"].toString() == "-"
            ? json["email"]
                .toString()
                .substring(0, json["email"].toString().indexOf("@"))
            : json["name"],
        deviceToken: "deviceToken",
        password: "password",
        status: false,
        timestamp: 231312,
        photoUrl: json["photoUrl"]);
  }
}
