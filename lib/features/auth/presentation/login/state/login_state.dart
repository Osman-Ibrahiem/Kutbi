import '../../../domain/models/user_model.dart';

sealed class LoginState {}

class Initial extends LoginState {}

class Loading extends LoginState {}

class Success extends LoginState {
  final UserModel user;

  Success(this.user);
}

class Failure extends LoginState {
  final String message;

  Failure(this.message);
}
