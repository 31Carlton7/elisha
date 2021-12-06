/*
Elisha iOS & Android App
Copyright (C) 2021 Elisha

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

import 'package:elisha/src/models/local_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalUserRepository extends StateNotifier<LocalUser> {
  LocalUserRepository() : super(LocalUser(firstName: '', lastName: '', email: '', birthDate: DateTime.now()));

  Future<void> updateUser(LocalUser user) async {
    state = user;
    await _saveUser();
  }

  Future<void> _saveUser() async {
    var box = Hive.box('elisha');

    String user = state.toJson();

    box.put('user', user);
  }

  void loadUser() {
    var box = Hive.box('elisha');

    /// Removes user from device.
    // box.remove('user');

    final String user = box.get('user', defaultValue: '');

    state.firstName = LocalUser.fromJson(user).firstName;
    state.lastName = LocalUser.fromJson(user).lastName;
    state.email = LocalUser.fromJson(user).email;
    state.birthDate = LocalUser.fromJson(user).birthDate;
  }
}
