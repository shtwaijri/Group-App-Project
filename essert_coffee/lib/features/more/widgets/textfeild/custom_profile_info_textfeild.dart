import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A customizable text field widget for displaying and editing user profile information.
///
/// This widget provides a visually distinct text input field,  used for displaying
/// and allowing edits to fields like name, email, or phone number. It can adjust its
/// width based on whether it's specifically for a phone number.


class CustomProfileInfoTextfeild extends StatelessWidget {
  const CustomProfileInfoTextfeild({
    super.key,
    required this.controller,
    this.isphone = false, this.validator,
  });
  final TextEditingController? controller;
  final bool? isphone;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: context.getWidth()*.002, right: context.getWidth()*.002),
      width: !isphone! ? context.getWidth() : context.getWidth() * .7,
      height: context.getHeight() * .1,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintStyle: StyleText.bold16,
          hintText: controller!.text.isNotEmpty ? controller!.text : "",
          contentPadding: EdgeInsets.all(20),
          filled: true,
          fillColor:StyleColor.floralWhite,
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none, width: 0),
            borderRadius: BorderRadius.circular(context.getHeight()*.012),
          ),
        ),
      ),
    );
  }
}
