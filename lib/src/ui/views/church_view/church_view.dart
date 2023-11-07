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

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/ui/components/sunday_mass_card.dart';
import 'package:elisha/src/ui/views/church_view/components/church_view_header.dart';
import 'package:elisha/src/ui/views/church_view/components/daily_readings_card.dart';

class ChurchView extends ConsumerStatefulWidget {
  const ChurchView({Key? key}) : super(key: key);

  @override
  _ChurchViewState createState() => _ChurchViewState();
}

class _ChurchViewState extends ConsumerState<ChurchView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ChurchViewHeader(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const DailyReadingsCard(),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const SundayMassCard(),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(bottom: 10)
          ),
        ],
      ),
    );
  }
}
