import 'package:fakeingbar/models/friend_list.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FriendListController extends GetxController {
  final List<FriendListModel> demoUsers = [
    FriendListModel(
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
    FriendListModel(
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
    FriendListModel(
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
    FriendListModel(
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

  List<FriendListModel> get users {
    return demoUsers;
  }

  set setUser(FriendListModel user) {
    demoUsers.add(user);
  }

  bool changeUserDay(FriendListModel user) {
    FriendListModel newuser =
        demoUsers.firstWhere((element) => element.id == user.id);
    return newuser.hasDay == true
        ? newuser.hasDay = false
        : newuser.hasDay = true;
  }

  Future<String?> pickImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        return xFile.path;
      }
    });
  }
}
