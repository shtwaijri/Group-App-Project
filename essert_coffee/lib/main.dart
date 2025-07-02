import 'package:essert_coffee/features/branches/screens/branches_screen.dart';
import 'package:essert_coffee/features/cart/screens/payment_screeen.dart';
import 'package:essert_coffee/style/theme/theme.dart';
import 'package:essert_coffee/utilities/helper/determine_position.dart';
import 'package:essert_coffee/utilities/setup.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    determinePosition();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.customTheme,
      home: BranchesScreen(),
    );
  }
}
