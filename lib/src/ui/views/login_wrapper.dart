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

import 'dart:io';

import 'package:flutter/services.dart';

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/ui/views/current_view.dart';
import 'package:elisha/src/ui/views/introduction_view/introduction_view.dart';

class LoginWrapper extends ConsumerStatefulWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginWrapper> createState() => _LoginWrapperState();
}

class _LoginWrapperState extends ConsumerState<LoginWrapper> {
  @override
  void initState() {
    super.initState();
    ref.read(localUserRepositoryProvider).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.read(localUserRepositoryProvider).getLoginCount;

    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    Color statusBarColor() {
      if (Platform.isIOS) {
        return isDarkMode ? CantonColors.white : CantonColors.black;
      } else {
        return isDarkMode ? CantonColors.gray[900]! : CantonColors.white;
      }
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: statusBarColor(),
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );

    if (count > 1) {
      return const CurrentView();
    }

    return const IntroductionView();
  }
}
