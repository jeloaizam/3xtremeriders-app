import 'package:freezed_annotation/freezed_annotation.dart';

part 'hazzard.freezed.dart';
part 'hazzard.g.dart';

/// Mirrors the backend's `HazzardRead` schema (`app/schemas/hazzard.py`).
@freezed
abstract class Hazzard with _$Hazzard {
  const factory Hazzard({
    required int id,
    @JsonKey(name: 'spot_id') required int spotId,
    required String name,
    String? description,
    int? severity,
    @JsonKey(name: 'reported_by') int? reportedBy,
    @JsonKey(name: 'skull_count') @Default(0) int skullCount,
    @JsonKey(name: 'broom_count') @Default(0) int broomCount,
    @JsonKey(name: 'created_date') required DateTime createdDate,
  }) = _Hazzard;

  factory Hazzard.fromJson(Map<String, dynamic> json) =>
      _$HazzardFromJson(json);
}
