import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/report.dart';

part 'report_api.g.dart';

/// Talks to the backend's polymorphic `/reports` endpoint
/// (`app/routers/report.py`) — `create` is open to any authenticated rider,
/// `list`/`updateState` require moderator+ server-side (`require_moderator`).
class ReportApi {
  Future<Report> create({
    required String targetType,
    required int targetId,
    required String reason,
    String? details,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/reports/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'target_type': targetType,
        'target_id': targetId,
        'reason': reason,
        'details': ?details,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return Report.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<Report>> list({
    int? state,
    String? targetType,
    required String idToken,
  }) async {
    final query = {
      'state': ?state?.toString(),
      'target_type': ?targetType,
    };
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/reports/',
    ).replace(queryParameters: query.isEmpty ? null : query);
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Report.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Report> updateState({
    required int reportId,
    required int state,
    required String idToken,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/reports/$reportId'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'state': state}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Report.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}

@riverpod
ReportApi reportApi(Ref ref) => ReportApi();
