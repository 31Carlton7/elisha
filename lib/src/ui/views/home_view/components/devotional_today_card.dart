import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/devotional_page/devotional_page.dart';

class DevotionalTodayCard extends StatefulWidget {
  const DevotionalTodayCard({Key? key}) : super(key: key);

  @override
  _DevotionalTodayCardState createState() => _DevotionalTodayCardState();
}

class _DevotionalTodayCardState extends State<DevotionalTodayCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: CantonMethods.alternateCanvasColorType2(context),
      shape: CantonSmoothBorder.defaultBorder(),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DevotionalPage(),
              ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                //trailing: Icon(Icons.share),
                title: Text('Devotional Topic',
                    style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text('Devotional preview for today'),
              ),
              SizedBox(height: 5),
              Card(
                elevation: 0.0,
                shape: CantonSmoothBorder.defaultBorder(),
                margin: const EdgeInsets.all(5.0),
                child: Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/app_icon.png'),
                      fit: BoxFit.fitWidth
                    ),
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(onPressed: () {},
                      child: Text('VIEW', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),)),
                  Icon(Icons.share)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
