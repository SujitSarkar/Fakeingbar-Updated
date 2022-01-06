import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class KBottomManuButton extends StatelessWidget {
  KBottomManuButton({Key? key, required this.menuItems, required this.onPressed})
      : super(key: key);

  final ThemeController _themeController = Get.find();
  final String menuItems;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        height: customWidth(.15),
        width: customWidth(.2),
        padding: EdgeInsets.all(customWidth(.015)),
        margin: EdgeInsets.symmetric(
            horizontal: customWidth(.01), vertical: customWidth(.02)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _themeController.chatBGColor,
          borderRadius: BorderRadius.circular(customWidth(.05)),
        ),
        child: Text(
          menuItems,
          maxLines: 2,
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
