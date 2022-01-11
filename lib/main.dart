import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/data/sharedpreference/sharepreferenceController.dart';
import 'package:fakeingbar/pages/home_page.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  final bool isLight = pref.getBool('isLite') ?? true;
  runApp(MyApp(isLite: isLight));
}

class MyApp extends StatelessWidget {
  final bool isLite;
  const MyApp({Key? key, required this.isLite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KSharedPreference _pref = Get.put(KSharedPreference());
    ThemeController _themeController = Get.put(ThemeController());

    DatabaseController _databaeController = Get.put(DatabaseController());
    return GetBuilder<ThemeController>(builder: (controller) {
      return GetMaterialApp(
        title: 'FakingBar',
        debugShowCheckedModeBanner: false,
        theme: controller.pref != null
            ? controller.isLite.value
                ? SThemeData.lightThemeData
                : SThemeData.darkThemeData
            : isLite
                ? SThemeData.lightThemeData
                : SThemeData.darkThemeData,
        home: HomePage(),
      );
    });
  }
}
