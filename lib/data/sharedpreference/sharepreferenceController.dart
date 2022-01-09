import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KSharedPreference extends GetxController {
  SharedPreferences? pref;

  String isLite = "isLite";
  String profilePicPath = "profilePicPath";

  Future<void> initializeData() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }

  bool? getBool(String val) {
    if (pref != null) {
      if (pref!.getBool(val) != null) {
        return pref!.getBool(val)!;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String getString(String val) {
    if (pref != null) {
      if (pref!.getString(val) != null) {
        return pref!.getString(val)!;
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  setString(String key, String val) {
    if (pref != null) {
      pref!.setString(key, val);
      update();
    }
  }

  setBool(String key, bool val) {
    if (pref != null) {
      pref!.setBool(key, val);
      update();
    }
  }
}
