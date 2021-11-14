import '../../../exports.dart';

class SendController extends GetxController {
  User? sendTo;
  bool isLoading = false;

  SendRepository? _repo;

  SendController() {
    this._repo = SendRepository();
  }

  Future<void> submitTransfer(
      String note, String email, String amount, String currencyId) async {
    LoginController _loginController = Get.find<LoginController>();
    TransactionsController _transactionsController =
        Get.find<TransactionsController>();

    waiting();

    bool? response = await _repo?.submitTransfer(
        _loginController.token!, note, email, amount, currencyId);

    finished();
    if (response == true) {
      await _transactionsController.reset();
      Get.offAll(HomeScreen());
    }
  }

  void setSendTo(User user) {
    sendTo = user;
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
}
