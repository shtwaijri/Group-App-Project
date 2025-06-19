import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/widgets/buttom_widget.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text('Menu screen', style: StyleText.bold16)),
            ButtomWidget(onTab: () {}, textElevatedButton: 'Lamya'),
          ],
        ),
      ),
    );
  }
}
