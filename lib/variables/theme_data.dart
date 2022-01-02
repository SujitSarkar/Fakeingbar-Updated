import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SThemeData {
  static Color greyColor = Colors.grey;
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color textColor = const Color(0xff787878);

  static const Color lightThemeColor = Color(0xff009AFE);
  static const Color darkThemeColor = Color(0xff000100);
  static const Color blueDotColor = Color(0xff429AFE);

  static final ThemeData lightThemeData = ThemeData(
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0xff009AFE, lightThemeMapColor),
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: blackColor),
      titleTextStyle: TextStyle(
        color: blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      actionsIconTheme: IconThemeData(color: blackColor),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xfff5f5f5),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: blackColor),
      headline2: TextStyle(color: blackColor),
      headline3: TextStyle(color: blackColor),
      headline4: TextStyle(color: blackColor),
      headline5: TextStyle(color: blackColor),
      headline6: TextStyle(color: blackColor),
      subtitle1: TextStyle(color: blackColor),
      subtitle2: TextStyle(color: blackColor),
      bodyText1: TextStyle(color: blackColor),
      bodyText2: TextStyle(color: blackColor),
      caption: TextStyle(color: blackColor),
      button: TextStyle(color: blackColor),
      overline: TextStyle(color: blackColor),
    ),
    iconTheme: IconThemeData(color: blackColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      selectedItemColor: lightThemeColor,
    ),
  );

  static final ThemeData darkThemeData = ThemeData(
    backgroundColor: darkThemeColor,
    brightness: Brightness.dark,
    primarySwatch: const MaterialColor(0xff000100, darkThemeMapColor),
    canvasColor: Colors.transparent,
    indicatorColor: Colors.grey,
    scaffoldBackgroundColor: Colors.black,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: whiteColor),
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      actionsIconTheme: IconThemeData(color: whiteColor),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xff303030),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: whiteColor),
      headline2: TextStyle(color: whiteColor),
      headline3: TextStyle(color: whiteColor),
      headline4: TextStyle(color: whiteColor),
      headline5: TextStyle(color: whiteColor),
      headline6: TextStyle(color: whiteColor),
      subtitle1: TextStyle(color: whiteColor),
      subtitle2: TextStyle(color: whiteColor),
      bodyText1: TextStyle(color: whiteColor),
      bodyText2: TextStyle(color: whiteColor),
      caption: TextStyle(color: whiteColor),
      button: TextStyle(color: whiteColor),
      overline: TextStyle(color: whiteColor),
    ),
    iconTheme: IconThemeData(color: whiteColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      selectedItemColor: lightThemeColor,
    ),
  );

  static const Map<int, Color> lightThemeMapColor = {
    //RGB Color Code (0, 194, 162) Hex: 0xff0095B2
    50: Color.fromRGBO(0, 154, 254, .1),
    100: Color.fromRGBO(0, 154, 254, .2),
    200: Color.fromRGBO(0, 154, 254, .3),
    300: Color.fromRGBO(0, 154, 254, .4),
    400: Color.fromRGBO(0, 154, 254, .5),
    500: Color.fromRGBO(0, 154, 254, .6),
    600: Color.fromRGBO(0, 154, 254, .7),
    700: Color.fromRGBO(0, 154, 254, .8),
    800: Color.fromRGBO(0, 154, 254, .9),
    900: Color.fromRGBO(0, 154, 254, 1),
  };

  static const Map<int, Color> darkThemeMapColor = {
    //RGB Color Code (0, 194, 162) Hex: 0xff0095B2
    50: Color.fromRGBO(0, 1, 0, .1),
    100: Color.fromRGBO(0, 1, 0, .2),
    200: Color.fromRGBO(0, 1, 0, .3),
    300: Color.fromRGBO(0, 1, 0, .4),
    400: Color.fromRGBO(0, 1, 0, .5),
    500: Color.fromRGBO(0, 1, 0, .6),
    600: Color.fromRGBO(0, 1, 0, .7),
    700: Color.fromRGBO(0, 1, 0, .8),
    800: Color.fromRGBO(0, 1, 0, .9),
    900: Color.fromRGBO(0, 1, 0, 1),
  };

  static const List<Color> chatColors = [
    Colors.blue,
    Colors.orangeAccent,
    Colors.redAccent,
    Color(0xffD696BB),
    Color(0xff669ACC),
    Color(0xff12CF13),
    Colors.deepOrangeAccent,
    Color(0xffE58586),
    Color(0xff7646FE),
    Color(0xff20CDF5),
    Color(0xff67B869),
    Color(0xffD4A88D),
    Colors.pinkAccent,
    Colors.purpleAccent,
    Color(0xffA696C7),
  ];
}
