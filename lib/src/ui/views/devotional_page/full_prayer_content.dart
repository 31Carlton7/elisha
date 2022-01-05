import 'package:canton_design_system/canton_design_system.dart';

class FullPrayerPage extends StatelessWidget {
  const FullPrayerPage({Key? key}) : super(key: key);

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
                title: Text('Prayer',
                    style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5),
              Text('Prayer for today', style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
