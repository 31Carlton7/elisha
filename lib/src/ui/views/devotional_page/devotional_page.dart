import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/devotional_page/full_word_content.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class DevotionalPage extends StatefulWidget {
  const DevotionalPage({Key? key}) : super(key: key);

  @override
  _DevotionalPageState createState() => _DevotionalPageState();
}

class _DevotionalPageState extends State<DevotionalPage> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> devotionalCards = [
      Expanded(
        child: Card(
          color: CantonMethods.alternateCanvasColorType2(context),
          shape: CantonSmoothBorder.defaultBorder(),
          child: Column(
            children: [
              ListTile(
                title: Text('Topic for today:',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Topic',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontWeight: FontWeight.normal))),
              ),
              SizedBox(height: 15),
              ListTile(
                title: Text('Memory Verse:',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Memory Verse for today, scripture and text',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontWeight: FontWeight.normal))),
              ),
            ],
          ),
        ),
      ),
      // Expanded(
      //   child: Card(
      //   color: CantonMethods.alternateCanvasColorType2(context),
      //   shape: CantonSmoothBorder.defaultBorder(),
      //   child: Column(
      //     children: [
      //       ListTile(
      //         title: Text('Memory Verse',
      //             style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
      //       ),
      //       Text('Memory verse for today', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal))
      //     ],
      //   ),
      // ),
      // ),
      Card(
        color: CantonMethods.alternateCanvasColorType2(context),
        shape: CantonSmoothBorder.defaultBorder(),
        child: Column(
          children: [
            ListTile(
              title: Text('Word',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold)),
              trailing: Text(
                'More',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 5),
            Text('Write-up for today',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.normal))
          ],
        ),
      ),
      Card(
        color: CantonMethods.alternateCanvasColorType2(context),
        shape: CantonSmoothBorder.defaultBorder(),
        child: Column(
          children: [
            ListTile(
              title: Text('Prayer',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 5),
            Text('Prayer for today',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.normal))
          ],
        ),
      ),
      Card(
        color: CantonMethods.alternateCanvasColorType2(context),
        shape: CantonSmoothBorder.defaultBorder(),
        child: Column(
          children: [
            ListTile(
              title: Text('Thought for The Day',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 5),
            Text('What you should ponder about today',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.normal))
          ],
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: VerticalCardPager(
                  images: devotionalCards,
                  titles: ['', '', '', ''],
                  onPageChanged: (page) {},
                  onSelectedItem: (index) {
                    switch (index) {
                      case 0:
                        print(index);
                        break;
                      case 1:
                        Navigator.of(context).push(PageTransition(
                            child: FullWordContentPage(),
                            type: PageTransitionType.scale,
                            alignment: Alignment.center,
                        duration: Duration(milliseconds: 600)
                        ));
                        break;
                      case 2:
                        print(index);
                        break;
                      case 3:
                        print(index);
                        break;
                    }
                  },
                  initialPage: 1,
                  // optional
                  align: ALIGN.CENTER),
            ),
          ],
        ),
      ),
    );
  }
}
