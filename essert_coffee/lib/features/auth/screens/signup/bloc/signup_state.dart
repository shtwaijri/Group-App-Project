part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {
  //declare variables for signup validation
  final String? emailError;
  final String? passwordError;

  SignupInitial({this.emailError, this.passwordError});
}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupFailure extends SignupState {
  //to determeine the type of an error that is occured after signing up
  final String error;

  SignupFailure(this.error);
}
