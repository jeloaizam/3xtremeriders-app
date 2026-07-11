import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';
part 'city.g.dart';

/// Mirrors the backend's `CityRead` schema (`app/schemas/city.py`).
@freezed
abstract class City with _$City {
  const factory City({
    required int id,
    required String name,
    @JsonKey(name: 'country_id') required int countryId,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
