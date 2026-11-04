import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';
import 'api_exception.dart';

/// `GET /version` response (`backend/app/schemas/version.py`) — no auth,
/// called before login/anything else so the app can refuse to start on an
/// old version. `server_version` isn't consumed yet, only `min_app_version`.
class VersionInfo {
  VersionInfo({required this.minAppVersion});

  final String minAppVersion;

  factory VersionInfo.fromJson(Map<String, dynamic> json) =>
      VersionInfo(minAppVersion: json['min_app_version'] as String);
}

class MinVersionApi {
  // No other `*_api.dart` sets a timeout today, but this call runs before
  // anything else at startup — without one, an unreachable backend would
  // hang the app on a spinner forever instead of showing the retry screen.
  Future<VersionInfo> fetch() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/version'))
        .timeout(const Duration(seconds: 8));
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return VersionInfo.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
