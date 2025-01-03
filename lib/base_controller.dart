import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:inxtamanager/models/version.dart';
import 'package:inxtamanager/services/downloadfile_service.dart';
import 'package:inxtamanager/services/permission_service.dart';
import 'package:inxtamanager/widgets/simple_snackbar.dart';
import 'package:open_file_manager/open_file_manager.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();
  final AudioPlayer audioPlayer = AudioPlayer();

  // obs makes the variable observable, allowing UI to react to changes
  var currentIndex = 0.obs;
  RxString appName = ''.obs;
  RxString versionName = 'Loading'.obs;
  RxString packageName = 'com.dashnyam.inxta'.obs;
  Rx<String?> selectedVersion = Rx<String?>(null);
  RxList<Version> versions = <Version>[].obs;
  RxDouble downloadProgress = 0.0.obs;
  RxBool isDownloading = false.obs;
  RxBool fileExists = false.obs;
  RxBool loading = true.obs;
  RxBool isAppInstalled = false.obs;
  RxBool isSnackBarVisible =
      false.obs; // flag to track if snackbar is currently active
  RxString updateStatus = 'Checking for updates...'.obs;
  RxString openResult = 'Unknown'.obs;

  // method to change the current index
  void changePage(int index) {
    currentIndex.value = index;
  }

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
    bool? uninstalled =
        await InstalledApps.uninstallApp(BaseController.to.packageName.value);

    // setting version text to not installed
    if (uninstalled == true) {
      BaseController.to.versionName.value = 'Not Installed';
    }
  }

  // downloadButton function checks for storage permission and then downloads
  Future<void> downloadButton(BuildContext context) async {
    await PermissionService
        .checkAndRequestStoragePermission(); // prompt storage permission

    if (context.mounted) {
      await DownloadfileService.downloadFile(context); // start downloading
    }
  }
}
