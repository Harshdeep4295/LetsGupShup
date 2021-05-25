import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({required this.message});
  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message: message);
}

class Errors extends Failure {
  Errors(String message) : super(message: message);
}
