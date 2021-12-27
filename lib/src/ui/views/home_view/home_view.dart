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
import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/ui/components/verse_of_the_day_card.dart';
import 'package:elisha/src/ui/views/home_view/components/bible_in_a_year_card.dart';
import 'package:elisha/src/ui/views/home_view/components/devotional_today_card.dart';
import 'package:elisha/src/ui/views/home_view/components/streaks_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/ui/views/home_view/components/home_view_header.dart';

import 'components/study_plans_listview.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.verse, Key? key}) : super(key: key);

  final Verse verse;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HomeViewHeader(),
              _body(context),
            ],
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        const StreaksCard(),
        const SizedBox(height: 15),
        VerseOfTheDayCard(verse: widget.verse),
        const SizedBox(height: 15),
        DevotionalTodayCard(),
        const SizedBox(height: 15),
        BibleInAYearCard(),
        const SizedBox(height: 15),
        StudyPlansListView()
      ],
    );
  }
}
