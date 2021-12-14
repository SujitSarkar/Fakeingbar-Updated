import 'package:flutter/material.dart';

class SThemeData{
  static final ThemeData lightThemeData= ThemeData(
      backgroundColor:  Colors.white,
      primarySwatch: const MaterialColor(0xff009AFE, lightThemeMapColor),
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: lightThemeColor
      )
  );

  static final ThemeData darkThemeData= ThemeData(
      backgroundColor: darkThemeColor,
      primarySwatch: const MaterialColor(0xff000100, darkThemeMapColor),
      canvasColor: Colors.transparent,
      indicatorColor: Colors.grey,
      scaffoldBackgroundColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white
      )
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
    50: Color.fromRGBO(0,1,0, .1),
    100: Color.fromRGBO(0,1,0, .2),
    200: Color.fromRGBO(0,1,0, .3),
    300: Color.fromRGBO(0,1,0, .4),
    400: Color.fromRGBO(0,1,0, .5),
    500: Color.fromRGBO(0,1,0, .6),
    600: Color.fromRGBO(0,1,0, .7),
    700: Color.fromRGBO(0,1,0, .8),
    800: Color.fromRGBO(0,1,0, .9),
    900: Color.fromRGBO(0,1,0, 1),
  };

  static const Color lightThemeColor = Color(0xff009AFE);
  static const Color darkThemeColor = Color(0xff000100);
}