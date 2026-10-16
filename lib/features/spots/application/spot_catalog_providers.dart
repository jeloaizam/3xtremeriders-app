import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/spot_category_api.dart';
import '../data/sport_api.dart';
import '../domain/spot_category.dart';
import '../domain/sport.dart';

part 'spot_catalog_providers.g.dart';

/// The full sport catalog (not scoped to a spot) — used by the "create
/// spot" screen's sport picker.
@Riverpod(keepAlive: true)
Future<List<Sport>> allSports(Ref ref) {
  return ref.read(sportApiProvider).list();
}

/// The fixed 4-row spot category catalog — used by the admin-only category
/// picker on Create/Edit Spot.
@Riverpod(keepAlive: true)
Future<List<SpotCategory>> allSpotCategories(Ref ref) {
  return ref.read(spotCategoryApiProvider).list();
}
