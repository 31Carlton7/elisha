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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Note',
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: "Text To Speech",
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
                width: MediaQuery.of(context).size.width - 15,
                color: Colors.white,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Topic | Date',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width - 15,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Title',
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width - 15,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    minLines: 30,
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Note',
                        border: OutlineInputBorder()),
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
