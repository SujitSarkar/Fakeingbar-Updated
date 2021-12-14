import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref= await SharedPreferences.getInstance();
  final bool isLight = pref.getBool('isLite') ?? true;
  runApp(MyApp(isLite: isLight));
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        //statusBarBrightness:Brightness.light,
          statusBarColor:Colors.white,
          statusBarIconBrightness:Brightness.dark
      ));
}
class MyApp extends StatelessWidget {
  final bool isLite;
  const MyApp({Key? key,required this.isLite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return GetBuilder<ThemeController>(
      builder: (controller) {
        return GetMaterialApp(
          title: 'FakingBar',
          debugShowCheckedModeBanner: false,
          theme: controller.pref!=null
              ? controller.isLite.value
              ? SThemeData.lightThemeData
              : SThemeData.darkThemeData
              : isLite
              ? SThemeData.lightThemeData
              : SThemeData.darkThemeData,
          home: Scaffold(
           appBar: AppBar(
             title: const Text('hello'),
           ),
            body: Center(
              child: ElevatedButton(
                onPressed: ()=> controller.toggleThemeData(),
                child: const Text('Change Theme'),
              ),
            ),
          ),
        );
      }
    );
  }
}

