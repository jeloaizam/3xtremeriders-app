import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/spot_category.dart';

part 'spot_category_api.g.dart';

/// Talks to the backend's `/spot-categories` endpoint
/// (`app/routers/spot_category.py`) — read-only, the catalog is seeded by
/// migration.
class SpotCategoryApi {
  Future<List<SpotCategory>> list() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spot-categories/'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => SpotCategory.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
SpotCategoryApi spotCategoryApi(Ref ref) => SpotCategoryApi();
