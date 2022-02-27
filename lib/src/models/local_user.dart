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

import 'dart:convert';

class LocalUser {
  String firstName;
  String lastName;
  DateTime? birthDate;

  LocalUser({
    required this.firstName,
    required this.lastName,
    this.birthDate,
  });

  LocalUser copyWith({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? birthDate,
  }) {
    return LocalUser(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate!.millisecondsSinceEpoch,
    };
  }

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      firstName: map['firstName'],
      lastName: map['lastName'],
      birthDate: DateTime.fromMillisecondsSinceEpoch(map['birthDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUser.fromJson(String source) => LocalUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocalUser(firstName: $firstName, lastName: $lastName, birthDate: $birthDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalUser &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.birthDate == birthDate;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^ lastName.hashCode ^ birthDate.hashCode;
  }
}
