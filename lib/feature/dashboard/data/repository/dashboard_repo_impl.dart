import 'package:dartz/dartz.dart';
import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:letsgupshup/feature/dashboard/data/model/user_model_firebase.dart';
import 'package:letsgupshup/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:letsgupshup/feature/dashboard/domain/usecase/usecase.dart';

class DashBoardRepositoryImpl extends DashboardRepository {
  final DashboardDataSource source;
  DashBoardRepositoryImpl({required this.source});
  @override
  Future<Either<List<DisplayUsers>, Failure>> getUsersList() async {
    try {
      return Left(await source.getUsersList());
    } on Exception catch (ex) {
      return Right(Errors(ex.toString()));
    } on Error catch (error) {
      return Right(Errors(error.stackTrace.toString()));
    }
  }
}
