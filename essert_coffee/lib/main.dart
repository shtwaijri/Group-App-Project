import 'package:essert_coffee/features/nav/navigation_bar_screen.dart';
import 'package:essert_coffee/style/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.customTheme,
      home: NavigationBarScreen(),
    );
  }
}
