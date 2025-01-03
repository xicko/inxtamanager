import 'package:flutter/material.dart';
import 'package:inxtamanager/base_controller.dart';

class VersionDropdown extends StatelessWidget {
  const VersionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // used layoutbuilder to dynamically find the width of the parent and set the width for its child
      child: LayoutBuilder(
        builder: (context, constraints) {
          return DropdownMenu<String>(
            initialSelection: BaseController.to.selectedVersion.value,
            width: constraints.maxWidth, // width
            onSelected: (String? newValue) {
              BaseController.to.selectedVersion.value = newValue;
            },
            label: const Text(
              'Select Version',
              style: TextStyle(
                fontFamily: 'InstagramSans',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            dropdownMenuEntries: BaseController.to.versions
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
    );
  }
}
