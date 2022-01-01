import 'package:canton_design_system/canton_design_system.dart';

class BibleStudySeriesPage extends StatefulWidget {
  const BibleStudySeriesPage({Key? key}) : super(key: key);

  @override
  _BibleStudySeriesPageState createState() => _BibleStudySeriesPageState();
}

class _BibleStudySeriesPageState extends State<BibleStudySeriesPage> {
  final List pictures =  ['assets/images/appreciate.jpeg', 'assets/images/heart.jpeg', 'assets/images/light.jpg',
    'assets/images/master.jpg', "assets/images/bow.jpg"];
  final List titles = ['Humility', 'Raging Battle', 'Purity', 'New Creation Man', 'Firebrands'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Devotional Series',
          style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        //backgroundColor: Colors.white,
        //brightness: Brightness.light,
      ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SafeArea(
            child:  _buildContent(context),
          ),
        ),
      );
  }
}

Widget _buildContent(BuildContext context) {
  return ListView.separated(
  itemCount: 5,
    scrollDirection: Axis.vertical,

    itemBuilder: (BuildContext content, int index) {
    return _buildHorizontalList();
    },
    separatorBuilder: (BuildContext context, int index) {
    return SizedBox(
      height: 35,
    );
  },);
}

Widget _buildHorizontalList() {
  final List pictures =  ['assets/images/appreciate.jpeg', 'assets/images/heart.jpeg', 'assets/images/light.jpg',
    'assets/images/master.jpg', "assets/images/bow.jpg"];
  final List titles = ['Humility', 'Raging Battle', 'Purity', 'New Creation Man', 'Firebrands'];
return SizedBox(
  height: 136,
  child: ListView.separated(
    itemCount: 5,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 10,
        );
      },
    itemBuilder: (BuildContext context, int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {

            },
            child: Card(
              color: CantonMethods.alternateCanvasColorType2(context),
              shape: CantonSmoothBorder.defaultBorder(),
              child:  Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(pictures[index]),
                        fit: BoxFit.fill
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(titles[index], style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold))
        ],
      );
    },
    physics: BouncingScrollPhysics(),
  ),
);
}
