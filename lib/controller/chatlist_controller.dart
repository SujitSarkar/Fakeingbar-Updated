import 'dart:io';

import 'package:fakeingbar/controller/friendList_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/chat_list.dart';
import 'package:fakeingbar/models/friend_list.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatListController extends FriendListController {
  final List<ChatListModel> _chatlist = [];

  // List<ChatListModel> get chatlist {
  //   return demoChatList;
  // }

  // List<ChatListModel> demoChatList = [
  //   ChatListModel(
  //     friendListID: 1,
  //     sendMessage: "Hi",
  //     memberID: 1,
  //     receiveMessage:
  //         "Hey What's up?Hey What's up?Hey What's up?Hey What's up?Hey What's up?Hey What's up?",
  //     senderTime: DateTime.now(),
  //     receiveTime: DateTime.now(),
  //     isReceived: "received",
  //   ),
  //   ChatListModel(
  //     friendListID: 1,
  //     sendMessage: "Lets meet tomorrow",
  //     memberID: 1,
  //     receiveMessage: "Alright!",
  //     senderTime: DateTime.now(),
  //     receiveTime: DateTime.now(),
  //     isReceived: "not received",
  //   ),
  // ];

  var isUserBlocked = false.obs;
  File? imageFile;

  void addNewChat(
      {required String name,
      required String imageUrl,
      required String msg,
      required String lastOnlineTime,
      required bool isOnline,
      required bool hasDay,
      required bool isBlock}) {
    demoUsers.add(FriendListModel(
        name: name,
        imageUrl: imageUrl,
        lastMessageTime: DateTime.now(),
        lastMessage: msg,
        inactiveTime: "inactiveTime"));
    // demoChatList.add(
    //   ChatListModel(
    //     friendListID: 3,
    //     sendMessage: msg,
    //     memberID: 2,
    //     receiveMessage: "",
    //     senderTime: DateTime.now(),
    //     receiveTime: DateTime.now(),
    //     isReceived: "not received",
    //   ),
    // );
    // DatabaseController.insertUser(FriendListModel(
    //     name: name,
    //     imageUrl: imageUrl,
    //     lastMessageTime: DateTime.now(),
    //     lastMessage: msg,
    //     inactiveTime: "inactiveTime"));
  }
}
