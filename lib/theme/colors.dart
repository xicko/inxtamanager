import 'package:flutter/material.dart';

class AppColors {
  // Light theme colors
  static const Color light100black = Colors.black;

  static const Color lightDeleteIconColor = Color.fromARGB(255, 193, 5, 17);
  static const Color lightFilesIconColor = Color.fromARGB(255, 38, 38, 38);

  static const Color lightDownloadButtonBackgroundColor =
      Color.fromARGB(255, 38, 38, 38);
  static const Color lightDownloadButtonForegroundColor = Colors.white;

  static const Color lightIsInstalledTextColor = Color(0xFF124870);

  static const Color lightTitleTextColor = Color.fromARGB(255, 38, 38, 38);

  static const Color lightChLogBG = Color.fromARGB(255, 232, 232, 232);
  static const Color lightChLogHeaderBG = Color.fromARGB(255, 222, 222, 222);

  // Dark theme colors
  static const Color dark100white = Colors.white;

  static const Color darkDeleteIconColor = Color.fromARGB(255, 245, 63, 75);
  static const Color darkFilesIconColor = Colors.white;

  static const Color darkDownloadButtonBackgroundColor = Colors.white;
  static const Color darkDownloadButtonForegroundColor =
      Color.fromARGB(255, 38, 38, 38);

  static const Color darkIsInstalledTextColor =
      Color.fromARGB(255, 86, 178, 248);

  static const Color darkTitleTextColor = Colors.white;

  static const Color darkChLogBG = Color.fromARGB(255, 43, 43, 43);
  static const Color darkChLogHeaderBG = Color.fromARGB(255, 54, 54, 54);

  // Utility to get the appropriate color based on brightness
  static Color bw100(Brightness brightness) {
    return brightness == Brightness.light ? light100black : dark100white;
  }

  static Color deleteIconColor(Brightness brightness) {
    return brightness == Brightness.light
        ? lightDeleteIconColor
        : darkDeleteIconColor;
  }

  static Color filesIconColor(Brightness brightness) {
    return brightness == Brightness.light
        ? lightFilesIconColor
        : darkFilesIconColor;
  }

  static Color downloadButtonBackgroundColor(Brightness brightness) {
    return brightness == Brightness.light
        ? lightDownloadButtonBackgroundColor
        : darkDownloadButtonBackgroundColor;
  }

  static Color downloadButtonForegroundColor(Brightness brightness) {
    return brightness == Brightness.light
        ? lightDownloadButtonForegroundColor
        : darkDownloadButtonForegroundColor;
  }

  static Color isInstalledTextColor(Brightness brightness) {
    return brightness == Brightness.light
        ? lightIsInstalledTextColor
        : darkIsInstalledTextColor;
  }

  static Color titleTextColor(Brightness brightness) {
    return brightness == Brightness.light
        ? lightTitleTextColor
        : darkTitleTextColor;
  }

  static Color chLogBG(Brightness brightness) {
    return brightness == Brightness.light ? lightChLogBG : darkChLogBG;
  }

  static Color chLogHeaderBG(Brightness brightness) {
    return brightness == Brightness.light
        ? lightChLogHeaderBG
        : darkChLogHeaderBG;
  }
}
