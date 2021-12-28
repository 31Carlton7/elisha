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
  int id;
  int chapterId;
  int verseId;
  String text;
  Book book;
  bool favorite;

  Verse({
    required this.id,
    required this.chapterId,
    required this.verseId,
    required this.text,
    required this.book,
    required this.favorite,
  });

  Verse copyWith({
    int? id,
    int? chapterId,
    int? verseId,
    String? text,
    Book? book,
    bool? favorite,
  }) {
    return Verse(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      verseId: verseId ?? this.verseId,
      text: text ?? this.text,
      book: book ?? this.book,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapterId': chapterId,
      'verseId': verseId,
      'text': text,
      'book': book.toMap(),
      'favorite': favorite,
    };
  }

  factory Verse.fromMap(Map<String, dynamic> map) {
    return Verse(
      id: map['id'],
      chapterId: map['chapterId'],
      verseId: map['verseId'],
      text: map['verse'] ?? map['text'],
      book: Book.fromMap(map['book']),
      favorite: false,
    );
  }

  factory Verse.fromMapFromVOTD(Map<String, dynamic> map) {
    final data = map['verse']['details'] as Map<String, dynamic>;
    final reference = data['reference'] as String;

    final chapterId = int.parse(reference.substring(reference.trim().lastIndexOf(' '), reference.lastIndexOf(':')).trim());
    final verseId = int.parse(reference.substring(reference.trim().lastIndexOf(':') + 1).trim());
    final text = data['text'];

    final book = Book(
      id: 0,
      name: reference.substring(0, reference.lastIndexOf(' ')).trim(),
      testament: '',
      chapters: [],
    );

    return Verse(
      id: verseId,
      chapterId: chapterId,
      verseId: verseId,
      text: text,
      book: book,
      favorite: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Verse.fromJson(String source) => Verse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Verse(id: $id, chapterId: $chapterId, verseId: $verseId, text: $text, book: $book, favorite: $favorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Verse &&
        other.id == id &&
        other.chapterId == chapterId &&
        other.verseId == verseId &&
        other.text == text &&
        other.book == book &&
        other.favorite == favorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^ chapterId.hashCode ^ verseId.hashCode ^ text.hashCode ^ book.hashCode ^ favorite.hashCode;
  }
}
