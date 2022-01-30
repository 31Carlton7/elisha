import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileViewHeader extends ConsumerWidget {
  const ProfileViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String? dbName = watch(localUserRepositoryProvider).getUser.firstName;

    String name(String source) {
      if (source.length > 18) {
        return source.substring(0, 15) + '...';
      }
      return 'Hi, ' + source;
    }

    return Container(
      padding: const EdgeInsets.only(top: 17, left: 34, right: 17),
      child: Text(name(dbName), style: Theme.of(context).textTheme.headline2?.copyWith(fontWeight: FontWeight.w700)),
    );
  }
}
