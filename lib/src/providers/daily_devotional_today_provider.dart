import 'package:elisha/src/providers/daily_devotional_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyDevotionalTodayProvider = FutureProvider.autoDispose<String>((ref) {
  ref.maintainState = true;

  return ref.read(dailyDevotionalServiceProvider).value!.todaysDailyDevotional;
});
