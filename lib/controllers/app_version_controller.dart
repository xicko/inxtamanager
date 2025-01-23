import 'dart:convert';

import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:http/http.dart' as http;
import 'package:inxtamanager/models/version.dart';

class AppVersionController extends GetxController {
  static AppVersionController get to => Get.find();

  RxString appName = ''.obs;
  RxString versionName = 'Loading'.obs;
  RxString packageName = 'com.dashnyam.inxta'.obs;
  RxBool isAppInstalled = false.obs;
  RxString updateStatus = 'Checking for updates...'.obs;

  Future<void> getAppInfo() async {
    try {
      AppInfo? appInfo = await InstalledApps.getAppInfo(packageName.value);

      if (appInfo != null) {
        appName.value = appInfo.name;
        versionName.value = appInfo.versionName;
        isAppInstalled.value = true;

        checkVersion(versionName.value);
      } else {
        appName.value = 'Not Installed';
        versionName.value = 'Not Installed';
        updateStatus.value = 'App is not installed.';
        isAppInstalled.value = false;
      }
    } catch (e) {
      appName.value = 'Error';
      versionName.value = 'Error';
      updateStatus.value = 'Error fetching app info.';
      isAppInstalled.value = false;
    }
  }

  Future<void> checkVersion(String installedVersion) async {
    const String jsonUrl = 'https://dl.dashnyam.com/inxtalog.json';

    try {
      final response = await http.get(Uri.parse(jsonUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        //debugPrint('Fetched data: $data');

        if (data.isNotEmpty) {
          // map json data to Version objects
          final versions = data.map((json) => Version.fromJson(json)).toList();

          // converting instagramBase to integers to make it comparable
          List<int> convertToComparableFormat(String version) {
            return version.split('.').map((e) => int.tryParse(e) ?? 0).toList();
          }

          // find the latest Instagram base version
          final latestBaseVersion = versions
              .map(
                  (version) => convertToComparableFormat(version.instagramBase))
              .reduce((a, b) => compareVersionLists(a, b) > 0 ? a : b);

          // convert the installed version to comparable format
          final installed = convertToComparableFormat(installedVersion);

          //debugPrint('Converted installed version: $installed');
          //debugPrint('Latest Instagram Base version: $latestBaseVersion');

          // compare installed version with latest base version and update status

          updateStatus.value = compareVersionLists(
                      installed, latestBaseVersion) <
                  0
              ? 'Update available! ${latestBaseVersion.join('.')}' // Display latest version
              : 'Your app is up-to-date!';
        } else {
          //debugPrint('Error: Empty or incorrect data');

          updateStatus.value = 'Error fetching version data.';
        }
      } else {
        //debugPrint('HTTP error: ${response.statusCode}');

        updateStatus.value = 'Error fetching version data.';
      }
    } catch (e) {
      //debugPrint('Error checking version: $e');

      updateStatus.value = 'Error checking for updates.';
    }
  }

  int compareVersionLists(List<int> a, List<int> b) {
    for (int i = 0; i < a.length && i < b.length; i++) {
      if (a[i] < b[i]) {
        return -1; // a is smaller than b
      } else if (a[i] > b[i]) {
        return 1; // a is greater than b
      }
    }
    return 0; // versions are equal
  }
}
