import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inxtamanager/base_controller.dart';
import 'package:inxtamanager/widgets/simple_snackbar.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:inxtamanager/models/version.dart';

class DownloadfileService {
  // Getting Download Director
  static Future<Directory?> getDownloadDirectory() async {
    // specifying download directory for platforms
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  // Open APK Method
  static Future<void> openAndroidApk(String filePath) async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      final result = await OpenFilex.open(filePath);

      BaseController.to.openResult.value =
          "type=${result.type}  message=${result.message}";
    }
    if (await Permission.storage.request().isGranted) {
      final result = await OpenFilex.open(filePath);

      BaseController.to.openResult.value =
          "type=${result.type}  message=${result.message}";
    }
  }

  // Main Download File Method
  static Future<void> downloadFile(BuildContext context) async {
    //snackbar
    final snackbar = SimpleSnackbar(context);

    // main download function
    await BaseController.to.audioPlayer
        .play(AssetSource('sounds/click.wav')); // play sound

    // showing message when current selected version is null
    if (BaseController.to.selectedVersion.value == null) {
      snackbar.show('Please select a version to download.');
      return;
    }

    // starting dio
    final dio = Dio();

    // finds selected version or returns a blank Version object as a fallback
    final version = BaseController.to.versions.firstWhere(
      (v) => v.version == BaseController.to.selectedVersion.value,
      orElse: () => Version(
          label: '',
          version: '',
          instagramBase: '',
          downloadLink: '',
          changelog: '',
          releaseDate: ''),
    );

    final directory = await getDownloadDirectory();

    // return message if getting download directory was unsuccessful/null
    if (directory == null) {
      snackbar.show('Unable to access downloads directory.');
      return;
    }

    final filePath =
        '${directory.path}/inxta_v${BaseController.to.selectedVersion.value!}.apk'; // save file as

    // checks and installs if selected version apk already exists in /Downloads
    final file = File(filePath);
    if (await file.exists()) {
      BaseController.to.fileExists.value = true;

      snackbar.show('Already downloaded, installing...');
      await Future.delayed(Duration(milliseconds: 800));
      await openAndroidApk(filePath);
      return;
    }

    try {
      // download start

      BaseController.to.isDownloading.value = true;
      BaseController.to.downloadProgress.value = 0.0;

      // updating downloadProgress based on received data and total size
      await dio.download(version.downloadLink, filePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          BaseController.to.downloadProgress.value = received / total;
        }
      });

      // after completion
      snackbar.show('Download complete: $filePath');
    } catch (e) {
      snackbar.show('Download failed: $e');
    } finally {
      BaseController.to.isDownloading.value = false;
    }

    // auto open the downloaded apk file
    await Future.delayed(Duration(milliseconds: 800));
    await openAndroidApk(filePath);
  }
}
