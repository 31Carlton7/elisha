import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/daily_readings_future_provider.dart';
import 'package:elisha/src/ui/components/error_card.dart';
import 'package:elisha/src/ui/components/loading_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elisha/src/ui/views/daily_readings_view/daily_readings_view.dart';

class DailyReadingsCard extends ConsumerWidget {
  const DailyReadingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dailyReadingsRepo = watch(dailyReadingsFutureProvider);

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
