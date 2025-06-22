import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  const CustomItem({
    super.key,
    required this.img,
    required this.coffee,
    required this.price,
    required this.screen,
  });
  final String img;
  final String coffee;
  final String price;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        width: context.getWidth() * 0.9,
        height: 160,
        decoration: BoxDecoration(
          color: StyleColor.floralWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(img, height: 150),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(coffee, style: StyleText.bold16),
                  SizedBox(height: 8),
                  Text(price, style: StyleText.regular16Grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
