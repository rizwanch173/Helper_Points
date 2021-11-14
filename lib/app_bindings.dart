import 'exports.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    initAll();
  }

  void initAll() {
    // LAZYPUT

    // Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    // Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
    // Get.lazyPut<CatalogueController>(() => CatalogueController(), fenix: true);
    // Get.lazyPut<DepositController>(() => DepositController(), fenix: true);
    // Get.lazyPut<DepositMethodController>(() => DepositMethodController(),
    //     fenix: true);
    // Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    // Get.lazyPut<LoadingController>(() => LoadingController(), fenix: true);
    // Get.lazyPut<OtpController>(() => OtpController(), fenix: true);
    // Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    // Get.lazyPut<SendController>(() => SendController(), fenix: true);
    // Get.lazyPut<TransactionsController>(() => TransactionsController(),
    //     fenix: true);
    // Get.lazyPut<WalletsController>(() => WalletsController(), fenix: true);
    // Get.lazyPut<WithdrawController>(() => WithdrawController(), fenix: true);
    // Get.lazyPut<ScanController>(() => ScanController(), fenix: true);

    //PUT
    Get.put(LoginController());
    Get.put(RegisterController());
    Get.put(TransferMethodController());
    Get.put(CatalogueController());
    Get.put(DepositController());
    Get.put(DepositMethodController());
    Get.put(HomeController());
    Get.put(LoadingController());
    Get.put(OtpController());
    Get.put(ProfileController());
    Get.put(SendController());
    Get.put(TransactionsController());
    Get.put(WalletsController());
    Get.put(WithdrawController());
    Get.put(ScanController());
  }
}
