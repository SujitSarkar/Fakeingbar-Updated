class ChatListModel {
  int? id;
  String? memberID;
  int? friendListID;
  String? messageType;
  String? sendMessage;
  String? receiveMessage;
  DateTime? senderTime;
  DateTime? receiveTime;
  String? isReceived;

  ChatListModel({
    this.friendListID,
    this.messageType,
    this.sendMessage,
    this.memberID,
    this.receiveMessage,
    this.senderTime,
    this.receiveTime,
    this.isReceived,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['friendListID'] = friendListID;
    map['messageType'] = messageType;
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
    messageType = map['messageType'];
    sendMessage = map['sendMessage'];
    memberID = map['memberID'];
    receiveMessage = map['receiveMessage'];
    senderTime =
        DateTime.fromMillisecondsSinceEpoch((int.parse(map['senderTime'])));
    receiveTime =
        DateTime.fromMillisecondsSinceEpoch((int.parse(map['receiveTime'])));
    isReceived = map['isReceived'];
  }

  ChatListModel copyWith({
    String? memberID,
    String? messageType,
    int? friendListID,
    String? sendMessage,
    String? receiveMessage,
    DateTime? senderTime,
    DateTime? receiveTime,
    String? isReceived,
  }) {
    return ChatListModel(
      friendListID: friendListID ?? this.friendListID,
      messageType: messageType ?? this.messageType,
      sendMessage: sendMessage ?? this.sendMessage,
      memberID: memberID ?? this.memberID,
      receiveMessage: receiveMessage ?? this.receiveMessage,
      senderTime: senderTime ?? this.senderTime,
      receiveTime: receiveTime ?? this.receiveTime,
      isReceived: isReceived ?? this.isReceived,
    );
  }
}
