import 'package:freezed_annotation/freezed_annotation.dart';

part 'sport.freezed.dart';
part 'sport.g.dart';

/// Mirrors the backend's `SportRead` schema (`app/schemas/sport.py`).
@freezed
abstract class Sport with _$Sport {
  const factory Sport({
    required int id,
    required String name,
    required String description,
  }) = _Sport;

  factory Sport.fromJson(Map<String, dynamic> json) => _$SportFromJson(json);
}
