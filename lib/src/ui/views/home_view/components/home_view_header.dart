import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Morning';
      }
      if (hour < 17) {
        return 'Afternoon';
      }
      return 'Evening';
    }

    String name(String source) {
      if (source.length > 18) {
        return source.substring(0, 15) + '...';
      }
      return source;
    }

    String? dbName = context.read(localUserRepositoryProvider).firstName;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Good ' + greeting(),
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
              ),
              dbName != ''
                  ? Text(
                      name(dbName),
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
