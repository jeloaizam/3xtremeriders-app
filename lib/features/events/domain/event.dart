import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

/// Mirrors the backend's `EventRead` schema (`app/schemas/event.py`).
@freezed
abstract class Event with _$Event {
  const factory Event({
    required int id,
    required String name,
    required String description,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') DateTime? endDate,
    @JsonKey(name: 'spot_id') int? spotId,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'created_by') required int createdBy,
    @JsonKey(name: 'state_id') int? stateId,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    @JsonKey(name: 'created_date') required DateTime createdDate,
    @JsonKey(name: 'updated_date') DateTime? updatedDate,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
