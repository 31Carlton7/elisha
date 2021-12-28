import 'package:canton_design_system/canton_design_system.dart';

class FullWordContentPage extends StatelessWidget {
  const FullWordContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('Word',
                  style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_back, color: Colors.black, size: 20)
            ),
            SizedBox(height: 5),
            Text('Write-up for today', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal))
          ],
        ),
      ),
    );
  }
}
