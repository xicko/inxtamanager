import 'dart:convert';

import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:inxtamanager/base_controller.dart';
import 'package:inxtamanager/models/version.dart';
import 'package:http/http.dart' as http;

class AppVersionInfoService {
  // fetch installed app info
  static Future<void> getAppInfo() async {
    try {
      AppInfo? appInfo =
          await InstalledApps.getAppInfo(BaseController.to.packageName.value);

      if (appInfo != null) {
        BaseController.to.appName.value = appInfo.name;
        BaseController.to.versionName.value = appInfo.versionName;
        BaseController.to.isAppInstalled.value = true;

        checkVersion(BaseController.to.versionName.value);
      } else {
        BaseController.to.appName.value = 'Not Installed';
        BaseController.to.versionName.value = 'Not Installed';
        BaseController.to.updateStatus.value = 'App is not installed.';
        BaseController.to.isAppInstalled.value = false;
      }
    } catch (e) {
      BaseController.to.appName.value = 'Error';
      BaseController.to.versionName.value = 'Error';
      BaseController.to.updateStatus.value = 'Error fetching app info.';
      BaseController.to.isAppInstalled.value = false;
    }
  }

// ===========================================================
  static Future<void> checkVersion(String installedVersion) async {
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

          BaseController.to.updateStatus.value = compareVersionLists(
                      installed, latestBaseVersion) <
                  0
              ? 'Update available! ${latestBaseVersion.join('.')}' // Display latest version
              : 'Your app is up-to-date!';
        } else {
          //debugPrint('Error: Empty or incorrect data');

          BaseController.to.updateStatus.value = 'Error fetching version data.';
        }
      } else {
        //debugPrint('HTTP error: ${response.statusCode}');

        BaseController.to.updateStatus.value = 'Error fetching version data.';
      }
    } catch (e) {
      //debugPrint('Error checking version: $e');

      BaseController.to.updateStatus.value = 'Error checking for updates.';
    }
  }

  // for comparing two version lists
  static int compareVersionLists(List<int> a, List<int> b) {
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
