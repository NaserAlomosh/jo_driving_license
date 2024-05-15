abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState(this.message);
}

final class SignUpConfirmPasswordState extends SignUpState {}

final class SignUpSelectImageState extends SignUpState {}
