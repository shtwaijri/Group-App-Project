import 'package:essert_coffee/style/style_text.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('More screen', style: StyleText.bold16)),
    );
  }
}
