import 'package:fakeingbar/models/chat_list.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  final List<ChatList> _chatlist = [];

  List<ChatList> get chatlist {
    return _chatlist;
  }

  List<ChatList> demoChatList = [
    ChatList(
      id: 1,
      friendListID: 1,
      sendMessage: "Lets meet tomorrow",
      memberID: 1,
      receiveMessage: "Hey What's up?",
      senderTime: DateTime.now(),
      receiveTime: DateTime.now(),
      isReceived: "not received",
    ),
  ];
}
