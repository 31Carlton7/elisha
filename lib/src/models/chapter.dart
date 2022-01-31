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

import 'package:flutter/foundation.dart';

import 'package:elisha/src/models/verse.dart';

class Chapter {
  int? id;
  String? number;
  String? translation;
  List<Verse>? verses;
  bool bookmarked;

  Chapter({
    this.id,
    this.number,
    this.translation,
    this.verses,
    required this.bookmarked,
  });

  Chapter copyWith({
    int? id,
    String? number,
    String? translation,
    List<Verse>? verses,
    bool? bookmarked,
  }) {
    return Chapter(
      id: id ?? this.id,
      translation: translation ?? this.translation,
      number: number ?? this.number,
      verses: verses ?? this.verses,
      bookmarked: bookmarked ?? this.bookmarked,
    );
  }

  ChapterId get getID {
    return ChapterId(id: id);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'translation': translation,
      'verses': verses?.map((x) => x.toMap()).toList(),
      'bookmarked': bookmarked,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'],
      number: map['number'].toString(),
      translation: map['translation'],
      verses: List<Verse>.from(map['verses']?.map((x) => Verse.fromMap(x))),
      bookmarked: map['bookmarked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) => Chapter.fromMap(json.decode(source));

  @override
  String toString() => 'Chapter(id: $id, number: $number, verses: $verses, bookmarked: $bookmarked)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chapter &&
        other.id == id &&
        other.number == number &&
        other.translation == translation &&
        listEquals(other.verses, verses) &&
        other.bookmarked == bookmarked;
  }

  @override
  int get hashCode => id.hashCode ^ number.hashCode ^ translation.hashCode ^ verses.hashCode ^ bookmarked.hashCode;
}

class ChapterId {
  int? id;
  ChapterId({this.id});

  ChapterId copyWith({
    int? id,
  }) {
    return ChapterId(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory ChapterId.fromMap(Map<String, dynamic> map) {
    return ChapterId(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterId.fromJson(String source) => ChapterId.fromMap(json.decode(source));

  @override
  String toString() => 'ChapterId(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChapterId && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
