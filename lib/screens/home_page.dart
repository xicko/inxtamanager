import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/base_controller.dart';
import 'package:inxtamanager/services/appversioninfo_service.dart';
import 'package:inxtamanager/widgets/appversioninfo_text.dart';
import 'package:inxtamanager/widgets/changelogtext.dart';
import 'package:inxtamanager/widgets/download_uninstall_files_buttons.dart';
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

// ===========================================================
  // initializing at app startup
  Future<void> initializeApp() async {
    try {
      final fetchedVersions = await _versionService.fetchVersions();

      BaseController.to.versions.value = fetchedVersions;
      BaseController.to.loading.value = false;

      // calling once at app launch
      AppVersionInfoService.getAppInfo();
      // calling _getAppInfo every 15 seconds
      Timer.periodic(Duration(seconds: 15), (timer) async {
        await AppVersionInfoService.getAppInfo();
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
            child: BaseController.to.loading.value
                ? const CircularProgressIndicator()
                : Padding(
                    // padding entire screen
                    padding: const EdgeInsets.symmetric(horizontal: 42),
                    child: Column(
                      children: [
                        // sets top space to 14% of the screen's total height
                        SizedBox(height: screenHeight * 0.13), // top space

                        LogoWithName(),

                        SizedBox(height: 14), // spacer

                        AppversioninfoText(),

                        SizedBox(
                            height: BaseController.to.isAppInstalled.value
                                ? 24
                                : 16), // spacer

                        VersionDropdown(),

                        SizedBox(height: 20), // spacer

                        DownloadUninstallFilesButtons(),

                        // showing progressbar when downloading
                        if (BaseController.to.isDownloading.value)
                          DownloadProgress(
                              progress:
                                  BaseController.to.downloadProgress.value),

                        SizedBox(height: 15), // spacer

                        ChangelogText()
                      ],
                    ),
                  ),
          ),
        )
      ],
    ));
  }
}
