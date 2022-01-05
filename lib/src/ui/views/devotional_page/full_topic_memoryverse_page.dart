import 'package:canton_design_system/canton_design_system.dart';

class FullTopicMemoryVerseVersePage extends StatelessWidget {
  const FullTopicMemoryVerseVersePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text('Topic for today:',
                    style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Topic', style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.normal))),
              ),
              SizedBox(height: 15),
              ListTile(
                title: Text('Memory Verse:',
                    style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Memory Verse for today, scripture and text', style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.normal))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
