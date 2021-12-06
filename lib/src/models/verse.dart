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

import 'dart:convert';

import 'package:elisha/src/models/book.dart';

class Verse {
  int? id;
  int? chapterId;
  int? verseId;
  String? text;
  Book? book;

  Verse({
    this.id,
    this.chapterId,
    this.verseId,
    this.text,
    this.book,
  });

  Verse copyWith({
    int? id,
    int? chapterId,
    int? verseId,
    String? text,
    Book? book,
  }) {
    return Verse(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      verseId: verseId ?? this.verseId,
      text: text ?? this.text,
      book: book ?? this.book,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapterId': chapterId,
      'verseId': verseId,
      'text': text,
      'book': book?.toMap(),
    };
  }

  factory Verse.fromMap(Map<String, dynamic> map) {
    return Verse(
      id: map['id'],
      chapterId: map['chapterId'],
      verseId: map['verseId'],
      text: map['verse'] ?? map['text'],
      book: Book.fromMap(map['book']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Verse.fromJson(String source) => Verse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Verse(id: $id, chapterId: $chapterId, verseId: $verseId, text: $text, book: $book)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Verse &&
        other.id == id &&
        other.chapterId == chapterId &&
        other.verseId == verseId &&
        other.text == text &&
        other.book == book;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        chapterId.hashCode ^
        verseId.hashCode ^
        text.hashCode ^
        book.hashCode;
  }
}
