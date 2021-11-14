import '../../../exports.dart';

class LoadingController extends GetxController {
  RxInt isLoading = 0.obs; // 1 for loading 0 for completed

  void waiting() {
    this.isLoading.value = 1;
  }

  void finished() {
    this.isLoading.value = 0;
  }
}
