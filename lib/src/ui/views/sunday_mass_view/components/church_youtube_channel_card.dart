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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/youtube_channel.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/providers/youtube_fetch_channel_future_provider.dart';
import 'package:elisha/src/providers/youtube_fetch_latest_church_video_future_provider.dart';

class ChurchYouTubeChannelCard extends ConsumerWidget {
  const ChurchYouTubeChannelCard({
    Key? key,
    required this.index,
    required this.uiElementCount,
    required this.videoId,
    required this.channelIds,
    required this.channel,
  }) : super(key: key);

  final int index;
  final int uiElementCount;
  final String videoId;
  final List<String> channelIds;
  final YouTubeChannel channel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _index = index - uiElementCount;
    var nowPlaying = channelIds[_index] == channel.id;

    String channelName() {
      String name = '';
      if (channelIds[0] == channelIds[_index]) {
        name = 'National Shrine';
      } else if (channelIds[1] == channelIds[_index]) {
        name = 'Heart of the Nation';
      } else if (channelIds[2] == channelIds[_index]) {
        name = 'Cornerstone Chapel (Hagee Ministries)';
      } else if (channelIds[3] == channelIds[_index]) {
        name = 'Daily TV Mass';
      } else {
        name = '';
      }

      return name;
    }

    String description() {
      String desc = '';
      if (channelIds[0] == channelIds[_index]) {
        desc = 'Washington DC, USA';
      } else if (channelIds[1] == channelIds[_index]) {
        desc = 'Milwaukee, WI, USA';
      } else if (channelIds[2] == channelIds[_index]) {
        desc = 'San Antonio, TX, USA';
      } else if (channelIds[3] == channelIds[_index]) {
        desc = 'Toronto, Ontario, Canada';
      } else {
        desc = '';
      }

      return desc;
    }

    return GestureDetector(
      onTap: () async {
        if (channelIds[_index] != videoId) {
          YOUTUBE_CHANNEL_ID = channelIds[_index];
          await ref.read(localUserRepositoryProvider).updateLastChurchYTChannel(channelIds[_index]);
          ref.refresh(youtubeFetchLatestChurchVideoFutureProvider);
        }
      },
      child: Card(
        margin: const EdgeInsets.only(top: kSmallPadding),
        color: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          side: nowPlaying
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : BorderSide.none,
        ),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channelName(),
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      description(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: !nowPlaying ? Theme.of(context).colorScheme.secondaryContainer : null,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
