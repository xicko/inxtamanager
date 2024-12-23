import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/version.dart';
import '../widgets/download_progress.dart';
// import '../widgets/version_dropdown.dart';
// import '../services/version_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedVersion;
  List<Version> versions = [];
  double downloadProgress = 0.0;
  bool isDownloading = false;
  bool loading = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  // initializing at app startup
  Future<void> initializeApp() async {
    // await _checkAndRequestStoragePermission(); // for asking permission at startup
    await fetchVersions().then((fetchedVersions) {
      setState(() {
        versions = fetchedVersions;
        loading = false;
      });
    }).catchError((e) {
      _showSnackBar('Failed to load versions: $e');
    });
  }

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

  // downloadButton function checks for storage permission and then downloads
  Future<void> downloadButton() async {
    await _checkAndRequestStoragePermission(); // prompt storage permission
    await downloadFile(); // start downloading
  }

  Future<List<Version>> fetchVersions() async {
    final response =
        await http.get(Uri.parse('https://dl.dashnyam.com/inxtalog.json'));

    // decodes json into Version objects if response was 20(OK)
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Version.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load versions');
    }
  }

  Future<void> downloadFile() async { // main download function
    await _audioPlayer.play(AssetSource('sounds/click.wav')); // play sound

    // showing message when current selected version is null
    if (selectedVersion == null) {
      _showSnackBar('Please select a version to download.');
      return;
    }

    final dio = Dio(); // starting dio

    // finds selected version or returns a blank Version object as a fallback
    final version = versions.firstWhere(
      (v) => v.version == selectedVersion,
      orElse: () => Version(
          version: '', downloadLink: '', changelog: '', releaseDate: ''),
    );

    final directory = await getDownloadDirectory();

    // return message if getting download directory was unsuccessful/null
    if (directory == null) {
      _showSnackBar('Unable to access downloads directory.');
      return;
    }

    final filePath = '${directory.path}/inxta${selectedVersion!}.apk'; // save file as
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
  }

  Future<Directory?> getDownloadDirectory() async {
    // specifying download directory for platforms
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  // snackbar component for displaying messages below
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message, style: TextStyle(fontFamily: 'InstagramSans', fontSize: 16),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? const CircularProgressIndicator( // loading at start
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              )
            : Padding( // padding entire screen
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: Column(
                  children: [
                    const SizedBox(height: 140), // top space

                    const Image( // logo
                      image: AssetImage('assets/logo512.png'),
                      width: 100,
                      height: 100,
                    ),

                    const Text( // title
                      'Inxta Manager',
                      style: TextStyle(
                        fontFamily: 'InstagramSansHeadline',
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 20), // spacer

                    SizedBox(
                      width: double.infinity,
                      child: LayoutBuilder( // used layoutbuilder to dynamically find the width of the parent and set the width for its child
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
                                    label: version.version,
                                    labelWidget: Text(
                                      version.version,
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

                    SizedBox( // using sizedbox for max width button
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton( // download button
                          onPressed: isDownloading ? null : downloadButton, // downloadButton function checks for storage permission and then downloads if granted
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder( // rounding the edges
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            'Download APK',
                            style: TextStyle(
                              fontFamily: 'InstagramSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color:
                                  isDownloading ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),

                    if (isDownloading)
                    DownloadProgress(progress: downloadProgress),
                    
                    const SizedBox(height: 15), // spacer

                    Align( // aligning to left
                      alignment: Alignment.centerLeft,
                      child: Text( // changelog text
                        versions
                            .firstWhere((version) =>
                                version.version == selectedVersion,
                                orElse: () => Version( // if null these empty values are used
                                  version: '', 
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
    );
  }
}