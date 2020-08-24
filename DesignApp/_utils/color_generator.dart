import 'dart:math';

import 'package:flutter/material.dart';

class ColorGenerator {
  final _random = Random();

  Color randomizeRGBOColor({int red, int green, int blue}) {
    int r;
    int g;
    int b;
    if (red != null) {
      r = red;
    } else {
      r = _random.nextInt(256);
    }
    if (green != null) {
      g = green;
    } else {
      g = _random.nextInt(256);
    }
    if (blue != null) {
      b = blue;
    } else {
      b = _random.nextInt(256);
    }

    double o = 1;
    var _color = Color.fromRGBO(r, g, b, o);
    return _color;
  }

  // Color changeHSLColor(){
  //   //https://api.flutter.dev/flutter/painting/HSLColor-class.html
  //   //var _argbColr = changeBackgroundColor();
  //   double alphaColor = _random.nextDouble();  //double from 0.0 to 1.0
  //   double hueColor = _random.nextInt(360).toDouble(); // is a double from 0.0 to 360.0 //
  //   double lightnessColor = _random.nextDouble(); //double from 0.0 to 1.0
  //   double staturationColor = _random.nextDouble(); //double from 0.0 to 1.0

  //   var _color = HSLColor.fromAHSL(alphaColor, hueColor, staturationColor, lightnessColor);
  //   Color _lastColor = _color.toColor();
  //   return _lastColor;
  // }

  static String convertRBGtoHexString(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  Color hexToColor(String hexColor) {
    return new Color(
        int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
