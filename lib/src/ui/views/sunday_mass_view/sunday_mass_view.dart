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

import 'package:flutter/services.dart';

import 'package:better_player/better_player.dart';
import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/providers/sunday_mass_service_provider.dart';
import 'package:elisha/src/providers/youtube_fetch_channel_future_provider.dart';
import 'package:elisha/src/providers/youtube_service_provider.dart';
import 'package:elisha/src/ui/components/error_card.dart';
import 'package:elisha/src/ui/views/sunday_mass_view/components/sunday_mass_view_header.dart';

class SundayMassView extends StatelessWidget {
  const SundayMassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      // backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        YOUTUBE_CHANNEL_ID = context.read(localUserRepositoryProvider).getLastChurchYTChannel;

        final channelIds = watch(sundayMassServiceProvider).getChurchYouTubeChannelIds;
        final youtubeChannelRepo = watch(youtubeFetchChannelFutureProvider);
        const _uiElementCount = 5;

        return youtubeChannelRepo.when(
          error: (e, s) {
            return Column(
              children: [
                const SundayMassViewHeader(),
                Expanded(
                  child: Text(
                    'Cannot access Church at this time. Remember Jesus loves you!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            );
          },
          loading: () {
            return Column(
              children: [
                const SundayMassViewHeader(),
                Expanded(
                  child: Loading(),
                ),
              ],
            );
          },
          data: (channel) {
            String videoId() {
              if (channelIds[0] == channel.id) {
                return channel.videos!.where((element) => element.title.contains('The Sunday Mass')).toList()[0].id;
              } else if (channelIds[1] == channel.id) {
                return channel.videos![0].id;
              } else {
                return '';
              }
            }

            return FutureBuilder<String>(
                future: watch(youtubeServiceProvider).getMP4Url(videoId()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                    return Column(
                      children: [
                        const SundayMassViewHeader(),
                        Expanded(
                          child: Loading(),
                        ),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    return const ErrorCard();
                  }

                  return ListView.builder(
                    itemCount: channelIds.length + _uiElementCount,
                    itemBuilder: (context, index) {
                      Widget churchYTChannelCard() {
                        final _index = index - _uiElementCount;
                        var nowPlaying = channelIds[_index] == channel.id;

                        String channelName() {
                          String name = '';
                          if (channelIds[0] == channelIds[_index]) {
                            name = 'National Shrine';
                          } else if (channelIds[1] == channelIds[_index]) {
                            name = 'Heart of the Nation';
                          } else {
                            name = '';
                          }

                          if (nowPlaying) return name + '  -  Now Playing';
                          return name;
                        }

                        return GestureDetector(
                          onTap: () async {
                            if (channelIds[_index] != channel.id) {
                              await context
                                  .read(localUserRepositoryProvider)
                                  .updateLastChurchYTChannel(channelIds[_index]);
                              YOUTUBE_CHANNEL_ID = channelIds[_index];
                              context.refresh(youtubeFetchChannelFutureProvider);
                            }
                          },
                          child: Card(
                            margin: const EdgeInsets.only(top: kSmallPadding),
                            color: Theme.of(context).colorScheme.secondary,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kSmallPadding),
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Theme.of(context).colorScheme.onBackground,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: kSmallPadding),
                                  Text(
                                    channelName(),
                                    style: Theme.of(context).textTheme.headline6,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      switch (index) {
                        case 0:
                          return const SundayMassViewHeader();

                        case 1:
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BetterPlayer.network(
                              snapshot.data!,
                              betterPlayerConfiguration: const BetterPlayerConfiguration(
                                  deviceOrientationsAfterFullScreen: [
                                    DeviceOrientation.portraitUp,
                                    DeviceOrientation.portraitDown
                                  ]),
                            ),
                          );

                        case 2:
                          return const SizedBox(height: kMediumPadding);

                        case 3:
                          return Text('Other Church Services', style: Theme.of(context).textTheme.headline5);

                        case 4:
                          return const SizedBox(height: kMediumPadding);

                        default:
                          return churchYTChannelCard();
                      }
                    },
                  );
                });
          },
        );
      },
    );
  }
}
