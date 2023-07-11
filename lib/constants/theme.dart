import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black)),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: outlineInputBorder,
      errorBorder: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      disabledBorder: outlineInputBorder,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            textStyle: const TextStyle(
              color: Colors.blue,
            ))),
  canvasColor: Colors.blue.shade500,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue.shade500,
      disabledBackgroundColor: Colors.grey,
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    )));

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
);
