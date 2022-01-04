import 'package:canton_design_system/canton_design_system.dart';

class ListOfNotesPage extends StatefulWidget {
  const ListOfNotesPage({Key? key}) : super(key: key);

  @override
  _ListOfNotesPageState createState() => _ListOfNotesPageState();
}

class _ListOfNotesPageState extends State<ListOfNotesPage> {
  final List titles = ['Note1', 'Note2', 'Note3', 'Note4', 'Note5'];
  final List days = ['Day1', 'Day2', 'Day3', 'Day4', 'Day5'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () {},
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              //Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(30.0))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        hintText: 'Search note',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          //shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) => Card(
          color: CantonMethods.alternateCanvasColorType2(context),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 2),
            borderRadius: BorderRadius.circular(2),
          ),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(0.0)
          // ),
          elevation: 5.0,
          child: InkWell(
            onTap: () {},
            child: ListTile (
              title: Text(
                titles[index], style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                days[index], style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }
}
