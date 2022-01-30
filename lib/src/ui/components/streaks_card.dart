import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/streaks_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class StreaksCard extends StatelessWidget {
  const StreaksCard({Key? key, required this.marginalPadding}) : super(key: key);

  final bool marginalPadding;

  @override
  Widget build(BuildContext context) {
    const divWidth = 30.0;

    return Consumer(
      builder: (context, watch, child) {
        final streaksRepo = watch(streaksRepositoryProvider);

        final currentStreak = streaksRepo.currentStreak.toString();
        final bestStreak = streaksRepo.bestStreak.toString();
        final perfectWeeks = streaksRepo.perfectWeeks.toString();

        return Container(
          margin: marginalPadding ? const EdgeInsets.symmetric(horizontal: 17) : EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: CantonMethods.alternateCanvasColorType3(context),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      FittedBox(child: Text('Streak', style: Theme.of(context).textTheme.bodyText1)),
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
                      FittedBox(child: Text('Best Streak', style: Theme.of(context).textTheme.bodyText1)),
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
                      FittedBox(child: Text('Perfect Weeks', style: Theme.of(context).textTheme.bodyText1)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
