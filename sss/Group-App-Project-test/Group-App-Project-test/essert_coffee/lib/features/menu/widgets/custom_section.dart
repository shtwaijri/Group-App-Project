import 'package:essert_coffee/style/style_color.dart';
import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  const CustomSection({
    super.key,
    required this.img,
    required this.type,
    required this.screen,
  });
  final String img;
  final String type;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.44,
            height: 175,
            decoration: BoxDecoration(
              color: StyleColor.floralWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                img,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          left: 0,
          child: Container(
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              color: StyleColor.teal,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(25),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
            child: Center(
              child: Text(
                type,
                style: const TextStyle(
                  color: StyleColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//////////////////////////edited
