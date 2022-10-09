import 'package:flutter/material.dart';

class AppConstants {
  // color
  static Color color828796 = const Color(0xFF828796);
  static Color color3E4047 = const Color(0xFF3E4047);
  static Color color2C2E35 = const Color(0xFF2C2E35);
  static Color color18191E = const Color(0xFF18191E);
  static Color colorFAE04B = const Color(0xFFFAE04B);

  // space size
  static double paddingDefault = 16;

  //String
  static String posterLeading = 'http://image.tmdb.org/t/p/w185/';
  static String backdropLeading = 'http://image.tmdb.org/t/p/w780/';

  //TextStyle
  static const TextStyle appBarStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyStyle = TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal);
}
