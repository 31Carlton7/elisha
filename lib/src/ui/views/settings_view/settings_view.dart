import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/settings_view/components/change_birth_date_card.dart';
import 'package:elisha/src/ui/views/settings_view/components/change_first_name_card.dart';
import 'package:elisha/src/ui/views/settings_view/components/change_last_name_card.dart';
import 'package:elisha/src/ui/views/settings_view/components/settings_view_header.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CantonScaffoldType2(
      backgroundColor: Theme.of(context).canvasColor,
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SettingsViewHeader(),
          const SizedBox(height: 17),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const ChangeFirstNameCard(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 17), child: Divider()),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const ChangeLastNameCard(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 17), child: Divider()),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const ChangeBirthDateCard(),
          ),
        ],
      ),
    );
  }
}
