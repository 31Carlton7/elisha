import 'package:dio/dio.dart';
import 'package:elisha/src/services/daily_devotional_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyDevotionalServiceProvider = FutureProvider<String>((ref) {
  return DailyDevotionalService(Dio()).todaysDailyDevotional;
});
