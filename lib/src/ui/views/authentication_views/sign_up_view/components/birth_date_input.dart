import 'package:canton_design_system/canton_design_system.dart';

class BirthDateInput extends StatelessWidget {
  const BirthDateInput({Key? key, required this.birthDateText, required this.showBirthDatePicker}) : super(key: key);

  final String birthDateText;
  final Future<void> Function() showBirthDatePicker;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showBirthDatePicker();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(
              'Birthday',
              style: Theme.of(context).inputDecorationTheme.labelStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.all(13),
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              shape: CantonSmoothBorder.smallBorder(),
            ),
            child: Row(
              children: [
                Text(
                  birthDateText,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
