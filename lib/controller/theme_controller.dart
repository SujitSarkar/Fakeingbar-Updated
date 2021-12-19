import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isLite = true.obs;
  SharedPreferences? pref;
  Color? backgroundColor = const Color(0xfff5f5f5);
  Color? darkenTextColor = const Color(0xff787878);
  Color scaffoldBackgroundColor = Colors.white;
  Color textColor = Colors.black;
  Color chatBGColor = const Color(0xfff5f5f5);
  var profilePicPath = "images/m1.jpg".obs;
  File? imageFile;

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData() async {
    pref = await SharedPreferences.getInstance();
    isLite(pref!.getBool('isLite') ?? true);
    pref!.setString("profilePicPath", profilePicPath.value);
    changeColors();
    update();
  }

  Future<void> toggleThemeData() async {
    isLite.toggle();
    pref!.setBool('isLite', isLite.value);
    changeColors();
    update();
  }

  changeColors() {
    if (isLite.value) {
      backgroundColor = const Color(0xfff5f5f5);
      darkenTextColor = const Color(0xff787878);
      textColor = Colors.black;
      scaffoldBackgroundColor = Colors.white;
      chatBGColor = Color(0xfff5f5f5);
      update();
    } else {
      backgroundColor = const Color(0xff303030);
      darkenTextColor = const Color(0xff898989);
      textColor = Colors.white;
      scaffoldBackgroundColor = Colors.black;
      chatBGColor = Color(0xff303030);
      update();
    }
  }
}
