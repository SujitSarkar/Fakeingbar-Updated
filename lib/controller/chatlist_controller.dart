import 'dart:io';

import 'package:fakeingbar/models/chat_list.dart';
import 'package:get/get.dart';

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
}
