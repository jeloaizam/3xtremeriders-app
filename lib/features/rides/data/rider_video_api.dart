import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/rider_video.dart';

part 'rider_video_api.g.dart';

/// Talks to the backend's `/riders/{id}/videos` endpoint
/// (`app/routers/rider_video.py`) — a rider's own profile videos,
/// optionally tagged with a Ride.
class RiderVideoApi {
  Future<List<RiderVideo>> listByRider(int riderId, {int? rideId}) async {
    final query = rideId != null ? '?ride_id=$rideId' : '';
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/videos$query'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => RiderVideo.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<RiderVideo> create({
    required int riderId,
    required String url,
    int? rideId,
    String? provider,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/videos'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'url': url, 'ride_id': ?rideId, 'provider': ?provider}),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return RiderVideo.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
RiderVideoApi riderVideoApi(Ref ref) => RiderVideoApi();
