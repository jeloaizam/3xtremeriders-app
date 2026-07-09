import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride.freezed.dart';
part 'ride.g.dart';

/// Mirrors the backend's `RideRead` schema (`app/schemas/ride.py`) — a
/// rider's piece of gear/vehicle (a bike, a board, a scooter...), not a
/// riding session.
@freezed
abstract class Ride with _$Ride {
  const factory Ride({
    required int id,
    required String name,
    @JsonKey(name: 'owner_id') required int ownerId,
    @JsonKey(name: 'state_id') int? stateId,
    int? condition,
    @JsonKey(name: 'cover_photo_id') int? coverPhotoId,
    @JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,
    @JsonKey(name: 'created_date') required DateTime createdDate,
    @JsonKey(name: 'wasted_date') DateTime? wastedDate,
  }) = _Ride;

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
}
