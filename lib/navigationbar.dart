import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/controllers/base_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NavigationBar(
        selectedIndex: BaseController.to.navIndex.value,
        onDestinationSelected: (index) => BaseController.to.changePage(index),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.help_outline_rounded),
            selectedIcon: Icon(Icons.help_rounded),
            label: 'Help',
          ),
        ],
      ),
    );
  }
}
