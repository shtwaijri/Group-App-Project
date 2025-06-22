import 'package:essert_coffee/features/splash/screens/splash_screen.dart';
import 'package:essert_coffee/style/theme/theme.dart';
import 'package:essert_coffee/utilities/helper/determine_position.dart';
import 'package:essert_coffee/service_locator.dart';
import 'package:essert_coffee/utilities/helper/cart_services.dart';
import 'package:essert_coffee/utilities/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  GetIt.I.registerSingleton<CartService>(CartService());

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

      home: SplashScreen(),
    );
  }
}
