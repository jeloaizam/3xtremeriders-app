import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/spot.dart';

part 'spots_providers.g.dart';

/// Mock spots for now — swap the body for a real `/spot` API call when that
/// endpoint is wired up.
@riverpod
List<Spot> nearbySpots(Ref ref) => mockSpots;
