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

import 'package:canton_design_system/canton_design_system.dart';

import 'package:elisha/src/models/daily_reading.dart';
import 'package:elisha/src/ui/views/church_view/components/church_view_header.dart';
import 'package:elisha/src/ui/views/church_view/components/daily_readings_card.dart';
import 'package:elisha/src/ui/views/church_view/components/sunday_mass_card.dart';

class ChurchView extends StatefulWidget {
  const ChurchView(this.reading, {Key? key}) : super(key: key);

  final DailyReading reading;

  @override
  _ChurchViewState createState() => _ChurchViewState();
}

class _ChurchViewState extends State<ChurchView> {
  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChurchViewHeader(),
        DailyReadingsCard(dailyReading: widget.reading),
        const SizedBox(height: 20),
        const SundayMassCard(),
      ],
    );
  }
}
