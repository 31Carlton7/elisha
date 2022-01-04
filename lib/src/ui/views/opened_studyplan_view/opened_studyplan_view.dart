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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/appreciate.jpeg"),
                    fit: BoxFit.fill
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) => Card(
                  color: CantonMethods.alternateCanvasColorType2(context),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(0.0)
                  // ),
                  elevation: 5.0,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile (
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(pictures[index]),
                      ),
                      title: Text(
                        days[index], style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        titles[index], style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
