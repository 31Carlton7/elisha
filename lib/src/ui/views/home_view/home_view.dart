import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/streaks_repository_provider.dart';
import 'package:elisha/src/ui/views/home_view/components/home_view_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HomeViewHeader(),
          _body(context),
        ],
      );
    });
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _streaksCard(),
      ],
    );
  }

  Widget _streaksCard() {
    const divWidth = 30.0;

    return Consumer(builder: (context, watch, child) {
      final streaksRepo = watch(streaksRepositoryProvider);

      final currentStreak = streaksRepo.currentStreak.toString();
      final bestStreak = streaksRepo.bestStreak.toString();
      final perfectWeeks = streaksRepo.perfectWeeks.toString();

      return Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(currentStreak, style: Theme.of(context).textTheme.headline2),
                            Icon(LineAwesomeIcons.fire, size: 27, color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ),
                      Text(
                        'Streak',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Theme.of(context).colorScheme.secondaryVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35, child: VerticalDivider(width: divWidth)),
                Expanded(
                  child: Column(
                    children: [
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(bestStreak, style: Theme.of(context).textTheme.headline2),
                            Icon(LineAwesomeIcons.star, size: 27, color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ),
                      Text(
                        'Best Streak',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Theme.of(context).colorScheme.secondaryVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35, child: VerticalDivider(width: divWidth)),
                Expanded(
                  child: Column(
                    children: [
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(perfectWeeks, style: Theme.of(context).textTheme.headline2),
                            Icon(LineAwesomeIcons.calendar, size: 27, color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ),
                      Text(
                        'Perfect Weeks',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Theme.of(context).colorScheme.secondaryVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
