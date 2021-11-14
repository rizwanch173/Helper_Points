import '../../../exports.dart';

class ScanController extends GetxController {
  bool isLoading = false;

  void waiting() {
    this.isLoading = true;
    update();
  }

  void finished() {
    this.isLoading = false;
    update();
  }
}
