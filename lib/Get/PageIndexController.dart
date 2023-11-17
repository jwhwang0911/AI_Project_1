import 'package:get/get.dart';

class PageIndexController extends GetxController {
  static PageIndexController get to => Get.find();

  int selectedIndex = 0;

  bool query_called = false;

  void setPageIndex(int index) {
    selectedIndex = index;
    update();
  }

  void setQeuryCalled() {
    query_called = !query_called;
    update();
  }
}
