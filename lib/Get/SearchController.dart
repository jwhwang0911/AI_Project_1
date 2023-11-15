import 'package:get/get.dart';

class SearchListController extends GetxController {
  static SearchListController get to => Get.find();

  RxList recentList = [].obs;

  void add(String _query) {
    if (_query.isNotEmpty && !recentList.contains(_query)) {
      recentList.add(_query);
    } else if (_query.isNotEmpty && recentList.contains(_query)) {
      recentList.removeWhere((element) => element == _query);
      recentList.add(_query);
    }
  }
}
