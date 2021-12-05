import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/daily_reading.dart';
import 'package:elisha/src/services/daily_readings_service.dart';

final dailyReadingsProvider = FutureProvider.autoDispose<DailyReading>((ref) {
  ref.maintainState = true;
  return DailyReadingsService().getTodaysReading;
});
