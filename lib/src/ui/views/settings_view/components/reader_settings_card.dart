/*
Elisha iOS & Android App
Copyright (C) 2022 Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:canton_ui/canton_ui.dart';
import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ReaderSettingsCard extends ConsumerWidget {
  const ReaderSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async => await _showReaderSettingsBottomSheet(context, ref),
      child: Card(
        color: CantonMethods.alternateCanvasColorType3(context),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
          alignment: Alignment.centerLeft,
          child: Text(
            'Adjust Reader Settings',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }

  Future<void> _showReaderSettingsBottomSheet(BuildContext context, WidgetRef ref) async {
    var screenBrightness = await ScreenBrightness().system;

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          widthFactor: Responsive.isTablet(context) ? 0.75 : null,
          child: StatefulBuilder(
            builder: (context, setState) {
              Widget brightnessControls = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(CupertinoIcons.sun_min_fill, size: 27),
                    Expanded(
                      child: Slider(
                        value: screenBrightness,
                        onChanged: (val) async {
                          await ScreenBrightness().setScreenBrightness(val);
                          setState(() => screenBrightness = val);
                        },
                      ),
                    ),
                    const Icon(CupertinoIcons.sun_max_fill, size: 34),
                  ],
                ),
              );

              Widget textSizeControls = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Text Size', style: Theme.of(context).textTheme.headline5),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(readerSettingsRepositoryProvider).decrementBodyTextSize();
                        await ref.read(readerSettingsRepositoryProvider).decrementVerseNumberSize();
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          'A',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                fontSize: 16,
                                height: 1.25,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(readerSettingsRepositoryProvider).incrementBodyTextSize();
                        await ref.read(readerSettingsRepositoryProvider).incrementVerseNumberSize();
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          'A',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                fontSize: 24,
                                height: 1.25,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              );

              Widget fontControls = CantonExpansionTile(
                childrenPadding: EdgeInsets.zero,
                iconColor: Theme.of(context).colorScheme.primary,
                title: Text(
                  ref.watch(readerSettingsRepositoryProvider).typeFace,
                  style: Theme.of(context).textTheme.headline5,
                ),
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await ref.read(readerSettingsRepositoryProvider).setTypeFace('New York');
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'New York',
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                                  fontFamily: 'New York',
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 17),
                      GestureDetector(
                        onTap: () async {
                          await ref.read(readerSettingsRepositoryProvider).setTypeFace('Inter');
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Inter',
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                                  fontFamily: 'Inter',
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );

              Widget lineHeightControls = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Line Spacing', style: Theme.of(context).textTheme.headline5),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(readerSettingsRepositoryProvider).decrementBodyTextHeight();
                        await ref.read(readerSettingsRepositoryProvider).decrementVerseNumberHeight();
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.format_line_spacing,
                            color: Theme.of(context).colorScheme.onBackground, size: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(readerSettingsRepositoryProvider).incrementBodyTextHeight();
                        await ref.read(readerSettingsRepositoryProvider).incrementVerseNumberHeight();
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.format_line_spacing,
                            color: Theme.of(context).colorScheme.onBackground, size: 26),
                      ),
                    ),
                  ],
                ),
              );

              final spans = <InlineSpan>[
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Column(
                      children: [
                        Text(
                          '20',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                fontSize: ref.watch(readerSettingsRepositoryProvider).verseNumberSize * 1.1,
                                height: ref.watch(readerSettingsRepositoryProvider).verseNumberHeight,
                                fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                              ),
                        ),
                        const Icon(
                          LineAwesomeIcons.heart_1,
                          size: 10,
                          color: CantonColors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                const TextSpan(text: '... I am with you alway, even unto the end of the world. Amen.'),
              ];

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 17),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Example Text',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Theme.of(context).colorScheme.secondaryContainer,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Text.rich(
                          TextSpan(children: spans),
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: ref.watch(readerSettingsRepositoryProvider.notifier).bodyTextSize * 1.4,
                                height: ref.watch(readerSettingsRepositoryProvider.notifier).bodyTextHeight * 1.1,
                                fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                              ),
                        ),
                      ),
                      const Divider(height: 34),
                      brightnessControls,
                      const Divider(height: 34),
                      textSizeControls,
                      const SizedBox(height: 17),
                      const Divider(),
                      const SizedBox(height: 5),
                      fontControls,
                      const Divider(height: 17),
                      const SizedBox(height: 8.5),
                      lineHeightControls,
                      const Divider(height: 34),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
