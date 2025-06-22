import 'package:essert_coffee/features/auth/screens/signup/signup_screen.dart';
import 'package:essert_coffee/service_locator.dart';
import 'package:essert_coffee/style/theme/theme.dart';
import 'package:essert_coffee/utilities/helper/cart_services.dart';
import 'package:essert_coffee/utilities/setup.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qrvjtilvfzjfnoacxsrh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFydmp0aWx2ZnpqZm5vYWN4c3JoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA0OTMzNjcsImV4cCI6MjA2NjA2OTM2N30.B5O5GeZj5wchvcx852Tlcp2YRgJ0Gf7xaViinbV00sc',
  );
  setupServiceLocator();
  //
  GetIt.I.registerSingleton<CartService>(CartService());
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
