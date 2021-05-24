import 'package:dartz/dartz.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/core/utils/shared_pref.dart';
import 'package:letsgupshup/feature/login/data/data_source/login_repo_imp.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';
import 'package:letsgupshup/feature/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  LoginDataSource dataSource;
  LoginRepositoryImpl({
    required this.dataSource,
  });

  @override
  void addModelToPrefrence(UserModel model) {
    AppPreferences().setEmail(model.email);
    AppPreferences().setId(model.id);
    AppPreferences().setName(model.name);
    AppPreferences().setLoggedIn(true);
  }

  @override
  Future<void> logOut() async {
    await dataSource.logOut();
  }

  @override
  Future<Either<bool, Failure>> signInWithGoogle() async {
    try {
      UserModel? user = await dataSource.logIn();
      if (user != null) {
        addModelToPrefrence(user);
        addUserToFirestore(user);
        return Left(true);
      }
    } on Exception catch (ex) {
      return Right(Error(ex.toString()));
    } on Error catch (error) {
      return Right(Error(error.message));
    }
    return Left(false);
  }

  @override
  Future<void> addUserToFirestore(UserModel model) async {
    await dataSource.addUserToFireStore(model);
  }
}
