 import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A customizable container widget designed to display a title,  used for phone number +966 just
///
/// It features a rounded background and adaptable width based on the provided width parameter.
/// This widget is useful for presenting information like phone numbers in a clear and visually appealing way.


class PhoneContainer extends StatelessWidget {
  const PhoneContainer({super.key, required this.title, required this.width});
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.getWidth()*.04),
      width: width,
      height: (context.getHeight() * .07),
      decoration: BoxDecoration(
        color: StyleColor.floralWhite,
        borderRadius: BorderRadius.circular(context.getWidth()*.02),
      ),
      child: Text(
        title,
        style:StyleText.bold16,
      ),
    );
  }
}
