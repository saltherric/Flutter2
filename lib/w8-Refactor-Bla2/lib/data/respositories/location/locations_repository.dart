import 'package:flutter2/w8-Refactor-Bla2/lib/model/ride/locations.dart';

abstract class LocationsRepository {
  List<Location> getSearchLocations(String query);
  List<Location> getLocations();
}