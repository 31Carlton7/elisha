import 'package:canton_design_system/canton_design_system.dart';

import 'package:elisha/src/models/daily_reading.dart';
import 'package:elisha/src/ui/views/daily_readings_view/daily_readings_view.dart';

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
      children: [
        _header(context),
        _dailyReadingsCard(context, widget.reading),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Church',
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          )
        ],
      ),
    );
  }

  Widget _dailyReadingsCard(BuildContext context, DailyReading dailyReading) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, DailyReadingsView(dailyReading));
      },
      child: Card(
        color: CantonMethods.alternateCanvasColor(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                'Join Mass today by reading the scriptures for ${dailyReading.name}.',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
