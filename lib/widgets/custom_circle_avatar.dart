import 'dart:io';

import 'package:fakeingbar/controller/chatlist_controller.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class CustomeCircleAvatar extends StatelessWidget {
  CustomeCircleAvatar({
    Key? key,
    required this.user,
    this.onlineDotSize,
    this.borderWidth = 3,
    this.picRadius,
    this.showDay = true,
  }) : super(key: key);

  final FriendListModel user;
  final double? onlineDotSize;
  final double borderWidth;
  final double? picRadius;
  final bool? showDay;

  final ThemeController _themeController = Get.find();
  final ChatListController _chatListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        user.hasDay! && showDay!
            ? Container(
                width: customWidth(.16),
                height: customWidth(.16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: SThemeData.blueDotColor,
                    width: 3,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _themeController.scaffoldBackgroundColor,
                      width: 1.8,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(user.imageUrl!)),
                    radius: picRadius ?? customWidth(.05),
                  ),
                ),
              )
            : CircleAvatar(
                backgroundImage: FileImage(File(user.imageUrl!)),
                radius: picRadius ?? customWidth(.07),
              ),
        user.isOnline == true && user.isBlock == false
            ? Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: onlineDotSize ?? customWidth(.05),
                  height: onlineDotSize ?? customWidth(.05),
                  decoration: BoxDecoration(
                      color: const Color(0xff4DC82C),
                      border: Border.all(
                        width: borderWidth,
                        color: _themeController.scaffoldBackgroundColor,
                      ),
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              )
            : Container()
      ],
    );
  }
}
