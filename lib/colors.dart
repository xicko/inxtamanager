import 'package:flutter/material.dart';

class AppColors {
  // Light theme colors
  static const Color lightDeleteIconColor = Color.fromARGB(255, 193, 5, 17);
  static const Color lightFilesIconColor = Color.fromARGB(255, 38, 38, 38);

  static const Color lightDownloadButtonBackgroundColor =
      Color.fromARGB(255, 38, 38, 38);
  static const Color lightDownloadButtonForegroundColor = Colors.white;

  static const Color lightIsInstalledTextColor = Color(0xFF124870);

  static const Color lightTitleTextColor = Color.fromARGB(255, 38, 38, 38);

  // Dark theme colors
  static const Color darkDeleteIconColor = Color.fromARGB(255, 245, 63, 75);
  static const Color darkFilesIconColor = Colors.white;

  static const Color darkDownloadButtonBackgroundColor = Colors.white;
  static const Color darkDownloadButtonForegroundColor =
      Color.fromARGB(255, 38, 38, 38);

  static const Color darkIsInstalledTextColor =
      Color.fromARGB(255, 86, 178, 248);

  static const Color darkTitleTextColor = Colors.white;

  // Utility to get the appropriate color based on brightness
  static Color deleteIconColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkDeleteIconColor
        : lightDeleteIconColor;
  }

  static Color filesIconColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkFilesIconColor
        : lightFilesIconColor;
  }

  static Color downloadButtonBackgroundColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkDownloadButtonBackgroundColor
        : lightDownloadButtonBackgroundColor;
  }

  static Color downloadButtonForegroundColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkDownloadButtonForegroundColor
        : lightDownloadButtonForegroundColor;
  }

  static Color isInstalledTextColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkIsInstalledTextColor
        : lightIsInstalledTextColor;
  }

  static Color titleTextColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkTitleTextColor
        : lightTitleTextColor;
  }
}
