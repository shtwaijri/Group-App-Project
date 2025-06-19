import 'package:essert_coffee/style/style_text.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Order screen', style: StyleText.bold16)),
    );
  }
}
