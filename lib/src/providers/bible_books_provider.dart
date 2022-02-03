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

import 'package:elisha/src/models/book.dart';
import 'package:elisha/src/providers/bible_service_provider.dart';

String bookID = '';

final bibleBooksProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  ref.maintainState = true;

  final bibleService = ref.watch(bibleServiceProvider);
  final books = bibleService.getBooks(bookID);

  return books;
});
