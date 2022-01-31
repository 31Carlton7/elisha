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

import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:elisha/src/config/keys.dart';
import 'package:elisha/src/models/youtube_channel.dart';
import 'package:elisha/src/models/youtube_video.dart';

class YouTubeService {
  YouTubeService(this._dio);

  final Dio _dio;

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<YouTubeChannel> fetchChannel(String channelId) async {
    final Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': YOUTUBE_API_KEY,
    };

    Uri uri = Uri.https(_baseUrl, '/youtube/v3/channels', parameters);

    final response = await _dio.getUri(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data['items'][0];
      var channel = YouTubeChannel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(channel.uploadPlaylistId);

      return channel;
    } else {
      throw json.decode(response.data)['error']['message'];
    }
  }

  Future<List<YouTubeVideo>> fetchVideosFromPlaylist(String playlistId) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': YOUTUBE_API_KEY,
    };

    final uri = Uri.https(_baseUrl, '/youtube/v3/playlistItems', parameters);

    // Get Playlist Videos
    final response = await _dio.getUri(uri);

    if (response.statusCode == 200) {
      var data = response.data;

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      var videos = <YouTubeVideo>[];

      for (var json in videosJson) {
        videos.add(YouTubeVideo.fromMap(json['snippet']));
      }

      return videos;
    } else {
      throw json.decode(response.data)['error']['message'];
    }
  }

  Future<String> getMP4Url(String videoId) async {
    try {
      final response = await _dio
          .get('https://maadhav-ytdl.herokuapp.com/video_info.php?url=https://www.youtube.com/watch?v=$videoId');

      if (response.statusCode == 200) {
        var data = response.data;

        // Fetch first eight videos from uploads playlist
        final videoUrl = data['links'][0];

        return videoUrl;
      } else {
        throw json.decode(response.data)['error']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
