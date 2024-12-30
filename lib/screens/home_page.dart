import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../theme/theme.dart';
// import '../theme/theme_provider.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:installed_apps/app_info.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_launcher_icons/xml_templates.dart';
// import 'package:pub_semver/pub_semver.dart' as semver;
import 'package:path_provider/path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:open_filex/open_filex.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:open_file_manager/open_file_manager.dart';
import 'package:inxtamanager/colors.dart'; // theme specific colors
import 'package:inxtamanager/models/version.dart';
import 'package:inxtamanager/widgets/download_progress.dart';
// import 'package:inxtamanager/widgets/version_dropdown.dart';
import 'package:inxtamanager/services/version_service.dart';
// import 'package:inxtamanager/services/downloadfile_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // default values
  String appName = '';
  String versionName = 'Loading'; 
  String packageName = 'com.dashnyam.inxta';
  String? selectedVersion;
  List<Version> versions = [];
  double downloadProgress = 0.0;
  bool isDownloading = false;
  bool fileExists = false;
  bool loading = true;
  bool isAppInstalled = false;
  bool _isSnackBarVisible = false; // flag to track if snackbar is currently active
  String _updateStatus = "Checking for updates...";
  
  final AudioPlayer _audioPlayer = AudioPlayer();

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
      setState(() {
        versions = fetchedVersions;
        loading = false;
      });

      // calling once at app launch
      _getAppInfo();
      // calling _getAppInfo every 15 seconds
      Timer.periodic(Duration(seconds: 15), (timer) async {
        await _getAppInfo();
      });
    } catch (e) {
      _showSnackBar('Failed to load versions: $e');
    }
  }
  





// ===========================================================
  // fetching versions from dl.dashnyam.com
  final VersionService _versionService = VersionService();








// ===========================================================
  Future<void> _checkAndRequestStoragePermission() async {
    if (Platform.isAndroid) {
      await _requestPermission(Permission.storage);
      if (Platform.version.contains('13')) {
        await _requestPermission(Permission.manageExternalStorage);
      }
    }
  }

  // requesting permission based on sdk version
  Future<bool>_requestPermission(Permission permission) async {
    AndroidDeviceInfo build=await DeviceInfoPlugin().androidInfo;
    if(build.version.sdkInt>=30){
      var re=await Permission.manageExternalStorage.request();
      if(re.isGranted)
      {
        return true;
      }
      else{
        return false;
      }
    } else {
      if(await permission.isGranted)
      {
        return true;
      } else {
        var result=await permission.request();
        if(result.isGranted)
        {
          return true;
        }
        else{
          return false;
        }
      }
    }
  }







// ===========================================================
  // downloadButton function checks for storage permission and then downloads
  Future<void> downloadButton() async {
    await _checkAndRequestStoragePermission(); // prompt storage permission
    
    await downloadFile(); // start downloading
  }







// ===========================================================
  Future<void> downloadFile() async { // main download function
    await _audioPlayer.play(AssetSource('sounds/click.wav')); // play sound

    // showing message when current selected version is null
    if (selectedVersion == null) {
      _showSnackBar('Please select a version to download.');
      return;
    }

    // starting dio
    final dio = Dio();

    // finds selected version or returns a blank Version object as a fallback
    final version = versions.firstWhere(
      (v) => v.version == selectedVersion,
      orElse: () => Version(
          label: '', version: '', instagramBase: '', downloadLink: '', changelog: '', releaseDate: ''),
    );

    final directory = await getDownloadDirectory();

    // return message if getting download directory was unsuccessful/null
    if (directory == null) {
      _showSnackBar('Unable to access downloads directory.');
      return;
    }

    final filePath = '${directory.path}/inxta_v${selectedVersion!}.apk'; // save file as
    
    // checks and installs if selected version apk already exists in /Downloads
    final file = File(filePath);
    if (await file.exists()) {
      setState(() {
        fileExists = true;
      });
      _showSnackBar('Already downloaded, installing...');
      await Future.delayed(Duration(milliseconds: 800));
      await _openAndroidApk(filePath);
      return;
    }

    try {
      // download start
      setState(() {
        isDownloading = true;
        downloadProgress = 0.0;
      });

      // updating downloadProgress based on received data and total size
      await dio.download(version.downloadLink, filePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          setState(() {
            downloadProgress = received / total;
          });
        }
      });

      // after completion
      _showSnackBar('Download complete: $filePath');
    } catch (e) {
      _showSnackBar('Download failed: $e');
    } finally {
      setState(() {
        isDownloading = false;
      });
    }

    // auto open the downloaded apk file
    await Future.delayed(Duration(milliseconds: 800));
    await _openAndroidApk(filePath);
  }









// ===========================================================
  // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers, unused_field
  var _openResult = 'Unknown';

  Future<void> _openAndroidApk(String filePath) async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      final result = await OpenFilex.open(filePath);
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });
    } if (await Permission.storage.request().isGranted) {
      final result = await OpenFilex.open(filePath);
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });
    }
  }








// ===========================================================
  Future<Directory?> getDownloadDirectory() async {
    // specifying download directory for platforms
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }







// ===========================================================
  // snackbar component for displaying messages below
  void _showSnackBar(String message) {
    // prevent multiple snackbars being called when spammed
    if (_isSnackBarVisible) return;

    // snackbar visible while _showCustomSnackBar is called
    _isSnackBarVisible = true;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 2),
        content: Center(
          child: Text(
          message, 
          style: TextStyle(
            fontFamily: 'InstagramSans',
            fontSize: 16
          )
        ),
        )
      )
    ).closed.then((_) {
      // resetting the flag after the snackbar disappears
      _isSnackBarVisible = false;
    });
  }



  



// ===========================================================
  // opening downloads directory with stock file manager app
  void _openFileManager() {
    openFileManager(
      androidConfig: AndroidConfig(
        folderType: FolderType.download, // Opens the Downloads folder
      ),
      iosConfig: IosConfig(
        subFolderPath: 'Documents', // Open a subfolder in the app's document folder on iOS
      ),
    );
  }






// ===========================================================
  // fetch app info
  Future<void> _getAppInfo() async {
    try {
      AppInfo? appInfo = await InstalledApps.getAppInfo(packageName);

      if (appInfo != null) {
        setState(() {
          appName = appInfo.name;
          versionName = appInfo.versionName;
          isAppInstalled = true;
        });

        checkVersion(versionName);
      } else {
        setState(() {
          appName = 'Not Installed';
          versionName = 'Not Installed';
          _updateStatus = 'App is not installed.';
          isAppInstalled = false;
        });
      }
    } catch (e) {
      setState(() {
        appName = 'Error';
        versionName = 'Error';
        _updateStatus = 'Error fetching app info.';
        isAppInstalled = false;
      });
    }
  }

  Future<void> _uninstallApp() async {
    bool? uninstalled = await InstalledApps.uninstallApp(packageName);

    // setting version text to not installed
    if (uninstalled == true) {
      setState(() {
        versionName = 'Not Installed';
      });
    }
  }







// ===========================================================
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
              .map((version) => convertToComparableFormat(version.instagramBase))
              .reduce((a, b) => _compareVersionLists(a, b) > 0 ? a : b);

          // convert the installed version to comparable format
          final installed = convertToComparableFormat(installedVersion);

          //debugPrint('Converted installed version: $installed');
          //debugPrint('Latest Instagram Base version: $latestBaseVersion');

          // compare installed version with latest base version and update status
          setState(() {
            _updateStatus = _compareVersionLists(installed, latestBaseVersion) < 0
                ? 'Update available! ${latestBaseVersion.join('.')}' // Display latest version
                : 'Your app is up-to-date!';
          });
        } else {
          //debugPrint('Error: Empty or incorrect data');
          setState(() {
            _updateStatus = 'Error fetching version data.';
          });
        }
      } else {
        //debugPrint('HTTP error: ${response.statusCode}');
        setState(() {
          _updateStatus = 'Error fetching version data.';
        });
      }
    } catch (e) {
      //debugPrint('Error checking version: $e');
      setState(() {
        _updateStatus = 'Error checking for updates.';
      });
    }
  }

  // for comparing two version lists
  int _compareVersionLists(List<int> a, List<int> b) {
    for (int i = 0; i < a.length && i < b.length; i++) {
      if (a[i] < b[i]) {
        return -1; // a is smaller than b
      } else if (a[i] > b[i]) {
        return 1; // a is greater than b
      }
    }
    return 0; // versions are equal
  }








  // main UI
  @override
  Widget build(BuildContext context) {
    // getting user's device screen height
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // stack incase need to overlay elements over main UI
      body: Stack(
        children: [
          // theme toggle button
          //Positioned(
          //top: 16,
          //right: 16,
          //child: SizedBox(
          //  height: 55,
          //  child: IconButton(
          //    onPressed: () {Provider.of<ThemeProvider>(context, listen: false).toggleTheme();},
          //    icon: Icon(
          //      Icons.light_mode_rounded,
          //      color: Theme.of(context).colorScheme.onPrimary,
          //    ),
          //    tooltip: 'Open downloads',
          //    iconSize: 30,
          //    ),
          //  ),
          //),

          // main UI
          Center(
            child: loading
                ? const CircularProgressIndicator()
                : Padding( // padding entire screen
                    padding: const EdgeInsets.symmetric(horizontal: 42),
                    child: Column(
                      children: [
                        // sets top space to 14% of the screen's total height
                        SizedBox(height: screenHeight * 0.14), // top space

                        const Image( // logo
                          image: AssetImage('assets/logo512.png'),
                          width: 100,
                          height: 100,
                        ),

                        Text( // title
                          'Inxta Manager',
                          style: TextStyle(
                            fontFamily: 'InstagramSansHeadline',
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: AppColors.titleTextColor(Theme.of(context).brightness),
                          ),
                        ),

                        const SizedBox(height: 14), // spacer

                        // installed version text
                        Text(
                          'Installed version: $versionName',
                          style: TextStyle(
                            fontFamily: 'InstagramSans',
                            fontSize: 16
                          ),
                        ),

                        const SizedBox(height: 8), // spacer

                        if (isAppInstalled)
                          Text(
                            _updateStatus,
                            style: TextStyle(
                              fontFamily: 'InstagramSans',
                              fontSize: 16,
                              color: AppColors.isInstalledTextColor(Theme.of(context).brightness),
                            ),
                          ),

                        const SizedBox(height: 24), // spacer

                        SizedBox(
                          width: double.infinity,
                          // used layoutbuilder to dynamically find the width of the parent and set the width for its child
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return DropdownMenu<String>(
                                initialSelection: selectedVersion,
                                width: constraints.maxWidth, // width
                                onSelected: (String? newValue) {
                                  setState(() {
                                    selectedVersion = newValue;
                                  });
                                },
                                label: const Text(
                                  'Select Version',
                                  style: TextStyle(
                                    fontFamily: 'InstagramSans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                dropdownMenuEntries: versions
                                    .map(
                                      (version) => DropdownMenuEntry<String>(
                                        value: version.version,
                                        label: version.label,
                                        labelWidget: Text(
                                          version.label,
                                          style: const TextStyle(
                                            fontFamily: 'InstagramSans',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20), // spacer

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 55,
                              child: IconButton(
                                onPressed: _openFileManager,
                                icon: Icon(
                                  Icons.drive_file_move_outline,
                                  color: AppColors.filesIconColor(Theme.of(context).brightness),
                                ),
                                tooltip: 'Open downloads',
                                iconSize: 30,
                              ),
                            ),

                            SizedBox(width: 10), // spacer

                            // using Expanded to stretch to fit its parent element
                            Expanded(
                              child: SizedBox(
                                height: 55,
                                child: ElevatedButton( // download button
                                  onPressed: isDownloading ? null : downloadButton, // downloadButton function checks for storage permission and then downloads if granted
                                  child: Text(
                                    'Download APK',
                                    style: TextStyle(
                                      fontFamily: 'InstagramSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color:
                                        isDownloading 
                                        ? AppColors.downloadButtonBackgroundColor(Theme.of(context).brightness) 
                                        : AppColors.downloadButtonForegroundColor(Theme.of(context).brightness)
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 10), // spacer

                            SizedBox(
                              height: 55,
                              child: IconButton(
                                onPressed: _uninstallApp,
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppColors.deleteIconColor(Theme.of(context).brightness),
                                ),
                                tooltip: 'Uninstall from device',
                                iconSize: 30,
                              ),
                            ),
                          ],
                        ),

                        // showing progressbar when downloading
                        if (isDownloading)
                        DownloadProgress(progress: downloadProgress),
                        
                        const SizedBox(height: 15), // spacer

                        // aligning to left
                        Align( 
                          alignment: Alignment.centerLeft,
                          child: Text( // changelog text
                            versions
                                .firstWhere((version) =>
                                    version.version == selectedVersion,
                                    orElse: () => Version( // if null these empty values are used
                                      label: '',
                                      version: '', 
                                      instagramBase: '',
                                      changelog: '', 
                                      downloadLink: '', 
                                      releaseDate: ''))
                                .changelog,
                            style: const TextStyle(
                              fontFamily: 'InstagramSans',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      )
    );
  }
}