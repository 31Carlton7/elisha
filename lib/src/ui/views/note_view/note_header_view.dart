import 'package:canton_design_system/canton_design_system.dart';
import 'dart:async';

StreamController<bool> streamController = StreamController<bool>();

class NoteHeaderView extends StatefulWidget {
  NoteHeaderView({Key? key}) : super(key: key);
  bool isRecording = false;
  bool testRecording(){
    return false;
  }

  @override
  State<NoteHeaderView> createState() => _NoteHeaderViewState();
}

class _NoteHeaderViewState extends State<NoteHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    onPressed: () {
                      widget.isRecording != widget.isRecording;
                    },
                    icon: const Icon(Icons.mic))))
      ]),
    );
  }
}
