import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/models/daily_reading.dart';
import 'package:elisha/src/models/reading.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class DailyReadingsView extends StatelessWidget {
  const DailyReadingsView(this.dailyReading);

  final DailyReading dailyReading;

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return ListView(
      children: [
        _header(context),
        SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._body(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return ViewHeaderTwo(
      backButton: true,
      title: 'Daily Readings',
      buttonTwo: CantonHeaderButton(
        backgroundColor: Theme.of(context).canvasColor,
        icon: RotatedBox(
          quarterTurns: 2,
          child: IconlyIcon(
            IconlyBold.InfoCircle,
            color: Theme.of(context).primaryColor,
          ),
        ),
        onPressed: () {
          _showInfoBottomSheet(context);
        },
      ),
    );
  }

  List<Widget> _body(BuildContext context) {
    List<Widget> children = [
      Text(
        dailyReading.name!,
        style: Theme.of(context).textTheme.headline4,
      ),
      SizedBox(height: 5),
      Text(
        'Lectionary: ' + dailyReading.lectionary!,
        style: Theme.of(context).textTheme.headline6?.copyWith(
              color: Theme.of(context).colorScheme.secondaryVariant,
            ),
      ),
      SizedBox(height: 30),
    ];

    for (int i = 0; i < dailyReading.readings!.length; i++) {
      children.add(
        _readingCard(
          context,
          dailyReading.readings![i],
        ),
      );
      if (i != dailyReading.readings!.length - 1) {
        children.add(SizedBox(height: 30));
      }
    }

    return children;
  }

  Widget _readingCard(BuildContext context, Reading reading) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(reading.name!, style: Theme.of(context).textTheme.headline5),
              Text(
                reading.snippetAddress!,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
              ),
            ],
          ),
          Divider(height: 20),
          Text(
            reading.text!,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.w400,
                  height: 1.65,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInfoBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 15),
          child: FractionallySizedBox(
            heightFactor: 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 27, right: 27),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant,
                                  ),
                        ),
                      ),
                      Spacer(flex: 7),
                      Text(
                        'Info',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Spacer(flex: 10),
                    ],
                  ),
                ),
                Divider(height: 30),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 27, right: 27),
                  child: Linkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    text:
                        'Daily Readings is courtesy of the United States Conference of Catholic Bishops © 2021. Their Website is located at https://bible.usccb.org',
                    style: Theme.of(context).textTheme.headline6,
                    linkStyle: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
