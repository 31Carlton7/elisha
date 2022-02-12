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

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class DailyDevotionalService {
  DailyDevotionalService(this._dio);

  final Dio _dio;
  final _rootUrl = 'http://dailyscripture.servantsoftheword.org/readings';
  final _date = DateFormat('MMMd').format(DateTime.now()).toLowerCase().replaceAll(' ', '');
  final _year = DateTime.now().year.toString();

  String get interfaceUrl => 'https://www.dailyscripture.net/daily-meditation/';

  // Make algorithm to determine date for link above.
  Future<String> get todaysDailyDevotional async {
    final resp = await _dio.get(_rootUrl + '/' + _year + '/' + _date + '.htm');

    var data = (resp.data as String).substring(0, resp.data.indexOf('<font face='));
    data += '</body> </html>';

    data = data.replaceRange(data.indexOf('<h1>'), data.indexOf('<h1>') + 5, '<h1>');
    data = data.replaceRange(data.indexOf('<center>&nbsp;'), data.indexOf('<center>&nbsp;') + 14, '<center>');

    return data.trim();
  }
}
