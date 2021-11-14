import '../../../exports.dart';

class TransferMethodController extends GetxController {
  List<TransferMethod> methodList = [];
  TransferMethodRepository? _repo;
  TransferMethod? currentMethod;
  bool hasMore = true;
  bool isLoading = false;
  //String endpoint = Constants.restApiBaseUrl + '/deposit/deposit_methods';

  TransferMethodController() {
    this._repo = TransferMethodRepository();
  }

  getMethods() async {
    this.methodList = [];
    LoginController _loginController = Get.find<LoginController>();

    try {
      waiting();
      List<TransferMethod?>? methods =
          await _repo?.getTransferMethods(_loginController.token!);
      finished();
      if (methods != null) {
        for (TransferMethod? method in methods) {
          if (method != null) this.methodList.add(method);
        }
      }
    } catch (e) {
      print(e);
    }

    update();
  }

  void waiting() {
    this.isLoading = true;
    update();
  }

  void finished() {
    this.isLoading = false;
    update();
  }

  void setCurrentMethod(TransferMethod method) {
    this.currentMethod = method;
    update();
  }
}
