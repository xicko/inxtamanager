import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/controllers/app_version_controller.dart';
import 'package:inxtamanager/controllers/base_controller.dart';
import 'package:inxtamanager/widgets/appversioninfo_text.dart';
import 'package:inxtamanager/widgets/changelog.dart';
import 'package:inxtamanager/widgets/home_buttons.dart';
import 'package:inxtamanager/widgets/logo_with_name.dart';
import 'package:inxtamanager/widgets/simple_snackbar.dart';
import 'package:inxtamanager/widgets/download_progress.dart';
import 'package:inxtamanager/services/version_service.dart';
import 'package:inxtamanager/widgets/version_dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VersionService _versionService = VersionService();

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  // Initializing at app startup
  Future<void> initializeApp() async {
    try {
      final fetchedVersions = await _versionService.fetchVersions();

      BaseController.to.versions.value = fetchedVersions;
      BaseController.to.loading.value = false;

      // calling once at app launch
      AppVersionController.to.getAppInfo();
      // calling _getAppInfo every 15 seconds
      Timer.periodic(Duration(seconds: 15), (timer) async {
        await AppVersionController.to.getAppInfo();
      });
    } catch (e) {
      final snackbar = SimpleSnackbar(context);
      snackbar.show('Failed to load versions: $e');
    }
  }

  // MAIN UI
  @override
  Widget build(BuildContext context) {
    // getting user's device screen height
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // stack incase need to overlay elements over main UI
      body: Stack(
        children: [
          // Main UI
          Obx(
            () => Center(
              child: AnimatedOpacity(
                curve: Curves.easeInQuad,
                opacity: BaseController.to.loading.value ? 0 : 1,
                duration: Duration(milliseconds: 600),
                child: Padding(
                  // padding entire screen
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: Column(
                    children: [
                      // sets top space to 14% of the screen's total height
                      SizedBox(height: screenHeight * 0.08), // top space

                      LogoWithName(),

                      SizedBox(height: 14), // spacer

                      AppversioninfoText(),

                      SizedBox(
                        height: AppVersionController.to.isAppInstalled.value
                            ? 24
                            : 16,
                      ), // spacer

                      VersionDropdown(),

                      SizedBox(height: 20), // spacer

                      HomeButtons(),

                      DownloadProgress(),

                      SizedBox(height: 20), // spacer

                      ChangeLog()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
