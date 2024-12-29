import 'package:flutter/material.dart';

// ==================================================================================================
ThemeData lightMode = ThemeData(
  fontFamily: 'InstagramSans',
  scaffoldBackgroundColor: Colors.grey[100], // Scaffold color
  colorScheme: ColorScheme(
    primary: Color(0xFF124870), // for update text
    secondary: Colors.white,
    surface: Colors.white,
    error: Color.fromARGB(255, 193, 5, 17), // for delete button
    onPrimary: Color.fromARGB(255, 38, 38, 38), // gray on white
    onSecondary: Color.fromARGB(255, 38, 38, 38), 
    onSurface: Color.fromARGB(255, 38, 38, 38), 
    onError: Color.fromARGB(255, 38, 38, 38), 
    brightness: Brightness.light,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 38, 38, 38),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder( // rounding the edges
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Color.fromARGB(255, 38, 38, 38),
    linearTrackColor: Colors.black12,
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(color: Color.fromARGB(255, 38, 38, 38)),
  ),
  
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
    ),
  ),

  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Color.fromARGB(255, 38, 38, 38),
    backgroundColor: Colors.white,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.white,
    unselectedItemColor: Color.fromARGB(255, 38, 38, 38),
  ),
);



// ==================================================================================================
ThemeData darkMode = ThemeData(
  fontFamily: 'InstagramSans',
  scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20), // Scaffold color - darker than gray[100]
  colorScheme: ColorScheme(
    primary: Color.fromARGB(255, 86, 178, 248), // for update text
    secondary: Color.fromARGB(255, 38, 38, 38),
    surface: Color.fromARGB(255, 38, 38, 38),
    error: Color.fromARGB(255, 245, 63, 75), // for delete button
    onPrimary: Colors.white, // white on gray
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Color.fromARGB(255, 38, 38, 38),
      shape: RoundedRectangleBorder( // rounding the edges
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.white,
    linearTrackColor: Colors.white12,
  ),
  
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey[900],
    contentTextStyle: TextStyle(color: Colors.white),
  ),
  
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.black),
    ),
  ),

  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.white,
    backgroundColor: Colors.grey[900],
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.grey[900],
    unselectedItemColor: Colors.white,
  ),
);