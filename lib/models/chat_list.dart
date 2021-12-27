class ChatListModel {
  int? id;
  String? memberID;
  int? friendListID;
  String? sendMessage;
  String? receiveMessage;
  DateTime? senderTime;
  DateTime? receiveTime;
  String? isReceived;

  ChatListModel({
    required this.friendListID,
    required this.sendMessage,
    required this.memberID,
    required this.receiveMessage,
    required this.senderTime,
    required this.receiveTime,
    required this.isReceived,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['friendListID'] = friendListID;
    map['sendMessage'] = sendMessage;
    map['memberID'] = memberID;
    map['receiveMessage'] = receiveMessage;
    map['senderTime'] = senderTime!.millisecondsSinceEpoch.toString();
    map['receiveTime'] = receiveTime!.millisecondsSinceEpoch.toString();
    map['isReceived'] = isReceived;
    return map;
  }

  //Extract a note object from a map object
  ChatListModel.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    friendListID = int.parse(map['friendListID']);
    sendMessage = map['sendMessage'];
    memberID = map['memberID'];
    receiveMessage = map['receiveMessage'];
    senderTime =
        DateTime.fromMillisecondsSinceEpoch((int.parse(map['senderTime'])));
    receiveTime =
        DateTime.fromMillisecondsSinceEpoch((int.parse(map['receiveTime'])));
    isReceived = map['isReceived'];
  }
}
