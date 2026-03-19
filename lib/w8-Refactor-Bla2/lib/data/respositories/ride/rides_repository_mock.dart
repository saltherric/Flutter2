import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/location/locations_repository_mock.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/ride/rides_repository.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/user/user_repository_mock.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/model/ride/ride.dart';

class RidesRepositoryMock implements RidesRepository{
  final LocationsRepositoryMock locationsRepositoryMock;
  final UserRepositoryMock userRepositoryMock;
  RidesRepositoryMock({required this.locationsRepositoryMock, required this.userRepositoryMock});

  List<Ride> get fakeRides => [
    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[0], // London
      departureDate: DateTime.now().add(Duration(hours: 3)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[19], // Paris
      arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
      driver: userRepositoryMock.fakeUsers[0],
      availableSeats: 2,
      pricePerSeat: 25.0,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[0], // London
      departureDate: DateTime.now().add(Duration(hours: 10)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[19], // Paris
      arrivalDateTime: DateTime.now().add(Duration(hours: 9)),
      driver: userRepositoryMock.fakeUsers[1],
      availableSeats: 1,
      pricePerSeat: 30.0,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[2], // Birmingham
      departureDate: DateTime.now().add(Duration(days: 1)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[22], // Toulouse
      arrivalDateTime: DateTime.now().add(Duration(days: 1, hours: 4)),
      driver: userRepositoryMock.fakeUsers[2],
      availableSeats: 2,
      pricePerSeat: 22.5,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[3], // Liverpool
      departureDate: DateTime.now().add(Duration(days: 2)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[23], // Nice
      arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 6)),
      driver: userRepositoryMock.fakeUsers[3],
      availableSeats: 3,
      pricePerSeat: 35.0,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[4], // Leeds
      departureDate: DateTime.now().add(Duration(days: 2, hours: 5)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[24], // Nantes
      arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 10)),
      driver: userRepositoryMock.fakeUsers[4],
      availableSeats: 4,
      pricePerSeat: 28.0,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[5], // Glasgow
      departureDate: DateTime.now().add(Duration(days: 3)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[25], // Strasbourg
      arrivalDateTime: DateTime.now().add(Duration(days: 3, hours: 7)),
      driver: userRepositoryMock.fakeUsers[5],
      availableSeats: 3,
      pricePerSeat: 40.0,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[6], // Sheffield
      departureDate: DateTime.now().add(Duration(days: 3, hours: 2)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[26], // Montpellier
      arrivalDateTime: DateTime.now().add(Duration(days: 3, hours: 8)),
      driver: userRepositoryMock.fakeUsers[0],
      availableSeats: 2,
      pricePerSeat: 26.0,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[7], // Bristol
      departureDate: DateTime.now().add(Duration(days: 4)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[27], // Bordeaux
      arrivalDateTime: DateTime.now().add(Duration(days: 4, hours: 6)),
      driver: userRepositoryMock.fakeUsers[1],
      availableSeats: 3,
      pricePerSeat: 29.0,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[8], // Edinburgh
      departureDate: DateTime.now().add(Duration(days: 4, hours: 4)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[28], // Lille
      arrivalDateTime: DateTime.now().add(Duration(days: 4, hours: 9)),
      driver: userRepositoryMock.fakeUsers[2],
      availableSeats: 4,
      pricePerSeat: 27.5,
    ),

    Ride(
      departureLocation: locationsRepositoryMock.fakeLocations[9], // Leicester
      departureDate: DateTime.now().add(Duration(days: 5)),
      arrivalLocation: locationsRepositoryMock.fakeLocations[29], // Rennes
      arrivalDateTime: DateTime.now().add(Duration(days: 5, hours: 5)),
      driver: userRepositoryMock.fakeUsers[3],
      availableSeats: 3,
      pricePerSeat: 24.0,
    ),
  ];

  @override
  List<Ride> getRides() => fakeRides;
  
}