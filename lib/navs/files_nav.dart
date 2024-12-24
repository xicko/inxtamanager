import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/screens/file_explorer.dart';

class FilesNav extends StatelessWidget {
  const FilesNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey('files'),
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          page: () => const FileExplorerScreen(),
        );
      },
    );
  }
}