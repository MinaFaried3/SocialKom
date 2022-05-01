import 'dart:ui';

import 'package:flutter/material.dart';

const Color social1 = Color(0xffc4dffa);
const Color social2 = Color(0xff699dcf);
const Color social3 = Color(0xff8ac2f1);
const Color social4 = Color(0xff2a79b8);
const Color social5 = Color(0xffc4dffa);
const Color social6 = Color(0xffdae5f3);
const Color dark1 = Color(0xf301071d);
const Color dark2 = Color(0xff101d31);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
