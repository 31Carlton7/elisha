import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? imageUrl;
  DateTime? birthDate;
  int? currentStreak;
  int? perfectWeeks;
  int? bestStreak;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.birthDate,
    this.currentStreak,
    this.perfectWeeks,
    this.bestStreak,
  });

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? imageUrl,
    DateTime? birthDate,
    int? currentStreak,
    int? perfectWeeks,
    int? bestStreak,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
      birthDate: birthDate ?? this.birthDate,
      currentStreak: currentStreak ?? this.currentStreak,
      perfectWeeks: perfectWeeks ?? this.perfectWeeks,
      bestStreak: bestStreak ?? this.bestStreak,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'currentStreak': currentStreak,
      'perfectWeeks': perfectWeeks,
      'bestStreak': bestStreak,
    };
  }

  Map<String, dynamic> toDocumentSnapshot() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'birthDate': Timestamp.fromDate(birthDate!),
      'currentStreak': currentStreak,
      'perfectWeeks': perfectWeeks,
      'bestStreak': bestStreak,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      imageUrl: map['imageUrl'],
      birthDate: DateTime.fromMillisecondsSinceEpoch(map['birthDate']),
      currentStreak: map['currentStreak'],
      perfectWeeks: map['perfectWeeks'],
      bestStreak: map['bestStreak'],
    );
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      email: doc['email'],
      firstName: doc['firstName'],
      lastName: doc['lastName'],
      imageUrl: doc['imageUrl'],
      birthDate: doc['birthDate'].toDate(),
      currentStreak: doc['currentStreak'],
      perfectWeeks: doc['perfectWeeks'],
      bestStreak: doc['bestStreak'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, email: $email, firstName: $firstName, lastName: $lastName, imageUrl: $imageUrl, birthDate: $birthDate, currentStreak: $currentStreak, perfectWeeks: $perfectWeeks, bestStreak: $bestStreak)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.imageUrl == imageUrl &&
        other.birthDate == birthDate &&
        other.currentStreak == currentStreak &&
        other.perfectWeeks == perfectWeeks &&
        other.bestStreak == bestStreak;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        imageUrl.hashCode ^
        birthDate.hashCode ^
        currentStreak.hashCode ^
        perfectWeeks.hashCode ^
        bestStreak.hashCode;
  }
}
