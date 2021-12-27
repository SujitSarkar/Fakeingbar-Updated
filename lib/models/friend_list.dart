import 'package:flutter/cupertino.dart';

class FriendListModel {
  int? id;
  String? name;
  String? imageUrl;
  DateTime? lastMessageTime;
  String? messageStatus;
  bool? isOnline;
  bool? isBlock;
  String? lastMessage;
  bool? hasDay;
  int? chatColor;
  String? inactiveTime;
  String? welcomeMessage;
  String? address;
  bool? hasGroup;

  FriendListModel({
    required this.name,
    required this.imageUrl,
    required this.lastMessageTime,
    required this.lastMessage,
    required this.inactiveTime,
    this.messageStatus = "not recived",
    this.isOnline = true,
    this.isBlock = false,
    this.hasDay = false,
    this.chatColor = 0,
    this.welcomeMessage = "You're friends on Facebook",
    this.address = "Lives in UK",
    this.hasGroup = false,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['imageUrl'] = imageUrl;
    map['lastMessageTime'] = lastMessageTime!.millisecondsSinceEpoch.toString();
    map['lastMessage'] = lastMessage;
    map['inactiveTime'] = inactiveTime;
    map['messageStatus'] = messageStatus;
    map['isOnline'] = isOnline! ? 1 : 0;
    map['isBlock'] = isBlock! ? 1 : 0;
    map['hasDay'] = hasDay! ? 1 : 0;
    map['chatColor'] = chatColor;
    map['welcomeMessage'] = welcomeMessage;
    map['address'] = address;
    map['hasGroup'] = hasGroup! ? 1 : 0;
    return map;
  }

  //Extract a note object from a map object
  FriendListModel.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    imageUrl = map['imageUrl'];
    lastMessageTime = DateTime.fromMillisecondsSinceEpoch(
        (int.parse((map['lastMessageTime']))));
    lastMessage = map['lastMessage'];
    inactiveTime = map['inactiveTime'];
    messageStatus = map['messageStatus'];
    isOnline = map['isOnline'] == 1;
    isBlock = map['isBlock'] == 1;
    hasDay = map['hasDay'] == 1;
    chatColor = int.parse(map['chatColor']);
    welcomeMessage = map['welcomeMessage'];
    address = map['address'];
    hasGroup = map['hasGroup'] == 1;
  }
}

// List<FriendListModel> friendList = [
//   FriendListModel(
//     name: "Evan",
//     imageUrl: "images/w2.jpg",
//     lastMessageTime: DateTime.now(),
//     messageStatus: "not received",
//     isOnline: true,
//     isBlock: false,
//     lastMessage: "lastMessage",
//     hasDay: true,
//     chatColor: 1,
//     inactiveTime: "Active",
//     welcomeMessage: "welcomeMessage",
//     address: "address",
//     hasGroup: false,
//   ),
//   FriendListModel(
//     name: "Ankur",
//     imageUrl: "images/m2.jpg",
//     lastMessageTime: DateTime.now(),
//     messageStatus: "not received",
//     isOnline: true,
//     isBlock: false,
//     lastMessage: "Lets meet tomorrow",
//     hasDay: true,
//     chatColor: 1,
//     inactiveTime: "Active",
//     welcomeMessage: "welcomeMessage",
//     address: "address",
//     hasGroup: false,
//   ),
//   FriendListModel(
//     name: "Stella",
//     imageUrl: "images/w2.jpg",
//     lastMessageTime: DateTime.now(),
//     messageStatus: "not received",
//     isOnline: true,
//     isBlock: false,
//     lastMessage: "Hey What's up?",
//     hasDay: true,
//     chatColor: 1,
//     inactiveTime: "Active",
//     welcomeMessage: "welcomeMessage",
//     address: "address",
//     hasGroup: false,
//   )
// ];
