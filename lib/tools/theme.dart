import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.black,
    titleTextStyle: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.black,
      fontSize: 24,
    ),
    subtitleTextStyle: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.black,
      fontSize: 14,
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    checkColor: MaterialStatePropertyAll(Colors.white),
    fillColor: MaterialStatePropertyAll(Colors.black),
    side: BorderSide(color: Colors.white),
  ),
  dividerTheme: const DividerThemeData(color: Colors.black, thickness: 1),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.black),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      side: MaterialStatePropertyAll(
        BorderSide(color: Colors.black, width: 1),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    iconSize: 24,
  ),
);
