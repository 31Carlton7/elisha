import 'package:canton_design_system/canton_design_system.dart';

class FullThoughtOfTheDayPage extends StatelessWidget {
  const FullThoughtOfTheDayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text('Thought Of The Day',
                    style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold)),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(height: 5),
              Text('What you should ponder about today', style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
