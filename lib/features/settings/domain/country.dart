import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

/// Mirrors the backend's `CountryRead` schema (`app/schemas/country.py`).
@freezed
abstract class Country with _$Country {
  const factory Country({
    required int id,
    required String name,
    @JsonKey(name: 'iso_code') required String isoCode,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
