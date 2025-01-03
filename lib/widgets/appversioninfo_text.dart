import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/base_controller.dart';
import 'package:inxtamanager/colors.dart';

class AppversioninfoText extends StatelessWidget {
  const AppversioninfoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            // installed version text
            Text(
              'Installed version: ${BaseController.to.versionName.value}',
              style: TextStyle(fontFamily: 'InstagramSans', fontSize: 16),
            ),

            SizedBox(height: 8), // spacer

            if (BaseController.to.isAppInstalled.value)
              Text(
                BaseController.to.updateStatus.value,
                style: TextStyle(
                  fontFamily: 'InstagramSans',
                  fontSize: 16,
                  color: AppColors.isInstalledTextColor(
                      Theme.of(context).brightness),
                ),
              ),
          ],
        ));
  }
}
