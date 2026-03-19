import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/location/locations_repository.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/location/locations_repository_mock.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/ride/rides_repository.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/ride/rides_repository_mock.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/ride_preference/ride_preference_repository.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/ride_preference/ride_preference_repository_mock.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/user/user_repository_mock.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/main_common.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/state/ride_pref_state.dart';
import 'package:provider/provider.dart';

List<InheritedProvider> get devProviders {
  final locationsRepository = LocationsRepositoryMock();
  final userRepository = UserRepositoryMock();

  final ridePreferenceRepository = RidePreferenceRepositoryMock(
    locationsRepositoryMock: locationsRepository,
  );

  final ridesRepository = RidesRepositoryMock(
    locationsRepositoryMock: locationsRepository,
    userRepositoryMock: userRepository,
  );

  return [
    Provider<LocationsRepository>.value(value: locationsRepository),
    Provider<RidePreferenceRepository>.value(value: ridePreferenceRepository),
    Provider<RidesRepository>.value(value: ridesRepository),
    ChangeNotifierProvider<RidePreferenceState>(
      create: (_) => RidePreferenceState(
        ridePreferenceRepository: ridePreferenceRepository,
      ),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}