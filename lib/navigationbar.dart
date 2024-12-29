import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/base_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => NavigationBar(
          elevation: 10,
          // height: 120,
          // animationDuration: Duration(seconds: 2),
          selectedIndex: BaseController.to.currentIndex.value,
          onDestinationSelected: (index) => BaseController.to.changePage(index),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(
                Icons.home,
                color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.help_outline_rounded),
              selectedIcon: Icon(
                Icons.help_rounded,
                color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              ),
              label: 'Help',
            ),

            // FILES SCREEN REMOVED
          ],
        ));
  }
}