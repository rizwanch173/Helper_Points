import '../../../exports.dart';

class HomeController extends GetxController {
  String currentTab = 'Overview';

  void updateTab(String tab) {
    this.currentTab = tab;
    update();
  }
}
