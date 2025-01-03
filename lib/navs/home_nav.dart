import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/home_page.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey('home'),
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          page: () => const HomePage(),
        );
      },
    );
  }
}
