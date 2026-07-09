import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride_element.freezed.dart';
part 'ride_element.g.dart';

/// Mirrors the backend's `RideElementRead` schema
/// (`app/schemas/ride_element.py`) — a piece of gear belonging to a [Ride]
/// (e.g. pedals, handlebar, seat, wheels for a bike).
@freezed
abstract class RideElement with _$RideElement {
  const factory RideElement({
    required int id,
    @JsonKey(name: 'ride_id') required int rideId,
    required String name,
    String? type,
    String? brand,
    String? model,
    String? description,
    @JsonKey(name: 'icon_image') String? iconImage,
    @JsonKey(name: 'created_date') required DateTime createdDate,
  }) = _RideElement;

  factory RideElement.fromJson(Map<String, dynamic> json) =>
      _$RideElementFromJson(json);
}
