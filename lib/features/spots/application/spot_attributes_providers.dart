import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/hazzard_api.dart';
import '../data/spot_api.dart';
import '../domain/hazzard.dart';
import '../domain/spot_element.dart';

part 'spot_attributes_providers.g.dart';

/// A spot's hazards — cached per spotId so Home's map quick-view sheet and
/// the Spot detail screen share one fetch.
@Riverpod(keepAlive: true)
Future<List<Hazzard>> spotHazzards(Ref ref, int spotId) {
  return ref.read(hazzardApiProvider).listBySpot(spotId);
}

/// A spot's physical elements — cached per spotId so Home's map quick-view
/// sheet (just needs the count) and the Spot detail screen share one fetch.
@Riverpod(keepAlive: true)
Future<List<SpotElement>> spotElements(Ref ref, int spotId) {
  return ref.read(spotApiProvider).getElements(spotId);
}
