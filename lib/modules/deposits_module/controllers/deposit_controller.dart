import '../../../exports.dart';
import 'dart:io';

class DepositController extends GetxController {
  List<Deposit?>? depositList = [];
  bool hasMore = true;
  bool isLoading = false;
  Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/deposit/deposits');

  DepositRepository? _repository;
  UploadDepositRepository? _uploadRepository;

  DepositController() {
    _repository = DepositRepository();
    _uploadRepository = UploadDepositRepository();
  }

  Future<void> getDeposits() async {
    LoginController _loginController = Get.find<LoginController>();
    waiting();
    List<Deposit?>? deposits =
        await _repository?.getDeposits(_loginController.token!);
    finished();
    if (deposits != null) {
      for (Deposit? deposit in deposits) {
        depositList?.add(deposit);
      }
    }

    update();
  }

  Future<void> submitDeposit(
    File file,
    String message,
    String walletId,
    String transactionId,
  ) async {
    LoginController _loginController = Get.find<LoginController>();

    String fileName = basename(file.path);
    waiting();
    Deposit? deposit = await _uploadRepository?.submitDeposit(
      file: file,
      filename: fileName,
      token: _loginController.token!,
      message: message,
      walletId: walletId,
      transactionId: transactionId,
    );

    finished();
    if (deposit != null) {
      //await this.resetController();
      this.depositList?.insert(0, deposit);
      update();
      Get.offAll(HomeScreen());
    } else {
      print('repository error');
    }
    finished();
  }

  Future<void> resetController() async {
    this.endpoint = Uri.parse(Constants.restApiBaseUrl + '/deposit/deposits');
    this.depositList = [];
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
