import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/daily_devotional_service_provider.dart';
import 'package:elisha/src/ui/components/error_card.dart';
import 'package:elisha/src/ui/components/loading_card.dart';
import 'package:elisha/src/ui/views/daily_devotional_view/daily_devotional_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DailyDevotionalCard extends StatefulWidget {
  const DailyDevotionalCard({Key? key}) : super(key: key);

  @override
  State<DailyDevotionalCard> createState() => _DailyDevotionalCardState();
}

class _DailyDevotionalCardState extends State<DailyDevotionalCard> {
  @override
  Widget build(BuildContext context) {
    Color bgColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.gray[800]!;
      }
      return CantonColors.gray[300]!;
    }

    return Consumer(
      builder: (context, watch, child) {
        final devotionalRepo = watch(dailyDevotionalServiceProvider);

        return devotionalRepo.when(
          error: (e, s) => const ErrorCard(),
          loading: () => const LoadingCard(),
          data: (htmlData) {
            return GestureDetector(
              onTap: () async {
                await CantonMethods.viewTransition(context, DailyDevotionalView(htmlData: htmlData));
              },
              child: Container(
                padding: const EdgeInsets.all(17.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: CantonMethods.alternateCanvasColorType3(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(context, bgColor()),
                          const SizedBox(height: 15),
                          _body(context, bgColor(), htmlData),
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          right: 7,
                          top: 7,
                          child: Container(
                            height: 130,
                            width: 75,
                            decoration: BoxDecoration(
                              color: bgColor(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Container(
                          height: 130,
                          width: 75,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [CantonColors.purple[500]!, CantonColors.purple[600]!],
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              LineAwesomeIcons.praying_hands,
                              color: CantonColors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _header(BuildContext context, Color bgColor) {
    return Text(
      'Daily Devotional',
      style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _body(BuildContext context, Color bgColor, String htmlData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Learn and Meditate on God\'s Word daily',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CantonPrimaryButton(
          containerWidth: 100,
          containerHeight: 40,
          color: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onBackground,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          buttonText: 'Read',
          onPressed: () {
            CantonMethods.viewTransition(
                context,
                DailyDevotionalView(
                  htmlData: htmlData,
                ));
          },
        ),
      ],
    );
  }
}
