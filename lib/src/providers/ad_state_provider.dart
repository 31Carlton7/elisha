import 'package:elisha/src/services/ad_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adStateProvider = Provider<AdState>((ref) {
  return AdState();
});
