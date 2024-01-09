import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.amber,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
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
      color: Colors.grey,
      fontSize: 14,
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    checkColor: MaterialStatePropertyAll(Colors.black),
    fillColor: MaterialStatePropertyAll(Colors.amber),
    side: BorderSide(color: Colors.amber),
  ),
  dividerTheme: const DividerThemeData(color: Colors.amberAccent, thickness: 1),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.amber),
      foregroundColor: MaterialStatePropertyAll(Colors.black),
      side: MaterialStatePropertyAll(
        BorderSide(color: Colors.black, width: 1),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.amber,
    iconSize: 24,
  ),
);
