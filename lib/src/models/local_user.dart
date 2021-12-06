import 'dart:convert';

class LocalUser {
  String firstName;
  String lastName;
  String email;
  DateTime birthDate;

  LocalUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
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
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthDate': birthDate.millisecondsSinceEpoch,
    };
  }

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      birthDate: DateTime.fromMillisecondsSinceEpoch(map['birthDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUser.fromJson(String source) => LocalUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocalUser(firstName: $firstName, lastName: $lastName, email: $email, birthDate: $birthDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalUser &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.birthDate == birthDate;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^ lastName.hashCode ^ email.hashCode ^ birthDate.hashCode;
  }
}
