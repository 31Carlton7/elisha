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
