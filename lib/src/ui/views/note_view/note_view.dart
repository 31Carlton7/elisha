import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/note_view/note_header_view.dart';
import 'package:flutter/material.dart';

class DevotionalNotePage extends StatefulWidget {
  const DevotionalNotePage({Key? key}) : super(key: key);

  @override
  _DevotionalNotePageState createState() => _DevotionalNotePageState();
}

class _DevotionalNotePageState extends State<DevotionalNotePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const NoteHeaderView(),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 15,
                    color: Colors.black87,
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Topic | Date',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Title',
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      minLines: 30,
                      keyboardType: TextInputType.text,
                      maxLines: null,
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Note',
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 18),
                          ))))
            ],
          ),
        ),
      ),
    );
  }
}

/*
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 15,
                color: Colors.black87,
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
    );
  }
}
*/
