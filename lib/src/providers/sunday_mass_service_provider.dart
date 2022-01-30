import 'package:elisha/src/services/sunday_mass_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sundayMassServiceProvider = Provider<SundayMassService>((ref) {
  return SundayMassService();
});
