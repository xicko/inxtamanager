import 'package:flutter/material.dart';
import 'package:inxtamanager/controllers/app_version_controller.dart';
import 'package:inxtamanager/controllers/download_controller.dart';
// import 'package:provider/provider.dart';
import 'base_screen.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/controllers/base_controller.dart';
import 'theme/theme.dart';
// import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<BaseController>(BaseController());
  Get.put<DownloadController>(DownloadController());
  Get.put<AppVersionController>(AppVersionController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BaseScreen(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
