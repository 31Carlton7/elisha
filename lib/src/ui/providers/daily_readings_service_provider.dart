import 'package:elisha/src/services/daily_readings_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyReadingsServiceProvider = Provider<DailyReadingsService>((ref) {
  return DailyReadingsService();
});
