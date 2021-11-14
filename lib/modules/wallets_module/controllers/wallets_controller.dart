import '../../../exports.dart';

class WalletsController extends GetxController {
  Wallet? currentWallet;
  String amountToTransfer = '1';
  List<Wallet?> userWallets = [];
  WalletRepository? _repository;

  bool isLoading = false;

  WalletsController() {
    _repository = WalletRepository();
  }

  Future<void> getWallets() async {
    LoginController _auth = Get.put(LoginController());
    List<Wallet?>? wallets = await _repository?.getWallets(_auth.token);

    if (wallets == null) {
      print('wallet controller returned null');
      return null;

      ///_auth.logout();
    } else {
      userWallets = wallets;

      if (currentWallet == null) {
        currentWallet = userWallets[0];
      }
      update();
    }
    return null;
  }

  Future<void> create(String accountNumber) async {
    LoginController _loginController = Get.find<LoginController>();
    TransferMethodController _tmc = Get.find<TransferMethodController>();
    waiting(); // 1 for loading 0 for completed

    Wallet? wallet = await _repository?.create(
        _loginController.token!, accountNumber, _tmc.currentMethod?.id);
    if (wallet != null) {
      //this.resetController();
      finished();
      update();
      Get.offAll(HomeScreen());
    } else {
      print('repository error');
    }
    finished();
  }

  void setCurrentWallet(String walletId) {
    this.currentWallet =
        userWallets.firstWhere((element) => element?.id == walletId);
    update();
  }

  setAmountToTransfer(String amount) {
    this.amountToTransfer = amount;
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
