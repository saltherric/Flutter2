import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/location/locations_repository_mock.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/ride_preference/ride_preference_repository.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  final LocationsRepositoryMock locationsRepositoryMock;
  RidePreferenceRepositoryMock({required this.locationsRepositoryMock});

  List<RidePreference> get fakeRidePrefs => [
    RidePreference(
      departure: locationsRepositoryMock.fakeLocations[0], // London
      departureDate: DateTime.now().add(Duration(days: 1)), // Tomorrow
      arrival: locationsRepositoryMock.fakeLocations[3], // Paris
      requestedSeats: 2,
    ),
    RidePreference(
      departure: locationsRepositoryMock.fakeLocations[1], // Manchester
      departureDate: DateTime.now().add(Duration(days: 7)), // Next week
      arrival: locationsRepositoryMock.fakeLocations[4], // Lyon
      requestedSeats: 3,
    ),
    RidePreference(
      departure: locationsRepositoryMock.fakeLocations[2], // Birmingham
      departureDate: DateTime.now(), // Today
      arrival: locationsRepositoryMock.fakeLocations[5], // Marseille
      requestedSeats: 1,
    ),
    RidePreference(
      departure: locationsRepositoryMock.fakeLocations[0], // London
      departureDate: DateTime.now().add(Duration(days: 1)), // Tomorrow
      arrival: locationsRepositoryMock.fakeLocations[3], // Paris
      requestedSeats: 2,
    ),
    RidePreference(
      departure: locationsRepositoryMock.fakeLocations[4], // Manchester
      departureDate: DateTime.now().add(Duration(days: 7)), // Next week
      arrival: locationsRepositoryMock.fakeLocations[0], // Lyon
      requestedSeats: 3,
    ),
    RidePreference(
      departure: locationsRepositoryMock.fakeLocations[5], // Birmingham
      departureDate: DateTime.now(), // Today
      arrival: locationsRepositoryMock.fakeLocations[1], // Marseille
      requestedSeats: 1,
    ),
  ];

  @override
  List<RidePreference> getRidePreferences() => fakeRidePrefs;

}