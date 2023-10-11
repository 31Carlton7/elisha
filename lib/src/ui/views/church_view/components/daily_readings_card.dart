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

import 'package:elisha/src/providers/daily_readings_future_provider.dart';
import 'package:elisha/src/ui/components/error_card.dart';
import 'package:elisha/src/ui/components/loading_card.dart';
import 'package:elisha/src/ui/views/daily_readings_view/daily_readings_view.dart';

class DailyReadingsCard extends ConsumerWidget {
  const DailyReadingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyReadingsRepo = ref.watch(dailyReadingsFutureProvider);

    return dailyReadingsRepo.when(
      error: (e, s) => const ErrorCard(),
      loading: () => const LoadingCard(),
      data: (dailyReading) {
        return GestureDetector(
          onTap: () {
            CantonMethods.viewTransition(context, DailyReadingsView(dailyReading));
          },
          child: Card(
            color: CantonMethods.alternateCanvasColorType3(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Daily Readings',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'SCRIPTURES FOR TODAY\'S SERVICE',
                    style: Theme.of(context).textTheme.overline?.copyWith(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Join Mass today by reading the scriptures for ${dailyReading.name}.',
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
