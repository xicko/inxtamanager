// Base screen used for navigation bar, obx listens for changes
// in the BaseController, IndexedStack displays different screens
// based on the index of currentIndex which is changed by BottomNavBar

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inxtamanager/navs/home_nav.dart';
import 'package:inxtamanager/navs/help_nav.dart';
import 'controllers/base_controller.dart';
import 'package:inxtamanager/navigationbar.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            IndexedStack(
              index: BaseController.to.navIndex.value,
              children: const [
                HomeNav(),
                HelpNav(),
              ],
            ),

            // Custom shadow for navbar
            Positioned(
              bottom: 0,
              child: Container(
                height: 0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 26,
                      blurRadius: 48,
                      offset: Offset(
                        0,
                        5,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
