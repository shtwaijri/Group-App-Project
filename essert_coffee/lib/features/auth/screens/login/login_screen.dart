// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:essert_coffee/features/auth/auth_service.dart';
import 'package:essert_coffee/features/auth/screens/login/bloc/login_bloc.dart';
import 'package:essert_coffee/features/auth/screens/signup/signup_screen.dart';
import 'package:essert_coffee/features/nav/navigation_bar_screen.dart';
import 'package:essert_coffee/style/style_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authService: AuthService()),
      child: Builder(
        builder: (context) {
          final bloc = context.read<LoginBloc>();

          return Scaffold(
            backgroundColor: StyleColor.beige,
            appBar: AppBar(
              toolbarHeight: 120,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '\n\n\nLogin',
                style: TextStyle(
                  color: StyleColor.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            ),
            body: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  width: 380,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            String? emailError;
                            if (state is LoginInitial) {
                              emailError = state.emailError;
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: StyleColor.teal.withOpacity(0.8),
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  onChanged: (value) =>
                                      bloc.add(LoginEmailEntered(value)),
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    errorText: emailError,
                                  ),
                                  validator: (_) => emailError,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            String? passwordError;
                            if (state is LoginInitial) {
                              passwordError = state.passwordError;
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: StyleColor.teal.withOpacity(0.8),
                                  ),
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  onChanged: (value) =>
                                      bloc.add(LoginPasswordEntered(value)),
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    errorText: passwordError,
                                  ),
                                  validator: (_) => passwordError,
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 32),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            } else if (state is LoginSuccess) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationBarScreen(),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return SizedBox(
                              height: 56,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    bloc.add(
                                      LoginPressed(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: StyleColor.teal,
                                  foregroundColor: StyleColor.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                fontSize: 15,
                                color: StyleColor.teal,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "   Sign Up",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: StyleColor.lightBrown,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
