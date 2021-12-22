import 'package:flutter/cupertino.dart';

class FriendList {
  final int id;
  final String name;
  final String imageUrl;
  final DateTime lastMessageTime;
  final String messageStatus;
  final bool isOnline;
  final bool isBlock;
  final String lastMessage;
  bool hasDay;
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
}

List<FriendList> friendList = [
  FriendList(
    id: 1,
    name: "Evan",
    imageUrl: "images/w2.jpg",
    lastMessageTime: DateTime.now(),
    messageStatus: "not received",
    isOnline: true,
    isBlock: false,
    lastMessage: "lastMessage",
    hasDay: true,
    chatColor: 1,
    inactiveTime: "Active",
    welcomeMessage: "welcomeMessage",
    address: "address",
    hasGroup: false,
  ),
  FriendList(
    id: 2,
    name: "Ankur",
    imageUrl: "images/m2.jpg",
    lastMessageTime: DateTime.now(),
    messageStatus: "not received",
    isOnline: true,
    isBlock: false,
    lastMessage: "Lets meet tomorrow",
    hasDay: true,
    chatColor: 1,
    inactiveTime: "Active",
    welcomeMessage: "welcomeMessage",
    address: "address",
    hasGroup: false,
  ),
  FriendList(
    id: 3,
    name: "Stella",
    imageUrl: "images/w2.jpg",
    lastMessageTime: DateTime.now(),
    messageStatus: "not received",
    isOnline: true,
    isBlock: false,
    lastMessage: "Hey What's up?",
    hasDay: true,
    chatColor: 1,
    inactiveTime: "Active",
    welcomeMessage: "welcomeMessage",
    address: "address",
    hasGroup: false,
  )
];
