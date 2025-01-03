import 'package:flutter/material.dart';
import 'package:inxtamanager/base_controller.dart';

class SimpleSnackbar {
  static final SimpleSnackbar _instance = SimpleSnackbar._internal();

  factory SimpleSnackbar(BuildContext context) {
    _instance.context = context;
    return _instance;
  }

  SimpleSnackbar._internal();

  late BuildContext context;

  // snackbar component for displaying messages below
  void show(String message) {
    // prevent multiple snackbars being called when spammed
    if (BaseController.to.isSnackBarVisible.value) return;

    // snackbar visible while _showCustomSnackBar is called
    BaseController.to.isSnackBarVisible.value = true;

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
              behavior: SnackBarBehavior.fixed,
              duration: Duration(seconds: 2),
              content: Center(
                child: Text(message,
                    style:
                        TextStyle(fontFamily: 'InstagramSans', fontSize: 16)),
              )))
          .closed
          .then((_) {
        // resetting the flag after the snackbar disappears
        BaseController.to.isSnackBarVisible.value = false;
      });
    }
  }
}
