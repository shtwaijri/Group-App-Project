part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

//event for pressing the signup button
class SignupPressed extends SignupEvent {
  final String email;
  final String password;

  SignupPressed({required this.email, required this.password});
}

//event for email validation,
class EmailEntered extends SignupEvent {
  final String email;

  EmailEntered(this.email);
}
//event for password validation,

class PasswordEntered extends SignupEvent {
  final String password;

  PasswordEntered(this.password);
}
