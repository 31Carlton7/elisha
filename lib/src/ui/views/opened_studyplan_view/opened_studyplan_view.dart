import 'package:canton_design_system/canton_design_system.dart';

class OpenedStudyPlanScreen extends StatefulWidget {
  const OpenedStudyPlanScreen({Key? key}) : super(key: key);

  @override
  _OpenedStudyPlanScreenState createState() => _OpenedStudyPlanScreenState();
}

class _OpenedStudyPlanScreenState extends State<OpenedStudyPlanScreen> {
  final List pictures =  ['assets/images/appreciate.jpeg', 'assets/images/heart.jpeg', 'assets/images/light.jpg',
    'assets/images/master.jpg', "assets/images/bow.jpg"];
  final List titles = ['Humility', 'Raging Battle', 'Purity', 'New Creation Man', 'Firebrands'];
  final List days = ['Day1', 'Day2', 'Day3', 'Day4', 'Day5'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: 5,
          itemBuilder: (BuildContext context, int index) => Card(
              color: CantonMethods.alternateCanvasColorType2(context),
              elevation: 5,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(pictures[index]),
                    ),
                    title: Text(
                      days[index], style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      titles[index], style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal),
                    ),
                  )
                ),
              ),
            ),

    ),

    );
  }
}
