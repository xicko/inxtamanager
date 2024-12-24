import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/help_page.dart';

class HelpNav extends StatelessWidget {
  const HelpNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey('help'),
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          page: () => const HelpPage(),
        );
      },
    );
  }
}