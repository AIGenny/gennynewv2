import 'package:flutter/material.dart';

import 'pallete.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFF181818),
          fontWeight: FontWeight.w600,
          fontSize: 20,
          height: 1.2),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blackColor,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFF181818),
          fontWeight: FontWeight.w700),
      bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFF181818),
          fontWeight: FontWeight.w700),
      bodySmall: TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFF181818),
          fontWeight: FontWeight.w300),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        color: Color(0xFF181818),
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
      ),
      labelStyle: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
      ),
    ),
  );
}
