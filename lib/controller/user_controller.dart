import 'package:fakeingbar/models/friend_list.dart';
import 'package:fakeingbar/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final List<FriendList> demoUsers = [
    FriendList(
      id: 1,
      name: "Evan",
      imageUrl: "images/w2.jpg",
      lastMessageTime: DateTime.now(),
      messageStatus: "not send",
      isOnline: true,
      isBlock: false,
      lastMessage: "lastMessage",
      hasDay: true,
      chatColor: 1,
      inactiveTime: "Active",
      welcomeMessage: "You'r friends on Facebook",
      address: "Dubai",
      hasGroup: false,
    ),
    FriendList(
      id: 2,
      name: "Ankur",
      imageUrl: "images/m2.jpg",
      lastMessageTime: DateTime.now(),
      messageStatus: "not received",
      isOnline: false,
      isBlock: false,
      lastMessage: "Lets meet tomorrow",
      hasDay: false,
      chatColor: 1,
      inactiveTime: "Active",
      welcomeMessage: "welcomeMessage",
      address: "address",
      hasGroup: false,
    ),
    FriendList(
      id: 3,
      name: "Stella",
      imageUrl: "images/w2.jpg",
      lastMessageTime: DateTime.now(),
      messageStatus: "received",
      isOnline: true,
      isBlock: false,
      lastMessage: "Hey What's up?",
      hasDay: true,
      chatColor: 1,
      inactiveTime: "Active",
      welcomeMessage: "welcomeMessage",
      address: "address",
      hasGroup: false,
    ),
    FriendList(
      id: 4,
      name: "Gabriela",
      imageUrl: "images/w1.jpg",
      lastMessageTime: DateTime.now(),
      messageStatus: "seen",
      isOnline: false,
      isBlock: false,
      lastMessage: "Lets meet tomorrow",
      hasDay: false,
      chatColor: 1,
      inactiveTime: "Active",
      welcomeMessage: "welcomeMessage",
      address: "address",
      hasGroup: false,
    ),
  ].obs;

  List<FriendList> get users {
    return demoUsers;
  }

  set setUser(FriendList user) {
    demoUsers.add(user);
  }

  bool changeUserDay(FriendList user) {
    FriendList newuser =
        demoUsers.firstWhere((element) => element.id == user.id);
    return newuser.hasDay == true
        ? newuser.hasDay = false
        : newuser.hasDay = true;
  }
}
