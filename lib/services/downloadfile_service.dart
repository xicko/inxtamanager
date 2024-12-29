// broken

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/version.dart';

class DownloadfileService {
  Future<void> downloadFile({
    required AudioPlayer audioPlayer,
    required String? selectedVersion,
    required List<Version> versions,
    required Function(String) showSnackBar,
    required Function(double) downloadProgress, // Pass a callback to update progress
    required bool isDownloading,
    required Function(String) openAndroidApk,
  }) async {
    // Play sound
    await audioPlayer.play(AssetSource('sounds/click.wav'));

    // Show message when the selected version is null
    if (selectedVersion == null) {
      showSnackBar('Please select a version to download.');
      return;
    }

    // Initialize Dio
    final dio = Dio();

    // Find selected version or return a blank Version object as fallback
    final version = versions.firstWhere(
      (v) => v.version == selectedVersion,
      orElse: () => Version(
        label: '',
        version: '',
        instagramBase: '',
        downloadLink: '',
        changelog: '',
        releaseDate: '',
      ),
    );

    final directory = await getDownloadDirectory();

    // Return message if getting the download directory was unsuccessful/null
    if (directory == null) {
      showSnackBar('Unable to access downloads directory.');
      return;
    }

    final filePath = '${directory.path}/inxta_v${selectedVersion!}.apk'; // Save file as
    
    // Check if the selected version APK already exists in /Downloads
    final file = File(filePath);
    if (await file.exists()) {
      showSnackBar('Already downloaded, installing...');
      await Future.delayed(Duration(milliseconds: 800));
      await openAndroidApk(filePath);
      return;
    }

    try {
      // Start download
      isDownloading = true;  // Update isDownloading to true
      downloadProgress(0.0);  // Reset progress to 0

      // Update download progress
      await dio.download(version.downloadLink, filePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          final progress = received / total;
          debugPrint(progress as String?);
          downloadProgress(progress);  // Update download progress via the callback
        }
      });

      // After completion
      showSnackBar('Download complete: $filePath');
    } catch (e) {
      showSnackBar('Download failed: $e');
    } finally {
      isDownloading = false;  // Update isDownloading to false
    }

    // Auto open the downloaded APK file
    await Future.delayed(Duration(milliseconds: 800));
    await openAndroidApk(filePath);
  }

  Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }
}
