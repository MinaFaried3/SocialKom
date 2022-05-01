import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialkom/shared/styles/color.dart';

ThemeData light = ThemeData(
    // canvasColor: Colors.red,
    primarySwatch: createMaterialColor(social1),
    scaffoldBackgroundColor: Colors.white,
    shadowColor: Colors.grey.withOpacity(0.5),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0.4)),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: social2,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            fontFamily: 'jannah'),
        elevation: 0,
        iconTheme: IconThemeData(color: social2),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: social2,
        unselectedItemColor: social1,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 30),
    fontFamily: 'jannah',
    textTheme: TextTheme(
        subtitle1: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        subtitle2: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
        caption: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        headline5: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24),
        headline4: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 32),
        headline6: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18)));
ThemeData dark = ThemeData(
    primarySwatch: createMaterialColor(social6),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.white.withOpacity(0.25)),
    shadowColor: Color(0xD7674790),
    scaffoldBackgroundColor: dark1,
    appBarTheme: AppBarTheme(
        backgroundColor: dark1,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            fontFamily: 'jannah'),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: dark1, statusBarIconBrightness: Brightness.light)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: social2,
        unselectedItemColor: social6,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 30),
    cardTheme: CardTheme(
      color: dark2,
      shadowColor: Color(0xFF481B87),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    fontFamily: 'jannah',
    textTheme: TextTheme(
        subtitle1: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        subtitle2: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
        caption: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        headline6: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        headline5: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
        headline4: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 32)));
