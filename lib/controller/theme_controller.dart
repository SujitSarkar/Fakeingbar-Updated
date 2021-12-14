import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isLite = true.obs;
  SharedPreferences? pref;
  Color? backgroundColor = Colors.grey[100];
  Color? textColor = Colors.white;

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData() async {
    pref = await SharedPreferences.getInstance();
    isLite(pref!.getBool('isLite') ?? true);
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
      backgroundColor = Colors.grey[100];
      textColor = Colors.white;
    } else {
      backgroundColor = Colors.grey.shade800;
      textColor = Colors.black;
    }
  }
}
