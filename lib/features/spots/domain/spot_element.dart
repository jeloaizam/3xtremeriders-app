import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_element.freezed.dart';
part 'spot_element.g.dart';

/// Mirrors the backend's `SpotElementRead` schema
/// (`app/schemas/spot_element.py`) — a physical feature of a spot (bowl,
/// ramp, rail...), shown as a tag on the Spot detail screen.
@freezed
abstract class SpotElement with _$SpotElement {
  const factory SpotElement({
    required int id,
    @JsonKey(name: 'spot_id') required int spotId,
    required String name,
    String? description,
    String? type,
    int? difficulty,
  }) = _SpotElement;

  factory SpotElement.fromJson(Map<String, dynamic> json) =>
      _$SpotElementFromJson(json);
}
