import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';

class NoteHeaderView extends StatelessWidget {
  const NoteHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Note', style: Theme.of(context).textTheme.headline3),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.mic))))
          ]),
    );
  }
}
