import 'package:dartz/dartz.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

abstract class LoginRepository {
  Future<Either<bool, Failure>> signInWithGoogle();
  Future<Either<bool, Failure>> signInWithEmail(String email, String password);
  Future<Either<bool, Failure>> createUserWithEmail(
      String email, String password);
  void logOut();
  void addModelToPrefrence(UserModel model);
  void addUserToFirestore(UserModel model);
}
