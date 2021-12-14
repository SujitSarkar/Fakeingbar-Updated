import 'package:get/get.dart';

class Config {
  double screenWidth = Get.width;
}

double customWidth(double v) {
  return (Config().screenWidth * v);
}
