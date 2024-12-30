// element specific colors are in /lib/colors.dart

import 'package:flutter/material.dart';

// ==================================================================================================
ThemeData lightMode = ThemeData(
  fontFamily: 'InstagramSans',
  scaffoldBackgroundColor: Colors.grey[100], // Scaffold color
  colorScheme: ColorScheme(
    primary: Color(0xFF124870), // For primary actions like update text
    secondary: Color(0xFFB3B3B3), // A neutral gray for secondary elements
    surface: Colors.white, // Background surfaces (cards, dialogs)
    error: Color(0xFFC10511), // Error-related visuals (delete buttons)
    onPrimary: Colors.white, // Text/icons on primary color (white on blue)
    onSecondary: Color(0xFF383838), // Text/icons on secondary color (dark gray)
    onSurface: Color(0xFF383838), // Text/icons on surface (dark gray on white)
    onError: Colors.white, // Text/icons on error (white on red)
    brightness: Brightness.light, // Light theme brightness
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 38, 38, 38),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
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
    indicatorColor: Colors.grey[900],
    backgroundColor: Colors.white,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: Colors.grey[900]),
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: Colors.white); // Color for selected icons
        }
        return IconThemeData(color: Colors.grey[900]); // Color for unselected icons
      },
    ),
  ),
);



// ==================================================================================================
ThemeData darkMode = ThemeData(
  fontFamily: 'InstagramSans',
  scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20), // Scaffold color - darker than gray[100]
  colorScheme: ColorScheme(
    primary: Color(0xFF56B2F8), // For primary actions like update text
    secondary: Color(0xFF606060), // A neutral gray for secondary elements
    surface: Color(0xFF1E1E1E), // Background surfaces (cards, dialogs)
    error: Color(0xFFF53F4B), // Error-related visuals (delete buttons)
    onPrimary: Colors.black, // Text/icons on primary color (black on light blue)
    onSecondary: Colors.white, // Text/icons on secondary color (white on gray)
    onSurface: Colors.white, // Text/icons on surface (white on dark gray)
    onError: Colors.white, // Text/icons on error (white on red)
    brightness: Brightness.dark, // Dark theme brightness
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Color.fromARGB(255, 38, 38, 38),
      shape: RoundedRectangleBorder(
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
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: Colors.white),
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: Colors.grey[900]); // Color for selected icons
        }
        return IconThemeData(color: Colors.white); // Color for unselected icons
      },
    ),
  ),
);