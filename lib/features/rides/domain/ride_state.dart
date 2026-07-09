import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride_state.freezed.dart';
part 'ride_state.g.dart';

/// Mirrors the backend's `RideStateRead` schema
/// (`app/schemas/ride_state.py`) — seeded with 4 fixed rows: active,
/// onSale, wasted, toGift.
@freezed
abstract class RideState with _$RideState {
  const factory RideState({
    required int id,
    required String name,
    String? description,
  }) = _RideState;

  factory RideState.fromJson(Map<String, dynamic> json) =>
      _$RideStateFromJson(json);
}
