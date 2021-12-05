import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/user.dart';
import 'package:elisha/src/providers/user_stream_provider.dart';
import 'package:elisha/src/ui/components/something_went_wrong.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final userStreamRepo = watch(userStreamProvider);

      return userStreamRepo.when(
        error: (e, s) {
          return const SomethingWentWrong();
        },
        loading: () => Loading(),
        data: (user) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(context, user),
              _body(context),
            ],
          );
        },
      );
    });
  }

  Widget _header(BuildContext context, User user) {
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
              Text(
                name(user.firstName!),
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: const [],
    );
  }
}
