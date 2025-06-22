// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:essert_coffee/features/auth/auth_service.dart';
import 'package:essert_coffee/features/auth/screens/login/login_screen.dart';
import 'package:essert_coffee/features/auth/screens/signup/bloc/signup_bloc.dart';
import 'package:essert_coffee/style/style_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(authService: AuthService()),
      child: Builder(
        builder: (context) {
          final bloc = context.read<SignupBloc>();

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              centerTitle: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 120,

              title: Text(
                '\n\n\nSignup',
                style: TextStyle(
                  color: StyleColor.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            String? emailError;
                            if (state is SignupInitial) {
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
                                      bloc.add(EmailEntered(value)),
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
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            String? passwordError;
                            if (state is SignupInitial) {
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
                                      bloc.add(PasswordEntered(value)),
                                  decoration: InputDecoration(
                                    errorText: passwordError,
                                  ),
                                  validator: (_) => passwordError,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocConsumer<SignupBloc, SignupState>(
                          listener: (context, state) {
                            if (state is SignupFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            } else if (state is SignupSuccess) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).dialogBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  content: Text(
                                    'Registration successful! Please login to continue.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    SizedBox(
                                      width: 100,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          foregroundColor: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is SignupLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    bloc.add(
                                      SignupPressed(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Signup"),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            text: "You have an account already?",
                            style: TextStyle(
                              fontSize: 15,
                              color: StyleColor.teal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "   Login",
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
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
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
