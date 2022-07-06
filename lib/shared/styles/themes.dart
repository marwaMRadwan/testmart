import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:martizoom/shared/styles/fonts.dart';

import 'colors.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('333739'),
    titleSpacing: 10.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: const Color(0xFFce0900),
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
  primaryColor: defaultColor,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: "Jannah",
);

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: defaultColor,
    titleSpacing: 10.0,
    //  backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
    ),
    headline3: TextStyle(
      color: defaultColor,
      fontSize: 16.0,
    ),
    headline1: TextStyle(
      color: Colors.black,
      fontSize: 30.0,
    ),
    headline2: TextStyle(
      color: Colors.blueGrey,
      fontSize: 28.0,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFFce0900),
    elevation: 20.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
  primaryColor: defaultColor,
  fontFamily: poppinsFont,
);
