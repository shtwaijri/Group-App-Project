import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A model class representing a branch location on the map.
class Branch {
  final String id;
  final String name;
  final LatLng location;

  Branch({required this.id, required this.name, required this.location});
}

/// A list of available branch locations.
final List<Branch> branches = [
  Branch(
    id: '1',
    name: 'Ar Rawabi Branch',
    location: LatLng(24.687603, 46.795084),
  ),
  Branch(
    id: '2',
    name: 'Hittin Branch',
    location: LatLng(24.768176, 46.621355),
  ),
];
