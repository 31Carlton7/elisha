import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';

class ListofNotesHeaderView extends StatelessWidget {
  const ListofNotesHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(alignment: Alignment.centerLeft,child: Text('Notes', style: Theme.of(context).textTheme.headline3)),
      ),
    );
  }
}
