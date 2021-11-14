import '../../../exports.dart';

class DepositMethodController extends GetxController {
  List<DepositMethod> methodList = [];
  DepositMethod? currentMethod;
  bool hasMore = true;
  bool isLoading = false;
  Uri endpoint =
      Uri.parse(Constants.restApiBaseUrl + '/deposit/deposit_methods');

  DepositMethodRepository? _repository;

  DepositMethodController() {
    _repository = DepositMethodRepository();
  }

  getMethods() async {
    LoginController _loginController = Get.find<LoginController>();

    try {
      //waiting();
      List<DepositMethod?>? methods =
          await _repository?.getMethods(_loginController.token!);
      //finished();
      if (methods != null) {
        for (DepositMethod? method in methods) {
          if (method != null) {
            this.methodList.add(method);
          }
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

  void setCurrentMethod(DepositMethod method) {
    this.currentMethod = method;
    update();
  }
}
