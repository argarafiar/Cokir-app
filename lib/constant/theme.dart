import 'package:flutter/material.dart';

const appRed = Color(0xFFe53170);
const appWhite = Color(0xFFffffff);
const appDark = Color(0xFF00214d);

ThemeData light = ThemeData(
  brightness: Brightness.light,
  backgroundColor: appRed,
  iconTheme: IconThemeData(color: appWhite),
  appBarTheme: AppBarTheme(
    backgroundColor: appRed,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appRed,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: appWhite,
    ),
    headline6: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: appRed,
    ),
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  backgroundColor: appDark,
  iconTheme: IconThemeData(color: appWhite),
  appBarTheme: AppBarTheme(
    backgroundColor: appDark,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appDark,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: appWhite,
    ),
    headline6: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: appWhite,
    ),
  ),
);
