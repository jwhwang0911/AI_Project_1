import 'package:get/get.dart';

class PageIndexController extends GetxController {
  static PageIndexController get to => Get.find();

  int selectedIndex = 0;

  void set_zero() {
    selectedIndex = 0;
    update();
  }

  void set_one() {
    selectedIndex = 1;
    update();
  }

  void set_two() {
    selectedIndex = 2;
    update();
  }
}
