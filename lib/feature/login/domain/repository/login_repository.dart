import 'package:dartz/dartz.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

abstract class LoginRepository {
  Future<Either<bool, Failure>> signInWithGoogle();
  void logOut();
  void addModelToPrefrence(UserModel model);
  void addUserToFirestore(UserModel model);
}
