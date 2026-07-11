import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/city.dart';

part 'city_api.g.dart';

/// Talks to the backend's read-only `/cities` endpoint
/// (`app/routers/city.py`).
class CityApi {
  Future<List<City>> list({required int countryId}) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/cities/?country_id=$countryId'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => City.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
CityApi cityApi(Ref ref) => CityApi();

/// A country's city catalog, keyed by country id — only the countries
/// seeded in the `city` migration have any rows; the rest return an empty
/// list, which the city dropdown just renders as no options.
@riverpod
Future<List<City>> cities(Ref ref, int countryId) {
  return ref.read(cityApiProvider).list(countryId: countryId);
}
