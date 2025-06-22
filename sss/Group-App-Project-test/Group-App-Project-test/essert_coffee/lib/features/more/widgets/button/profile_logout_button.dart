import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:flutter/material.dart';

/// Logout button for the user profile  for log out
class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key,required this.onPressed, required this.title});
  final Function()? onPressed;
 final String  title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton.icon(
        iconAlignment: IconAlignment.end,
        onPressed: onPressed,
        label: Text(
          title,
          style: StyleText.regular16Error.copyWith(fontSize: 20),
        ),
        icon: Icon(Icons.logout, color:StyleColor.red),
      ),
    );
  }
}
