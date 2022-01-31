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

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/models/local_user.dart';

class LocalUserRepository extends ChangeNotifier {
  var _localUser = LocalUser(firstName: '', lastName: '', birthDate: DateTime.now());
  var _loginCount = 0;
  var _natureImage = natureImages[0];
  var _churchImage = churchImages[0];
  var _lastChurchYTChannel = 'UCubahKRKNc4cj3sZSAmc-Nw';

  LocalUser get getUser => _localUser;
  int get getLoginCount => _loginCount;
  String get getNatureImage => _natureImage;
  String get getChurchImage => _churchImage;
  String get getLastChurchYTChannel => _lastChurchYTChannel;

  Future<void> updateUser(LocalUser user) async {
    final box = Hive.box('elisha');

    _localUser = user;
    await box.put('user', _localUser.toJson());
    notifyListeners();
  }

  Future<void> _updateLoginCount() async {
    final box = Hive.box('elisha');

    _loginCount++;
    await box.put('login_count', _loginCount);
    notifyListeners();
  }

  Future<void> updateNatureImage() async {
    final box = Hive.box('elisha');

    _natureImage = natureImages[Random().nextInt(10)];
    await box.put('nature_image', _natureImage);
    notifyListeners();
  }

  Future<void> updateChurchImage() async {
    final box = Hive.box('elisha');

    _churchImage = churchImages[Random().nextInt(3)];
    await box.put('church_image', _churchImage);
    notifyListeners();
  }

  Future<void> updateLastChurchYTChannel(String channelId) async {
    final box = Hive.box('elisha');

    _lastChurchYTChannel = channelId;
    await box.put('last_church_yt_channel', _lastChurchYTChannel);
    notifyListeners();
  }

  void loadUser() async {
    final box = Hive.box('elisha');

    /// Removes user from device.
    // box.delete('user');

    String user = box.get(
      'user',
      defaultValue: LocalUser(
        firstName: '',
        lastName: '',
        birthDate: DateTime.now(),
      ).toJson(),
    );

    int loginCount = box.get('login_count', defaultValue: 0);
    String natureImage = box.get('nature_image', defaultValue: natureImages[0]);
    String churchImage = box.get('church_image', defaultValue: churchImages[0]);
    String lastChurchYTChannel = box.get('last_church_yt_channel', defaultValue: 'UCubahKRKNc4cj3sZSAmc-Nw');

    _localUser = LocalUser.fromJson(user);
    _natureImage = natureImage;
    _churchImage = churchImage;
    _lastChurchYTChannel = lastChurchYTChannel;

    if (user == '' || [_localUser.firstName, _localUser.lastName].contains('')) {
      _loginCount = 0;
    } else {
      _loginCount = loginCount;
      _localUser = LocalUser.fromJson(user);
    }

    await _updateLoginCount();
  }
}
