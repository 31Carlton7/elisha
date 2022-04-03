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

import 'package:intl/intl.dart';
import 'package:universal_html/controller.dart';

import 'package:elisha/src/models/daily_reading.dart';
import 'package:elisha/src/models/reading.dart';

class DailyReadingsService {
  DailyReadingsService();
  final _rootUrl = 'https://bible.usccb.org/bible/readings';

  Future<DailyReading> get getTodaysReading async {
    final controller = WindowController();
    final date = DateFormat('MMddyy').format(DateTime.now());
    final uri = Uri.parse(_rootUrl + '/' + date + '.cfm');

    await controller.openHttp(uri: uri);

    final doc = controller.window?.document;

    final nameNode =
        doc!.getElementsByClassName('wr-block b-lectionary padding-top-s padding-bottom-xxs bg-white').first;

    final lectionaryNode = nameNode;

    final readingNodes = doc.getElementsByClassName('wr-block b-verse bg-white padding-bottom-m');

    List<Reading> readings = [];

    for (int i = 0; i < readingNodes.length; i++) {
      var reading = Reading(
        name: doc.getElementsByClassName('name')[i].text!.trim(),
        snippetAddress: doc.getElementsByClassName('address')[i].text!.trim(),
        text: doc.getElementsByClassName('content-body')[i].text!.trim(),
      );

      readings.add(reading);
    }

    final name = nameNode.text!.trim().substring(0, nameNode.text!.trim().indexOf('\n')).trim();
    final lectionary = lectionaryNode.text!
        .trim()
        .substring(lectionaryNode.text!.trim().lastIndexOf('\n'))
        .trim()
        .substring(
          lectionaryNode.text!.trim().substring(lectionaryNode.text!.trim().lastIndexOf('\n')).trim().indexOf(' ') + 1,
        );

    final dailyReading = DailyReading(
      name: name,
      lectionary: lectionary,
      date: DateTime.now(),
      readings: readings,
    );

    return dailyReading;
  }
}
