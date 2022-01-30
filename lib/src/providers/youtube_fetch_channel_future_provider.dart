import 'package:elisha/src/models/youtube_channel.dart';
import 'package:elisha/src/providers/youtube_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: non_constant_identifier_names
var YOUTUBE_CHANNEL_ID = '';

final youtubeFetchChannelFutureProvider = FutureProvider<YouTubeChannel>((ref) {
  return ref.read(youtubeServiceProvider).fetchChannel(YOUTUBE_CHANNEL_ID);
});
