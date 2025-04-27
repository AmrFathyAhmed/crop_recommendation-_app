abstract class SignUpState {}

class SignUpInit extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  String successMessage;
  SignUpSuccess({required this.successMessage});
}

class SignUpFailure extends SignUpState {
  String errorMessage;

  SignUpFailure({required this.errorMessage});


}
