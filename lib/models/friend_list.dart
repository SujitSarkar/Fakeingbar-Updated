import 'package:flutter/cupertino.dart';

class FriendList {
  final int id;
  final String name;
  final DateTime lastMessageTime;
  final String messageStatus;
  final bool isActive;
  final bool isBlock;
  final String lastMessage;
  final bool hasStory;
  final Color chatColor;
  final String inactiveTime;
  final String welcomeMessage;
  final String address;
  final bool hasGroup;

  FriendList({
    required this.id,
    required this.name,
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
