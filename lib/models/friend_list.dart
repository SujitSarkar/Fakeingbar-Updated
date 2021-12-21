import 'package:flutter/cupertino.dart';

class FriendList {
  final int id;
  final String name;
  final String imageUrl;
  final DateTime lastMessageTime;
  final String messageStatus;
  final bool isActive;
  final bool isBlock;
  final String lastMessage;
  final bool hasStory;
  final int chatColor;
  final String inactiveTime;
  final String welcomeMessage;
  final String address;
  final bool hasGroup;

  FriendList({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lastMessageTime,
    required this.messageStatus,
    required this.isActive,
    required this.isBlock,
    required this.lastMessage,
    required this.hasStory,
    required this.chatColor,
    required this.inactiveTime,
    required this.welcomeMessage,
    required this.address,
    required this.hasGroup,
  });
}

List<FriendList> friendList = [
  FriendList(
    id: 1,
    name: "Evan",
    imageUrl: "images/w2.jpg",
    lastMessageTime: DateTime.now(),
    messageStatus: "not received",
    isActive: true,
    isBlock: false,
    lastMessage: "lastMessage",
    hasStory: true,
    chatColor: 1,
    inactiveTime: "Active",
    welcomeMessage: "welcomeMessage",
    address: "address",
    hasGroup: false,
  )
];
