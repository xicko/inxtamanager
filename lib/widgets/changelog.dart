import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/controllers/base_controller.dart';
import 'package:inxtamanager/models/version.dart';
import 'package:inxtamanager/theme/colors.dart';

class ChangeLog extends StatelessWidget {
  const ChangeLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: AnimatedOpacity(
          opacity: BaseController.to.selectedVersion.value != null ? 1 : 0,
          duration: Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.chLogBG(Theme.of(context).brightness),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: ListView(
                padding: EdgeInsets.only(bottom: 50),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          AppColors.chLogHeaderBG(Theme.of(context).brightness),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                      child: Text(
                        'Version Info',
                        style: TextStyle(
                          color: AppColors.bw100(Theme.of(context).brightness),
                          fontFamily: 'InstagramSans',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  // Changelog
                  Align(
                    alignment:
                        Alignment.centerLeft, // Align text to the top left
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Text(
                        // changelog text
                        BaseController.to.versions
                            .firstWhere(
                                (version) =>
                                    version.version ==
                                    BaseController.to.selectedVersion.value,
                                orElse: () => Version(
                                    // if null these empty values are used
                                    label: '',
                                    version: '',
                                    instagramBase: '',
                                    changelog: '',
                                    downloadLink: '',
                                    releaseDate: ''))
                            .changelog,
                        style: TextStyle(
                          fontFamily: 'InstagramSans',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: AppColors.bw100(Theme.of(context).brightness),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
