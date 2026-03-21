import 'package:flutter/material.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/model/ride_pref/ride_pref.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/state/ride_pref_state.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState ridePreferenceState;

  HomeViewModel({required this.ridePreferenceState}) {
    ridePreferenceState.addListener(notifyListeners);
  }

    RidePreference? get selectedPreference => ridePreferenceState.selectedPreference;

    List<RidePreference> get history => ridePreferenceState.history;
    
    void selectRidePreference(RidePreference ridePreference) {
      ridePreferenceState.selectPreference(ridePreference);
    }
    @override
    void dispose() {
      ridePreferenceState.removeListener(notifyListeners);
      super.dispose();
    }
}