import 'package:flutter/material.dart';
import 'package:open_file_manager/open_file_manager.dart';

class FileExplorerScreen extends StatefulWidget {
  const FileExplorerScreen({super.key});

  @override
  _FileExplorerScreenState createState() => _FileExplorerScreenState();
}

class _FileExplorerScreenState extends State<FileExplorerScreen> with AutomaticKeepAliveClientMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Explorer'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openFileManager,
          child: Text('Open File Manager'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}