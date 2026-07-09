import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/rider_photo.dart';

part 'rider_photo_api.g.dart';

/// Talks to the backend's `/riders/{id}/photos` endpoint
/// (`app/routers/rider_photo.py`) — a rider's own profile photos,
/// optionally tagged with a Ride.
class RiderPhotoApi {
  Future<List<RiderPhoto>> listByRider(int riderId, {int? rideId}) async {
    final query = rideId != null ? '?ride_id=$rideId' : '';
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/photos$query'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => RiderPhoto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<RiderPhoto> create({
    required int riderId,
    required String url,
    int? rideId,
    String? caption,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/photos'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'url': url, 'ride_id': ?rideId, 'caption': ?caption}),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return RiderPhoto.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
RiderPhotoApi riderPhotoApi(Ref ref) => RiderPhotoApi();
