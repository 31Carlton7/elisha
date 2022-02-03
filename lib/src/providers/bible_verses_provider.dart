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

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/providers/bible_books_provider.dart';
import 'package:elisha/src/providers/bible_chapters_provider.dart';
import 'package:elisha/src/providers/bible_service_provider.dart';

String verseID = '';

final bibleVersesProvider = FutureProvider.autoDispose<List<Verse>>((ref) async {
  ref.maintainState = true;

  bool bookIDIsEmpty = ['', null].contains(verseID);

  final bibleService = ref.watch(bibleServiceProvider);
  final verses = bibleService.getVerses(bookID, chapterID, bookIDIsEmpty ? null : verseID);

  return verses;
});
