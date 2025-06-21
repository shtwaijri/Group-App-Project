import 'package:essert_coffee/features/auth/screens/signup/signup_screen.dart';
import 'package:essert_coffee/style/theme/theme.dart';
import 'package:essert_coffee/utilities/setup.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: '',
    anonKey:
        '',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.customTheme,
      home: SignupScreen(),
    );
  }
}
