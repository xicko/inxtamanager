import 'package:flutter/material.dart';
import '../models/version.dart';

class VersionDropdown extends StatelessWidget {
  final List<Version> versions;
  final String? selectedVersion;
  final Function(String?) onChanged;

  const VersionDropdown({
    super.key,
    required this.versions,
    required this.selectedVersion,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: double.infinity,
      initialSelection: selectedVersion,
      onSelected: onChanged,
      textStyle: TextStyle(
        fontFamily: 'InstagramSans',
      ),
      label: const Text(
        'Select Version',
        style: TextStyle(
          fontFamily: 'InstagramSans',
          fontWeight: FontWeight.w500,
        ),
      ),
      dropdownMenuEntries: versions
        .map(
          (version) => DropdownMenuEntry<String>(
            value: version.version, 
            label: version.version,
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontFamily: 'InstagramSans'
                )
              )
            )
            )
        ).toList(),
    );
  }
}