import 'package:flutter/material.dart';

import 'pallete.dart';

class AppTheme {

 static ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
    print("kk ${isDarkTheme}");

    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Pallete.backgroundColor,
      appBarTheme:  AppBarTheme(
        backgroundColor: isDarkTheme ? Colors.black : Pallete.backgroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          color: isDarkTheme ? Colors.white : Color(0xFF181818),
          fontWeight: FontWeight.w600,
          fontSize: 20,
          height: 1.2,
        ),
        iconTheme:IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:  isDarkTheme ?Colors.white: Color(0xFF181818),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: isDarkTheme ? Colors.white : Colors.black,
        textColor: isDarkTheme ? Colors.white : Colors.black,
        titleTextStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
        )
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: isDarkTheme ? Colors.black : Pallete.backgroundColor,
          iconColor: isDarkTheme ? Colors.white : Colors.black,
          textColor: isDarkTheme ? Colors.white : Colors.black,
      ),

      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          color: isDarkTheme ? Colors.white : Color(0xFF181818),
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          color: isDarkTheme ? Colors.white : Color(0xFF181818),
          fontWeight: FontWeight.w700,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Poppins',
          color: isDarkTheme ? Colors.white : Color(0xFF181818),
          fontWeight: FontWeight.w300,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          color: isDarkTheme ? Colors.white : Color(0xFF181818),
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme:IconThemeData(
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      inputDecorationTheme:  InputDecorationTheme(
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          color:isDarkTheme ?Colors.white: Color(0xFF181818),
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          color:  isDarkTheme ?Colors.white: Color(0xFF181818),
        ),
      ),
    );

  }
}
