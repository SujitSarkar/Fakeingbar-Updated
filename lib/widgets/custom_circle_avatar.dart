import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/user.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class CustomeCircleAvatar extends StatelessWidget {
  CustomeCircleAvatar({
    Key? key,
    required this.user,
    this.dotSize,
    this.borderWidth,
    this.isChat,
  }) : super(key: key);
  final User user;
  final double? dotSize;
  final double? borderWidth;
  final bool? isChat;

  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        user.hasDay
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
                    backgroundImage: AssetImage(user.imageUrl),
                    radius: customWidth(.05),
                  ),
                ),
              )
            : CircleAvatar(
                backgroundImage: AssetImage(user.imageUrl),
                radius: customWidth(.08),
              ),
        user.isOnline == true
            ? Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: dotSize ?? customWidth(.05),
                  height: dotSize ?? customWidth(.05),
                  decoration: BoxDecoration(
                      color: const Color(0xff4DC82C),
                      border: Border.all(
                        width: borderWidth ?? 3,
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
