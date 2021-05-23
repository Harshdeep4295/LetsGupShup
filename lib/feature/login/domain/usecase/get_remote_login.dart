import 'dart:ffi';

import 'package:letsgupshup/core/usecase/failure_model.dart';
import 'package:dartz/dartz.dart';
import 'package:letsgupshup/core/usecase/use_case.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';
import 'package:letsgupshup/feature/login/domain/repository/login_repository.dart';

class SignIn implements UseCase<UserModel, Void> {
  final LoginRepository repository;

  SignIn({required this.repository});
  @override
  Future<Either<Failure, UserModel>> call(params) {
    throw UnimplementedError();
  }
}
