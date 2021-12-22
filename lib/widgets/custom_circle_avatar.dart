import 'dart:io';

import 'package:fakeingbar/controller/chatlist_controller.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/user.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class CustomeCircleAvatar extends StatelessWidget {
  CustomeCircleAvatar({
    Key? key,
    required this.imageUrl,
    this.onlineDotSize,
    this.borderWidth = 3,
    this.isBlock = false,
    required this.hasDay,
    required this.isOnline,
    this.picRadius,
  }) : super(key: key);
  final String imageUrl;
  final double? onlineDotSize;
  final double borderWidth;
  final bool isBlock;
  final bool hasDay, isOnline;
  final double? picRadius;

  final ThemeController _themeController = Get.find();
  final ChatListController _chatListController = Get.find();

  @override
  Widget build(BuildContext context) {
    File? imageFile = _chatListController.imageFile;
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        hasDay
            ? Container(
                width: customWidth(.16),
                height: customWidth(.16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: SThemeData.lightThemeColor,
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
                    backgroundImage: imageFile == null
                        ? AssetImage(imageUrl)
                        : FileImage(_chatListController.imageFile!)
                            as ImageProvider,
                    radius: picRadius ?? customWidth(.05),
                  ),
                ),
              )
            : CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: picRadius ?? customWidth(.08),
              ),
        isOnline == true && isBlock == false
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
