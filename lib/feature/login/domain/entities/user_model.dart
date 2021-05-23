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

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.deviceToken,
    required this.password,
    required this.status,
    required this.timestamp,
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
    );
  }
}
