import 'package:flutter/cupertino.dart';

class Validator {
  final emailControlle = TextEditingController();

  final passwordControlle = TextEditingController();
  // final userNameCotroller = TextEditingController();

  static String? validateEmail(String? value) {
    {
      if (value == null || value.isEmpty) {
        return "Email is required";
      } else if (!value.contains(
        RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$'),
      )) {
        return 'Email is not correct';
      }
    }
    return null;
  }

  static String? validatePassword(String? value) {
    {
      if (value == null || value.isEmpty) {
        return "password is required";
      } else if (value.length <= 8) {
        return "password must have more than 8 chracters";
      } else if (!value.contains(RegExp(r'[A-Z]'))) {
        return 'Uppercase letter is missing.\n';
      } else if (!value.contains(RegExp(r'[a-z]'))) {
        return 'Lowercase letter is missing.\n';
      }
      if (!value.contains(RegExp(r'[0-9]'))) {
        return 'Digit is missing.\n';
      }
      if (!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
        return 'Special character is missing.\n';
      }
    }
    return null;
  }
}
