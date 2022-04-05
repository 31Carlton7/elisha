import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/settings_view/settings_header_view.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsHeaderView(),
        Card(
          color: CantonMethods.alternateCanvasColorType2(context),
          shape: CantonSmoothBorder.defaultBorder(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Daily Remainder', style: Theme.of(context).textTheme.bodyText1,),
                    buildSwitch()
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Remind me for devotion at: ', style: Theme.of(context).textTheme.bodyText1,),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Select Time',
                            hintStyle: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Switch Do Not Disturb Mode: ', style: Theme.of(context).textTheme.bodyText1,),
                    CantonPrimaryButton(
                      buttonText: 'SWITCH',
                      textColor: Colors.black,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],

    );
  }
  Widget buildSwitch() => Transform.scale(
    scale: 2,
    child: Switch.adaptive(
      activeColor: Colors.blueGrey,
      activeTrackColor: Colors.blueGrey.withOpacity(0.4),
      inactiveThumbColor: Colors.black87,
      inactiveTrackColor: Colors.black12,
      splashRadius: 50,
      value: value,
      onChanged: (value) => setState(() => this.value = value),
    ),
  );

}
