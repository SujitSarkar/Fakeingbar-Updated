import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController{

  RxBool isLite=true.obs;
  SharedPreferences? pref;

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData()async{
    pref= await SharedPreferences.getInstance();
    isLite(pref!.getBool('isLite')??true);
    update();
  }

  Future<void> toggleThemeData()async{
    isLite.toggle();
    pref!.setBool('isLite', isLite.value);
    changeColors();
    update();
  }

  changeColors(){
    if(isLite.value){


    }else{


    }
  }


}