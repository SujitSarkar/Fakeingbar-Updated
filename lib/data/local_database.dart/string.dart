class KStrings {
//Friend List Table.........
  static const String tableFriendList = "friendListTable";
  static const String colFriendListId = "id";
  static const String colFriendListName = "name";
  static const String colFriendListImageUrl = "imageUrl";
  static const String colLastMessageTime = "lastMessageTime";
  static const String colLastMessage = "lastMessage";
  static const String colInactiveTime = "inactiveTime";
  static const String colMessageStatus = "messageStatus";
  static const String colIsOnline = "isOnline";
  static const String colIsBlock = "isBlock";
  static const String colHasDay = "hasDay";
  static const String colChatColor = "chatColor";
  static const String colWelcomeMessage = "welcomeMessage";
  static const String colAddress = "address";
  static const String colHasGroup = "hasGroup";

//Chat List Table..........
  static const String tableChatList = "chatListTabel";
  static const String colChatListId = "id";
  static const String colMemberID = "memberID";
  static const String colFkChatListFriendId = "friendListID";
  static const String colSendMessage = "sendMessage";
  static const String colReceiveMessage = "receiveMessage";
  static const String colSenderTime = "senderTime";
  static const String colReceiveTime = "receiveTime";
  static const String colIsReceived = "isReceived";

//Group User List Table......
  static const String tableGroupList = "groupListTabel";
  static const String colGroupListId = "id";
  static const String colFkGroupFriendID = "friendListID";
  static const String colGroupMemberName = "name";
  static const String colGroupMemberImageUrl = "imageUrl";

//Trainer Table ............
  static const String tableTrainer = "trainerTabel";
  static const String colTrainerId = "id";
  static const String colQuestion = "question";
  static const String colAnswer = "answer";
}
