// ignore_for_file: body_might_complete_normally_nullable

import 'package:bloc/bloc.dart';
import 'package:essert_coffee/features/auth/auth_service.dart' show AuthService;
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  //declare authservice variable for authentication logic
  final AuthService authService;
  SignupBloc({required this.authService}) : super(SignupInitial()) {
    //emailEntered event
    on<EmailEntered>((event, emit) {
      final emailValid = _validateEmail(event.email);

      //get the current state
      final currentState = state;
      String? passwordValid;

      //to keep the passwrod error(if any)
      if (currentState is SignupInitial) {
        passwordValid = currentState.passwordError;
      }

      //send an event with email enterd, and the password is at it is
      emit(SignupInitial(emailError: emailValid, passwordError: passwordValid));
    });

    on<PasswordEntered>((event, emit) {
      final passwordValid = _validatePassword(event.password);
      final currentState = state;
      String? emailValid;

      if (currentState is SignupInitial) {
        emailValid = currentState.emailError;
      }

      //send an event with password enterd, and the email is at it is
      emit(SignupInitial(emailError: emailValid, passwordError: passwordValid));
    });
    //signupPressed event
    on<SignupPressed>(_pressSignup);
  }

  //method to handle the logic when signup button has pressed
  Future<void> _pressSignup(
    SignupPressed event,
    Emitter<SignupState> emit,
  ) async {
    //check the validation here too
    final emailError = _validateEmail(event.email);
    final passwordError = _validateEmail(event.email);

    if (emailError != null || passwordError != null) {
      emit(SignupInitial(emailError: emailError, passwordError: passwordError));

      return;
    }

    emit(SignupLoading());

    try {
      //call auth service method to check on the email and pass
      await authService.signupByEmail(event.email, event.password);

      //emit success state when the sign up went successfully

      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }

  //method for email validation conditions
  String? _validateEmail(String email) {
    if (email.isEmpty) return 'email is required';

    final regExp = RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$');
    if (!regExp.hasMatch(email)) return 'email is not correcr';
  }

  //method for password validation conditions
  String? _validatePassword(String password) {
    if (password.isEmpty) return 'password is required';
    if (password.length <= 8) return 'password must have more than 8 chracters';

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Uppercase letter is missing.\n';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Lowercase letter is missing.\n';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) return 'Digit is missing.\n';

    return null;
  }
}
