import 'dart:io';

import 'package:fakeingbar/models/chat_list.dart';
import 'package:fakeingbar/models/user.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatListController extends GetxController {
  final List<ChatList> _chatlist = [];

  List<ChatList> get chatlist {
    return demoChatList;
  }

  List<ChatList> demoChatList = [
    ChatList(
      id: 1,
      friendListID: 1,
      sendMessage: "Hi",
      memberID: 1,
      receiveMessage:
          "Hey What's up?Hey What's up?Hey What's up?Hey What's up?Hey What's up?Hey What's up?",
      senderTime: DateTime.now(),
      receiveTime: DateTime.now(),
      isReceived: "received",
    ),
    ChatList(
      id: 1,
      friendListID: 1,
      sendMessage: "Lets meet tomorrow",
      memberID: 1,
      receiveMessage: "Alright!",
      senderTime: DateTime.now(),
      receiveTime: DateTime.now(),
      isReceived: "not received",
    ),
  ];

  var isUserBlocked = false.obs;
  File? imageFile;

  void addNewChat({
    required String name,
    required String imageUrl,
    required String msg,
    required String lastOnlineTime,
    required bool isOnline,
    required bool hasDay,
    required bool isBlock,
  }) {
    users.add(User(
        id: 6,
        name: name,
        imageUrl: imageUrl,
        msg: msg,
        lastOnlineTime: lastOnlineTime,
        isOnline: isOnline,
        hasDay: hasDay,
        isBlock: isBlock));
    demoChatList.add(
      ChatList(
        id: 6,
        friendListID: 3,
        sendMessage: msg,
        memberID: 2,
        receiveMessage: "",
        senderTime: DateTime.now(),
        receiveTime: DateTime.now(),
        isReceived: "not received",
      ),
    );
  }

  Future<File?> pickImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        return File(xFile.path);
      }
    });
  }
}
