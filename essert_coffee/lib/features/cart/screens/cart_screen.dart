import 'package:essert_coffee/style/style_text.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Cart screen', style: StyleText.bold16)),
    );
  }
}
