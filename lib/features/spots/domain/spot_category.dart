import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_category.freezed.dart';
part 'spot_category.g.dart';

/// Mirrors the backend's `SpotCategoryRead` schema
/// (`app/schemas/spot_category.py`). Fixed 4-row catalog seeded by
/// migration — `name` is one of 'xtremespot' | 'publico' | 'privado' |
/// 'iconico' (see `spot_category_visuals.dart` for how each looks).
@freezed
abstract class SpotCategory with _$SpotCategory {
  const factory SpotCategory({
    required int id,
    required String name,
    String? description,
  }) = _SpotCategory;

  factory SpotCategory.fromJson(Map<String, dynamic> json) =>
      _$SpotCategoryFromJson(json);
}
