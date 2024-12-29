import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'base_screen.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/base_controller.dart';
import 'theme/theme.dart';
// import 'theme/theme_provider.dart';

void main() {
  Get.put<BaseController>(BaseController());
  runApp(
    const MainApp(),

    // use for theme toggle button
    //ChangeNotifierProvider(
    //  create: (context) => ThemeProvider(),
    //  child: const MainApp(),
    //)
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BaseScreen(),
      theme: lightMode,
      darkTheme: darkMode,

      // theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}