import 'package:canton_design_system/canton_design_system.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/services/authentication/authentication_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CantonApp(
      title: kAppTitle,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
      primaryLightColor: Color(0xFFB97D3C),
      primaryLightVariantColor: Color(0xFFB97D3C),
      primaryDarkColor: Color(0xFFB97D3C),
      primaryDarkVariantColor: Color(0xFFB97D3C),
      home: AuthenticationWrapper(),
    );
  }
}
