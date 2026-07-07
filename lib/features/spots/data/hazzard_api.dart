import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/hazzard.dart';

part 'hazzard_api.g.dart';

/// Talks to the backend's `/spots/{id}/hazzards` endpoints
/// (`app/routers/hazzard.py`).
class HazzardApi {
  Future<List<Hazzard>> listBySpot(int spotId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/hazzards'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.map((json) => Hazzard.fromJson(json as Map<String, dynamic>)).toList();
  }
}

@riverpod
HazzardApi hazzardApi(Ref ref) => HazzardApi();
