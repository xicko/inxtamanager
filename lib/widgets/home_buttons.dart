import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:inxtamanager/controllers/app_version_controller.dart';
import 'package:inxtamanager/controllers/base_controller.dart';
import 'package:inxtamanager/theme/colors.dart';
import 'package:inxtamanager/controllers/download_controller.dart';
import 'package:open_file_manager/open_file_manager.dart';

class HomeButtons extends StatefulWidget {
  const HomeButtons({super.key});

  @override
  State<HomeButtons> createState() => _HomeButtonsState();
}

class _HomeButtonsState extends State<HomeButtons> {
// Method to open stock file manager app
  void openFileManagerApp() {
    openFileManager(
      androidConfig: AndroidConfig(
        folderType: FolderType.download, // Opens the Downloads folder
      ),
      iosConfig: IosConfig(
        subFolderPath:
            'Documents', // Open a subfolder in the app's document folder on iOS
      ),
    );
  }

  // method to prompt app uninstall if already installed on device
  Future<void> uninstallApp() async {
    bool? uninstalled = await InstalledApps.uninstallApp(
        AppVersionController.to.packageName.value);

    // setting version text to not installed
    if (uninstalled == true) {
      AppVersionController.to.versionName.value = 'Not Installed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 55,
            width: 40,
            child: IconButton(
              onPressed: () => openFileManagerApp(),
              icon: Icon(
                Icons.drive_file_move_outline,
                color: AppColors.filesIconColor(Theme.of(context).brightness),
              ),
              tooltip: 'Open downloads',
              iconSize: 30,
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
            ),
          ),

          SizedBox(width: 16), // spacer

          // using Expanded to stretch to fit its parent element
          Expanded(
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                // download button
                onPressed: DownloadController.to.isDownloading.value
                    ? null
                    : () async {
                        BaseController.to.downloadButton(context);
                      },

                child: Text(
                  'Download APK',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'InstagramSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: DownloadController.to.isDownloading.value
                        ? AppColors.downloadButtonBackgroundColor(
                            Theme.of(context).brightness)
                        : AppColors.downloadButtonForegroundColor(
                            Theme.of(context).brightness),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 10), // spacer

          SizedBox(
            height: 55,
            width: 40,
            child: IconButton(
              onPressed: () => uninstallApp(),
              icon: Icon(
                Icons.delete_outline_rounded,
                color: AppColors.deleteIconColor(Theme.of(context).brightness),
              ),
              tooltip: 'Uninstall from device',
              iconSize: 30,
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
