// ignore_for_file: body_might_complete_normally_nullable, curly_braces_in_flow_control_structures

import 'package:bloc/bloc.dart';
import 'package:essert_coffee/features/auth/auth_service.dart' show AuthService;
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<LoginEmailEntered>((event, emit) {
      final emailError = _validateEmail(event.email);

      final currentState = state;
      String? passwordError;

      if (currentState is LoginInitial) {
        passwordError = currentState.passwordError;
      }

      emit(LoginInitial(emailError: emailError, passwordError: passwordError));
    });

    on<LoginPasswordEntered>((event, emit) {
      final passwordError = _validatePassword(event.password);

      final currentState = state;
      String? emailError;

      if (currentState is LoginInitial) {
        emailError = currentState.emailError;
      }

      emit(LoginInitial(emailError: emailError, passwordError: passwordError));
    });

    on<LoginPressed>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(
    LoginPressed event,
    Emitter<LoginState> emit,
  ) async {
    final emailError = _validateEmail(event.email);
    final passwordError = _validatePassword(event.password);

    if (emailError != null || passwordError != null) {
      emit(LoginInitial(emailError: emailError, passwordError: passwordError));
      return;
    }

    emit(LoginLoading());

    try {
      final result = await authService.signInByEmail(
        event.email,
        event.password,
      );

      if (result.user == null) {
        emit(LoginFailure('Email or password is incorrect'));
        return;
      }

      emit(LoginSuccess());
    } catch (e) {
      if (e.toString().toLowerCase().contains('invalid login credentials')) {
        emit(LoginFailure('Email or password is incorrect'));
      } else {
        emit(LoginFailure('Something went wrong. Please try again.'));
      }
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';

    final regExp = RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$');
    if (!regExp.hasMatch(email)) return 'Email is not correct';

    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length <= 8)
      return 'Password must have more than 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(password))
      return 'Uppercase letter is missing.';
    if (!RegExp(r'[a-z]').hasMatch(password))
      return 'Lowercase letter is missing.';
    if (!RegExp(r'[0-9]').hasMatch(password)) return 'Digit is missing.';

    return null;
  }
}
