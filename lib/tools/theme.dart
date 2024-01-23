import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.grey),
    titleTextStyle: TextStyle(
      color: Colors.grey,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        color: Colors.grey, fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.grey, fontSize: 18),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.grey,
    titleTextStyle: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.grey,
      fontSize: 24,
    ),
    subtitleTextStyle: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.grey,
      fontSize: 14,
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    checkColor: MaterialStatePropertyAll(Colors.black),
    fillColor: MaterialStatePropertyAll(Colors.grey),
    side: BorderSide(color: Colors.grey),
  ),
  dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 1),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.grey),
      foregroundColor: MaterialStatePropertyAll(Colors.grey),
      side: MaterialStatePropertyAll(
        BorderSide(color: Colors.black, width: 1),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.grey,
    iconSize: 24,
  ),
);
