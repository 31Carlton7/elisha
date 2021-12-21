import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/models/daily_reading.dart';
import 'package:elisha/src/ui/views/daily_readings_view/daily_readings_view.dart';

class DailyReadingsCard extends StatelessWidget {
  const DailyReadingsCard({Key? key, required this.dailyReading}) : super(key: key);

  final DailyReading dailyReading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, DailyReadingsView(dailyReading));
      },
      child: Card(
        color: CantonMethods.alternateCanvasColorType2(context),
        shape: CantonSmoothBorder.defaultBorder(),
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
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
