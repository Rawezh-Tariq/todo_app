import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 250, 250, 250),
    surfaceTintColor: Color.fromARGB(255, 250, 250, 250),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 24,
    ),
    centerTitle: true,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 250),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 24),
    bodySmall: TextStyle(color: Colors.black, fontSize: 18),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.black,
    titleTextStyle: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.black,
      fontSize: 18,
    ),
    subtitleTextStyle: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.black,
      fontSize: 14,
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    checkColor: MaterialStatePropertyAll(Colors.white),
    fillColor: MaterialStatePropertyAll(Color.fromARGB(255, 245, 243, 243)),
    side: BorderSide(color: Colors.white),
    shape: CircleBorder(),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.black),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      side: MaterialStatePropertyAll(
        BorderSide(color: Colors.black, width: 1),
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    surfaceTintColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    surfaceTintColor: Color.fromARGB(255, 250, 250, 250),
    backgroundColor: Color.fromARGB(255, 250, 250, 250),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
    sizeConstraints: const BoxConstraints.expand(width: 70, height: 70),
    iconSize: 34,
  ),
);
