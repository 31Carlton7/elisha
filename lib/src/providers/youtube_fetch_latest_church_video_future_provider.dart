import 'package:elisha/src/providers/youtube_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final youtubeFetchLatestChurchVideoFutureProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.read(youtubeServiceProvider).fetchLatestChurchVideoId();
});
