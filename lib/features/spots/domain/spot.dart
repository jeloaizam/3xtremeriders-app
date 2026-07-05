import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'spot.freezed.dart';

/// Mock spot model for the Home map, until `/spot` is wired to the backend.
@freezed
abstract class Spot with _$Spot {
  const factory Spot({
    required String name,
    required String meta,
    required double rating,
    required IconData sportIcon,
    required double lat,
    required double lng,
    required Color pinColor,
  }) = _Spot;
}

/// Sample data matching the design's example spots, relocated to Bogotá D.C.
const mockSpots = [
  Spot(
    name: 'EL FORO',
    meta: 'Skate · 1.2 km',
    rating: 4.6,
    sportIcon: Symbols.skateboarding,
    lat: 4.7050,
    lng: -74.0650,
    pinColor: Color(0xFF48B3AF),
  ),
  Spot(
    name: 'LA OLA',
    meta: 'Surf · 3.4 km',
    rating: 4.2,
    sportIcon: Symbols.surfing,
    lat: 4.6970,
    lng: -74.0850,
    pinColor: Color(0xFF476EAE),
  ),
  Spot(
    name: 'CERRO GRIS',
    meta: 'MTB · 5.8 km',
    rating: 4.8,
    sportIcon: Symbols.pedal_bike,
    lat: 4.7250,
    lng: -74.0550,
    pinColor: Color(0xFFA7E399),
  ),
];
