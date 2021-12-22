class ChatList {
  final int id;
  final int memberID;
  final int friendListID;
  final String sendMessage;
  final String receiveMessage;
  final DateTime senderTime;
  final DateTime receiveTime;
  final String isReceived;

  ChatList({
    required this.id,
    required this.friendListID,
    required this.sendMessage,
    required this.memberID,
    required this.receiveMessage,
    required this.senderTime,
    required this.receiveTime,
    required this.isReceived,
  });
}
