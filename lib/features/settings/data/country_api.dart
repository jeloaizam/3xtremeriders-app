import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/country.dart';

part 'country_api.g.dart';

/// Talks to the backend's read-only `/countries` endpoint
/// (`app/routers/country.py`).
class CountryApi {
  Future<List<Country>> list() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/countries/'));
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Country.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
CountryApi countryApi(Ref ref) => CountryApi();

/// The full country catalog, fetched once. Static reference data — kept
/// alive for the app's lifetime rather than refetched on every visit to
/// Settings.
@Riverpod(keepAlive: true)
Future<List<Country>> countries(Ref ref) {
  return ref.read(countryApiProvider).list();
}
