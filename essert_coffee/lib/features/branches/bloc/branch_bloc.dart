import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:essert_coffee/layer%20data/branch_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
part 'branch_event.dart';
part 'branch_state.dart';

/// BLoC for managing branch selection and user location logic.
///
/// Methods:
/// - [getLocation] retrieves the user's current location and determines the nearest branch.
/// - [chooseLocation] updates the selected branch based on the chosen marker.
///
/// Emits:
/// - [SuccessState] after successfully getting the location and calculating distances.
/// - [UpdateState] to reflect changes in the selected branch.
/// - [ErrorState] if location fetching fails.
class BranchBloc extends Bloc<BranchEvent, BranchState> {
  /// Stores the user's current location as latitude and longitude.
  LatLng? currentLocation;

  /// ID of the selected branch marker on the map.
  String? selectedMarkerId;

  /// Distance from user to Branch 1 in kilometers.
  double? distanceToBranch1;

  /// Distance from user to Branch 2 in kilometers.
  double? distanceToBranch2;

  /// Dependency injection to access branch data.
  final branchGetIt = GetIt.I.get<BranchData>();

  BranchBloc() : super(BranchInitial()) {
    on<BranchEvent>((event, emit) {});
    on<CurrentLocationEvent>(getLocation);
    on<LocationEvent>(chooseLocation);
  }

  /// Handles the event to get the user's current location,
  /// calculate distances to branches, and select the nearest one.
  FutureOr<void> getLocation(
    CurrentLocationEvent event,
    Emitter<BranchState> emit,
  ) async {
    try {
      // Define location accuracy and update frequency
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      // Get the current GPS position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      // Convert the position to LatLng format
      currentLocation = LatLng(position.latitude, position.longitude);

      // Calculate distance to Branch 1 (in kilometers)
      distanceToBranch1 =
          Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            24.687603,
            46.795084,
          ) /
          1000;
      // Calculate distance to Branch 2 (in kilometers)
      distanceToBranch2 =
          Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            24.768176,
            46.621355,
          ) /
          1000;
      emit(SuccessState());
      if (distanceToBranch1! > 30 && distanceToBranch2! > 30) {
        emit(
          ErrorState("Sorry, there is no branch near your current location."),
        );
        return;
      }
      // Determine closest branch
      if (distanceToBranch1! <= distanceToBranch2!) {
        selectedMarkerId = '1';
      } else {
        selectedMarkerId = '2';
      }
      branchGetIt.selectedBranchId = selectedMarkerId;

      emit(UpdateState(selectedMarkerId!));
    } catch (e) {
      emit(ErrorState('Failed to get location: $e'));
    }
  }

  /// Handles the event to manually choose a branch location by marker ID.
  FutureOr<void> chooseLocation(
    LocationEvent event,
    Emitter<BranchState> emit,
  ) {
    // Update selected marker ID from the event
    selectedMarkerId = event.markerId;

    // Store the selected branch ID globally
    branchGetIt.selectedBranchId = selectedMarkerId;
    emit(UpdateState(selectedMarkerId));
  }
}
