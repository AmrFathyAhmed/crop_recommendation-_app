abstract class LoginState {}

class LoginInit extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  String errorMessage;

  LoginFailure({required this.errorMessage});


}
