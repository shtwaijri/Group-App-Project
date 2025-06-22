import 'package:essert_coffee/firebase_options.dart';
import 'package:essert_coffee/layer%20data/branch_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:get_it/get_it.dart';

/// Sets up dependency injection using GetIt.

Future<void> setUp() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // // Enable verbose logging for debugging (remove in production)
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  // // Initialize with your OneSignal App ID
  OneSignal.initialize(dotenv.env["appIDOneSignal"].toString());
  OneSignal.Notifications.requestPermission(false);
  GetIt.I.registerLazySingleton<BranchData>(() => BranchData());

  // }
}
