import 'package:flutter/material.dart';
import 'base_screen.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/base_controller.dart';

void main() {
  Get.put<BaseController>(BaseController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BaseScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // grey 100
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.black,
          contentTextStyle: const TextStyle(color: Colors.white), // white text
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
      ),
    );
  }
}