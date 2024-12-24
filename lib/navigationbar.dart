import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/base_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => NavigationBar(
          indicatorColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 10,
          // height: 120,
          // animationDuration: Duration(seconds: 2),
          selectedIndex: BaseController.to.currentIndex.value,
          onDestinationSelected: (index) => BaseController.to.changePage(index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.help_outline_rounded),
              selectedIcon: Icon(
                Icons.help_rounded,
                color: Colors.white,
              ),
              label: 'Help',
            ),

            // FILES SCREEN REMOVED
          ],
        ));
  }
}