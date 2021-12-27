import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';

class BibleInAYearCard extends StatefulWidget {
  const BibleInAYearCard({Key? key}) : super(key: key);

  @override
  _BibleInAYearCardState createState() => _BibleInAYearCardState();
}

class _BibleInAYearCardState extends State<BibleInAYearCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: CantonMethods.alternateCanvasColorType2(context),
      shape: CantonSmoothBorder.defaultBorder(),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                //trailing: Icon(Icons.share),
                title: Text('Bible In A Year',
                    style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 0.0,
                    shape: CantonSmoothBorder.defaultBorder(),
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width-250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/app_icon.png'),
                              fit: BoxFit.fill
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Daily Bible Reading', style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      //Text('You can follow this suitable plan to complete the bible in a year.', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal)),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Material(
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0) ),
                            elevation: 0.0,
                            color: Colors.grey[200],
                            clipBehavior: Clip.antiAlias,
                            child: MaterialButton(
                              onPressed: () {},
                              minWidth: 20,
                              height: 10,
                              elevation: 0.0,
                              color: Colors.grey[200],
                              child: Text('Begin', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
