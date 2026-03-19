import 'package:flutter/material.dart';
import '../../data/respositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository ridePreferenceRepository;

  RidePreference? selectedPreference;
  late List<RidePreference> history;

  RidePreferenceState({required this.ridePreferenceRepository}) {
    history = List.from(ridePreferenceRepository.getRidePreferences());
  }

  void selectPreference(RidePreference newPreference) {
    if (selectedPreference == newPreference) {
      return;
    }

    selectedPreference = newPreference;

      history.remove(newPreference);
      history.insert(0, newPreference);

    notifyListeners();
  }
}