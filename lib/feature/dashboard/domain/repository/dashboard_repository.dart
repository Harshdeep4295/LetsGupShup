import 'package:dartz/dartz.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

abstract class DashboardRepository {
  Future<Either<List<UserModel>, Failure>> getUsersList();
}
