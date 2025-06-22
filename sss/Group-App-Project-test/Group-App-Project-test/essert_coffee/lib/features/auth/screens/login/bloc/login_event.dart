part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginEmailEntered extends LoginEvent {
  final String email;
  LoginEmailEntered(this.email);
}

class LoginPasswordEntered extends LoginEvent {
  final String password;
  LoginPasswordEntered(this.password);
}

class LoginPressed extends LoginEvent {
  final String email;
  final String password;

  LoginPressed({required this.email, required this.password});
}
