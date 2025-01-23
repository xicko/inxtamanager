import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/controllers/download_controller.dart';
import 'package:inxtamanager/models/version.dart';
import 'package:inxtamanager/services/permission_service.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();

  RxBool loading = true.obs;
  var navIndex = 0.obs;
  RxBool isSnackBarVisible =
      false.obs; // flag to track if snackbar is currently active

  final AudioPlayer audioPlayer = AudioPlayer();

  Rx<String?> selectedVersion = Rx<String?>(null);
  RxList<Version> versions = <Version>[].obs;

  RxString openResult = 'Unknown'.obs;

  // method to change the current index
  void changePage(int index) {
    navIndex.value = index;
  }

  // downloadButton function checks for storage permission and then downloads
  Future<void> downloadButton(BuildContext context) async {
    await PermissionService
        .checkAndRequestStoragePermission(); // prompt storage permission

    if (context.mounted) {
      await DownloadController.to.downloadFile(context); // start downloading
    }
  }
}
