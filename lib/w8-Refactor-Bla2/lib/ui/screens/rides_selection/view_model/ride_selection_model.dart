import 'package:flutter/material.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/ride/rides_repository.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/model/ride/ride.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/model/ride_pref/ride_pref.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/state/ride_pref_state.dart';

class RideSelectionModel extends ChangeNotifier {
  final RidePreferenceState ridePreferenceState;
  final RidesRepository ridesRepository;

  RideSelectionModel({required this.ridePreferenceState, required this.ridesRepository}) {
    ridePreferenceState.addListener(notifyListeners);
  }

  RidePreference get selectedRidePreference => ridePreferenceState.selectedPreference!;

  List<Ride> get matchingRides {
    final selectedPref = selectedRidePreference;

    return ridesRepository.getRides().where((ride) {
      return ride.departureLocation == selectedPref.departure &&
      ride.arrivalLocation == selectedPref.arrival &&
      ride.availableSeats >= selectedPref.requestedSeats;
    }).toList();
  }

  void selectRidePreference(RidePreference newPreference) {
    ridePreferenceState.selectPreference(newPreference);
  }

  @override
  void dispose() {
    ridePreferenceState.removeListener(notifyListeners);
    super.dispose();
  }
}