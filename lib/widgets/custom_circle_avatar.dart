import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class CustomeCircleAvatar extends StatelessWidget {
  CustomeCircleAvatar({
    Key? key,
    required this.name,
    required this.imgUrl,
    required this.isOnline,
    this.dotSize,
    this.borderWidth,
  }) : super(key: key);
  final String name;
  final String imgUrl;
  final bool isOnline;
  final double? dotSize;
  final double? borderWidth;

  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imgUrl),
          radius: customWidth(.08),
        ),
        isOnline == true
            ? Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: dotSize ?? customWidth(.042),
                  height: dotSize ?? customWidth(.042),
                  decoration: BoxDecoration(
                      color: const Color(0xff4DC82C),
                      border: Border.all(
                        width: borderWidth ?? 2.5,
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
