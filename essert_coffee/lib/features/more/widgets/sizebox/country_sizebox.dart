import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A fixed-size box widget specifically designed to display a country flag image.
///
/// This widget takes an imagePath and displays it within a predefined
/// width and height, ensuring consistent sizing for flag icons across the application.

class CountrySizebox extends StatelessWidget {
  const CountrySizebox({super.key, required this.imagePath});
      final String imagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth()*.09,
      height: context.getHeight()*.05,
      child: Image.asset(imagePath),
    );
  }
}
