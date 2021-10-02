import 'package:flutter/material.dart';

class ColorConstants {
  ColorConstants._();

  static const Color primaryBlack = Color(0xFF191B24);
  static const Color bgLightGrey = Color(0xFFF8F8F8);

  static const Color textPrimaryBlack = Color(0xFF191B24);
  static const Color textGrey = Colors.grey;

  static const Color greyIcon = Colors.grey;

  static const Map<int, Color> colorMap = {
    50: Color.fromRGBO(25, 27, 36, .1),
    100: Color.fromRGBO(25, 27, 36, .2),
    200: Color.fromRGBO(25, 27, 36, .3),
    300: Color.fromRGBO(25, 27, 36, .4),
    400: Color.fromRGBO(25, 27, 36, .5),
    500: Color.fromRGBO(25, 27, 36, .6),
    600: Color.fromRGBO(25, 27, 36, .7),
    700: Color.fromRGBO(25, 27, 36, .8),
    800: Color.fromRGBO(25, 27, 36, .9),
    900: Color.fromRGBO(25, 27, 36, 1),
  };
}
