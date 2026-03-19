import 'package:flutter2/w8-Refactor-Bla2/lib/data/respositories/user/user_repository.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/model/user/user.dart';

class UserRepositoryMock implements UserRepository{
  List<User> fakeUsers = [
    User(
      firstName: "Alice",
      lastName: "Dupont",
      email: "alice.dupont@example.com",
      phone: "+33 612345678",
      profilePicture: "https://randomuser.me/api/portraits/women/1.jpg",
      verifiedProfile: true,
    ),
    User(
      firstName: "Bob",
      lastName: "Smith",
      email: "bob.smith@example.com",
      phone: "+44 789456123",
      profilePicture: "https://randomuser.me/api/portraits/men/2.jpg",
      verifiedProfile: false,
    ),
    User(
      firstName: "Charlie",
      lastName: "Martin",
      email: "charlie.martin@example.com",
      phone: "+33 674839201",
      profilePicture: "https://randomuser.me/api/portraits/men/3.jpg",
      verifiedProfile: true,
    ),
    User(
      firstName: "Diane",
      lastName: "Lemoine",
      email: "diane.lemoine@example.com",
      phone: "+44 741258963",
      profilePicture: "https://randomuser.me/api/portraits/women/4.jpg",
      verifiedProfile: true,
    ),
    User(
      firstName: "Ethan",
      lastName: "Brown",
      email: "ethan.brown@example.com",
      phone: "+44 785412369",
      profilePicture: "https://randomuser.me/api/portraits/men/5.jpg",
      verifiedProfile: false,
    ),
    User(
      firstName: "Fanny",
      lastName: "Durand",
      email: "fanny.durand@example.com",
      phone: "+33 675839201",
      profilePicture: "https://randomuser.me/api/portraits/women/6.jpg",
      verifiedProfile: true,
    ),
  ];

  @override
  List<User> getUsers() => fakeUsers;

}