import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/base_controller.dart';
import 'package:inxtamanager/models/version.dart';

class ChangelogText extends StatelessWidget {
  const ChangelogText({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Flexible(
          child: ListView(
            padding: EdgeInsets.zero, // remove default padding
            children: [
              Align(
                alignment: Alignment.centerLeft, // Align text to the top left
                child: Padding(
                  padding: const EdgeInsets.all(0),
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
                    style: const TextStyle(
                      fontFamily: 'InstagramSans',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
