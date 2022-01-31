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

import 'package:elisha/src/models/chapter.dart';

class Book {
  int? id;
  String? name;
  String? testament;
  List<ChapterId>? chapters;

  Book({
    this.id,
    this.name,
    this.testament,
    this.chapters,
  });

  Book copyWith({
    int? id,
    String? name,
    String? testament,
    List<ChapterId>? chapters,
  }) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      testament: testament ?? this.testament,
      chapters: chapters ?? this.chapters,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'testament': testament,
      'chapters': chapters?.map((x) => x.toMap()).toList(),
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      name: map['name'],
      testament: map['testament'],
      chapters: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Book(id: $id, name: $name, testament: $testament, chapters: $chapters)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.id == id &&
        other.name == name &&
        other.testament == testament &&
        listEquals(other.chapters, chapters);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ testament.hashCode ^ chapters.hashCode;
  }
}
