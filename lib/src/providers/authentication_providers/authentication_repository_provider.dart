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

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/authentication_providers/firebase_auth_provider.dart';
import 'package:elisha/src/services/authentication_services/authentication_repository.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(ref.read(firebaseAuthProvider));
});
