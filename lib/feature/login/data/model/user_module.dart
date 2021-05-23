import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

class User extends UserModel {
  final String id;
  final String email;
  final String name;
  final String deviceToken;
  final bool status;
  final int timestamp;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.deviceToken,
    required this.status,
    required this.timestamp,
  }) : super(
          id: id,
          email: email,
          name: name,
          deviceToken: deviceToken,
          password: "", // enabling sign in wih google
          status: status,
          timestamp: timestamp,
        );
}
