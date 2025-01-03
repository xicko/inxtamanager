import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/base_controller.dart';
import 'package:inxtamanager/colors.dart';

class DownloadUninstallFilesButtons extends StatelessWidget {
  const DownloadUninstallFilesButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 55,
              width: 40,
              child: IconButton(
                onPressed: () async {
                  BaseController.to.openFileManagerApp();
                },
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
                  onPressed: BaseController.to.isDownloading.value
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
                        color: BaseController.to.isDownloading.value
                            ? AppColors.downloadButtonBackgroundColor(
                                Theme.of(context).brightness)
                            : AppColors.downloadButtonForegroundColor(
                                Theme.of(context).brightness)),
                  ),
                ),
              ),
            ),

            SizedBox(width: 10), // spacer

            SizedBox(
              height: 55,
              width: 40,
              child: IconButton(
                onPressed: () {
                  BaseController.to.uninstallApp();
                },
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color:
                      AppColors.deleteIconColor(Theme.of(context).brightness),
                ),
                tooltip: 'Uninstall from device',
                iconSize: 30,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
              ),
            ),
          ],
        ));
  }
}
