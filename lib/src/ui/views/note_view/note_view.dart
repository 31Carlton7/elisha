import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DevotionalNotePage extends StatefulWidget {
    const DevotionalNotePage({Key? key}) : super(key: key);

    @override
    _DevotionalNotePageState createState() => _DevotionalNotePageState();
  }

  class _DevotionalNotePageState extends State<DevotionalNotePage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Note', style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.bold),),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.mic),
            ),
          ],
      ),
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width-15,
                  color: Colors.black,
                  child: Align(
                    alignment: Alignment.center,
                      child: Text('Topic | Date', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),  )),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width-15,
                  height: 40,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width-15,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: 'note',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
