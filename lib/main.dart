import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'data/local/database/app_database.dart';
import 'data/shared_data/app_shared_preference.dart';
import 'initializer/app_config.dart';
import 'initializer/app_initializer.dart';
import 'presentation/app/my_app.dart';
import 'utils/log_utils.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppDatabase.init();
    await AppSharedPreference.instance.initSharedPreferences();
    await AppInitializer(AppConfig.getInstance()).init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _runMyApp();
  }, _reportError,);
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _runMyApp() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

void _reportError(Object error, StackTrace stackTrace) {
  Log.e(error, stackTrace: stackTrace, name: 'UUncaught exception');
}
