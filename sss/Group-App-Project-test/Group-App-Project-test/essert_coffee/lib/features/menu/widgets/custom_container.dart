import 'package:essert_coffee/style/style_color.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.height,
    required this.widget,
  });
  final double height;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1,
      height: height,
      decoration: BoxDecoration(
        color: StyleColor.teal,
        borderRadius: BorderRadius.circular(20),
      ),
      child: widget,
    );
  }
}
