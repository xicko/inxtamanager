import 'package:get/get.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();
  // obs makes the variable observable, allowing UI to react to changes
  var currentIndex = 0.obs;

  // method to change the current index
  void changePage(int index) {
    currentIndex.value = index;
  }
}