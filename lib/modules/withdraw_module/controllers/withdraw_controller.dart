import '../../../exports.dart';

class WithdrawController extends GetxController {
  List<WithdrawMethod?>? availableMethods;
  List<Withdraw> withdrawsList = [];
  bool isLoading = false;
  bool hasMore = true;
  Uri endpoint =
      Uri.parse(Constants.restApiBaseUrl + '/withdrawal/withdrawals');
  var amountToWithdraw;
  WithdrawMethod? currentMethod;
  WithdrawalRepository? _repo;

  WithdrawController() {
    this._repo = WithdrawalRepository();
  }

  Future<void> getWithdrawals() async {
    waiting(); // 1 for loading 0 for completed
    List<Withdraw?>? withdrawals = await _repo?.getWithdrawals();
    if (withdrawals != null) {
      for (Withdraw? withdraw in withdrawals) {
        if (withdraw != null) withdrawsList.add(withdraw);
      }
    }
    finished();
    update();
  }

  // Future<List<WithdrawMethod>> getMethodsForCurrency(String currencyId) async {
  //   LoginController _loginController = Get.find<LoginController>();
  //   List<WithdrawMethod> methods =
  //       await this._repo.getMethods(currencyId, _loginController.token);
  //   if (methods != null) {
  //     this.availableMethods = methods;
  //     this.currentMethod = methods[0];
  //     update();
  //     return methods;
  //   }
  //   return null;
  // }

  void submitWithdrawal(
    String walletId,
  ) async {
    LoginController _loginController = Get.find<LoginController>();

    waiting();
    Withdraw? withdraw = await _repo?.submitWithdraw(
        _loginController.token!, walletId, this.amountToWithdraw);
    finished();
    if (withdraw != null) {
      //await this.resetController();
      this.withdrawsList.insert(0, withdraw);
      update();
      Get.offAll(HomeScreen());
    } else {
      print('repository error');
    }

    finished();
  }

  void setAmountToWithdraw(String amount) {
    this.amountToWithdraw = amount;
    update();
  }

  Future<void> resetController() async {
    this.endpoint =
        Uri.parse(Constants.restApiBaseUrl + '/withdrawal/withdrawals');
    this.withdrawsList = [];
    this.hasMore = true;
    //await this.getDeposits();
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
