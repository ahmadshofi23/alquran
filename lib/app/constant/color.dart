import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const appPurple = Color(0XFF431AA1);
const appWhite = Color(0xffFAF8FC);
const appLightPurple = Color(0xff9345F2);
const appLightGrey = Color(0xffB9A2D8);
const appOrange = Color(0xffE6704A);
const appPupleDark = Color(0xff1E0771);

ThemeData themeLight = ThemeData(
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: appPupleDark),
  brightness: Brightness.light,
  primaryColor: appPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: appPurple,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: appPupleDark),
    bodyText2: TextStyle(color: appPupleDark),
  ),
  listTileTheme: ListTileThemeData(
    textColor: appPupleDark,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: appPupleDark,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: appPupleDark,
        ),
      ),
    ),
  ),
);

ThemeData themeDark = ThemeData(
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: appWhite),
  brightness: Brightness.dark,
  primaryColor: appLightGrey,
  scaffoldBackgroundColor: appPupleDark,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: appPupleDark,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: appWhite),
    bodyText2: TextStyle(color: appWhite),
  ),
  listTileTheme: ListTileThemeData(
    textColor: appWhite,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: appWhite,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: appWhite,
        ),
      ),
    ),
  ),
);
