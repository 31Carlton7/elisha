import 'package:canton_design_system/canton_design_system.dart';
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
                title: Text('Topic for today',
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5),
              Text('Topic', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
      Expanded(
        child: Card(
        color: CantonMethods.alternateCanvasColorType2(context),
        shape: CantonSmoothBorder.defaultBorder(),
        child: Column(
          children: [
            ListTile(
              title: Text('Memory Verse',
                  style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
            ),
            Text('Memory verse for today', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal))
          ],
        ),
      ),
      ),
      Card(
        color: CantonMethods.alternateCanvasColorType2(context),
        shape: CantonSmoothBorder.defaultBorder(),
        child: Column(
          children: [
            ListTile(
              title: Text('Word',
                  style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 5),
            Text('Write-up for today', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal))
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
                  style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 5),
            Text('Prayer for today', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal))
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
                  style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 5),
            Text('What you should ponder about today', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal))
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
              titles: ['', '', '', '', ''],
                onPageChanged: (page) {
                },
                onSelectedItem: (index) {
                },
                initialPage: 2, // optional
                align : ALIGN.CENTER

              ),),
          ],
        ),
      ),
    );
  }
}
