/*
Elisha iOS & Android App
Copyright (C) 2022 Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:device_preview_screenshot/device_preview_screenshot.dart';

import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/ui/views/login_wrapper.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    await Hive.openBox('elisha');

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        tools: const [
          ...DevicePreview.defaultTools,
          DevicePreviewScreenshot(),
        ],
        builder: (context) => const ProviderScope(
          child: ElishaApp(),
        ),
      ),
    );
  }, (error, stack) async {
  });
}

class ElishaApp extends ConsumerWidget {
  const ElishaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CantonApp(
      title: kAppTitle,
      primaryLightColor: const Color(0xFFB97D3C),
      primaryLightVariantColor: const Color(0xFFB97D3C),
      primaryDarkColor: const Color(0xFFDDA15E),
      primaryDarkVariantColor: const Color(0xFFDDA15E),
      home: const LoginWrapper(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
