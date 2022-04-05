import 'package:canton_design_system/canton_design_system.dart';

class TimePickerWidget extends StatefulWidget {
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay time;



  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
    title: 'Time',
    text: getText(),
    onClicked: () => pickTime(context),
  );


}