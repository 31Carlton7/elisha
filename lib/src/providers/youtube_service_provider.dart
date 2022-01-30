import 'package:dio/dio.dart';
import 'package:elisha/src/services/youtube_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final youtubeServiceProvider = Provider<YouTubeService>((ref) {
  return YouTubeService(Dio());
});
