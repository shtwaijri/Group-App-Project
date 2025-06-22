import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A widget that displays a user's profile information in a card format.
///
/// It shows the user's full name, gender, and phone number, along with a profile image
/// and an edit button.

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.onPressed,
    required this.fullName,
    required this.gender,
    required this.phone,
  });
  final Function()? onPressed;
  final String fullName;
  final String gender;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: context.getWidth(),
        height: context.getHeight() * .22,
        decoration: BoxDecoration(
          color: StyleColor.floralWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: context.getWidth() * .19,
                  height: context.getWidth() * .19,
                  child: Image.asset("assets/images/3.png"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: StyleText.bold24
                    ),
                     Text( gender,style: StyleText.regular16Grey.copyWith(
                        color: StyleColor.gray,
                      ),),
                  ],
                ),
                IconButton(icon: Icon(Icons.edit), onPressed: onPressed),
              ],
            ),
            Divider(),
            ListTile(
              title: Text(phone),
              leading: Icon(Icons.phone_outlined, size:  context.getWidth()*.06),
            ),
          ],
        ),
      ),
    );
  }
}
