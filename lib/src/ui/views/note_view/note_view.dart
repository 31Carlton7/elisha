import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/note_view/note_header_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';

class DevotionalNotePage extends StatefulWidget {
  const DevotionalNotePage({Key? key}) : super(key: key);

  @override
  _DevotionalNotePageState createState() => _DevotionalNotePageState();
}

class _DevotionalNotePageState extends State<DevotionalNotePage> {
  late SpeechToText _speech;
  bool _islistening = false;
  double confidence = 1.0;
  var noteWidget = TextEditingController();
  String? jottings;
  String? writeup;
  @override
  void initState(){
    super.initState();
    _speech = SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Note', style: Theme.of(context).textTheme.headline3),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: _listen,
                              icon: Icon(_islistening ? Icons.mic_off : Icons.mic))))
                ]),
              ),
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
                      //initialValue: jottings,
                      onChanged: (value){
                        noteWidget.text = noteWidget.text + value;
                      },
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
                      controller: noteWidget,
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Note',
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Align(
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
  void _listen() async {
    if (!_islistening){
      bool available = await _speech.initialize(
          onStatus: (val) => print('onstatus: $val'),
          onError: (val) => print('onError: $val')
      );
      if (available) {
        setState(() => _islistening = true);
        _speech.listen(
            onResult: (val) => setState(() => noteWidget.text = val.recognizedWords)
        );
      };
    } else {
      setState(() => _islistening = false);
      _speech.stop();
    }
  }
}