import 'package:kutbi/domain/models/user_model.dart';

sealed class RegisterState {}

class Initial extends RegisterState {}

class Loading extends RegisterState {}

class Success extends RegisterState {
  final UserModel user;

  Success(this.user);
}

class Failure extends RegisterState {
  final String message;

  Failure(this.message);
}
