import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:inxtamanager/navs/files_nav.dart';
import 'package:inxtamanager/navs/home_nav.dart';
import 'package:inxtamanager/navs/help_nav.dart';
import '/base_controller.dart';
import '../navigationbar.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: BaseController.to.currentIndex.value,
            children: const [
              HomeNav(),
              HelpNav(),
              // FilesNav(),
            ],
          )),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}