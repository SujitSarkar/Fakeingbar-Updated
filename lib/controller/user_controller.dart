import 'package:fakeingbar/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final List<User> _demoUsers = [
    User(
      id: 1,
      name: "Evan Hossain",
      imageUrl: "images/w1.jpg",
      msg: "Lets meet tomorrow",
      lastOnlineTime: " . 3:09 PM",
      isOnline: true,
      hasDay: true,
      isBlock: true,
    ),
    User(
      id: 2,
      name: "Ankur",
      imageUrl: "images/m2.jpg",
      msg: "Lets meet tomorrow",
      lastOnlineTime: " . 3:09 PM",
      isOnline: false,
      hasDay: true,
      isBlock: false,
    ),
    User(
      id: 3,
      name: "Stella",
      imageUrl: "images/w2.jpg",
      msg: "Hey What's up?",
      lastOnlineTime: " . Wed",
      isOnline: true,
      hasDay: false,
      isBlock: false,
    ),
    User(
      id: 4,
      name: "Gabriela",
      imageUrl: "images/w1.jpg",
      msg: "Lets meet tomorrow",
      lastOnlineTime: " . 3:09 PM",
      isOnline: true,
      hasDay: true,
      isBlock: false,
    ),
    User(
      id: 5,
      name: "Rudolf",
      imageUrl: "images/w1.jpg",
      msg: "Lets meet tomorrow",
      lastOnlineTime: " . 3:09 PM",
      isOnline: true,
      hasDay: true,
      isBlock: false,
    ),
  ].obs;

  List<User> get users {
    return _demoUsers;
  }

  bool changeUserDay(User user) {
    User newuser = _demoUsers.firstWhere((element) => element.id == user.id);
    return newuser.hasDay == true
        ? newuser.hasDay = false
        : newuser.hasDay = true;
  }
}
