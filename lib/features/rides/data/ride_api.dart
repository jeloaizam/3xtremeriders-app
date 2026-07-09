import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/ride.dart';
import '../domain/ride_element.dart';
import '../domain/ride_state.dart';

part 'ride_api.g.dart';

/// Talks to the backend's `/rides`, `/riders/{id}/rides` and
/// `/ride-states` endpoints (`app/routers/ride.py`, `app/routers/rider.py`,
/// `app/routers/ride_state.py`).
class RideApi {
  Future<List<Ride>> listByOwner(int riderId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/rides'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Ride.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Ride> get(int rideId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/rides/$rideId'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Ride.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<Ride> create({
    required String name,
    int? stateId,
    int? condition,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/rides/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'state_id': ?stateId,
        'condition': ?condition,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return Ride.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Sets which of the rider's uploaded photos (tagged with this ride) is
  /// the cover shown on `MyRidesScreen` and `RideScreen`.
  Future<Ride> setCoverPhoto({
    required int rideId,
    required int coverPhotoId,
    required String idToken,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/rides/$rideId'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'cover_photo_id': coverPhotoId}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Ride.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<RideElement>> getElements(int rideId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/rides/$rideId/elements'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => RideElement.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<RideElement> addElement({
    required int rideId,
    required String name,
    String? type,
    String? brand,
    String? model,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/rides/$rideId/elements'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'type': ?type,
        'brand': ?brand,
        'model': ?model,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return RideElement.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<List<RideState>> listStates() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/ride-states/'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => RideState.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
RideApi rideApi(Ref ref) => RideApi();
