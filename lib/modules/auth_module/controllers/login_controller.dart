import '../../../exports.dart';

class LoginController extends GetxController {
  AuthRepository? _auth;
  String? token;
  RxBool isLoged = false.obs;
  AppBindings? _appBindings;

  LoginController() {
    _auth = AuthRepository();
  }

  @override
  void onInit() {
    super.onInit();
    ever(isLoged, (value) {
      if (value == false) {
        Get.offAll(WelcomeScreen());
      } else if (value == true) {
        Get.offAll(HomeScreen());
      }
    });
    // ever(isLoged, (_) {
    //   if (isLoged.value == false) {
    //     //print(isLoged.value.toString() + 'from onInit ever()');
    //     Get.offAll(LoginScreen());
    //   } else {
    //     //print(isLoged.value.toString() + 'from onInit ever()');
    //     Get.offAll(HomeScreen());
    //   }
    // });
  }

  void setToken(token) {
    this.token = token;
    update();
  }

  void login(email, password) async {
    LoadingController _loadingController = Get.find<LoadingController>();

    _loadingController.waiting();
    token = await _auth?.login(email, password);
    _loadingController.finished();
    if (token != null) {
      isLoged.value = true;
    } else {
      Get.snackbar('Error', 'Incorect Credentials',
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
    }
    update();
  }

  void logout() {
    isLoged.value = false;
    token = null;
    Get.reset();
    _appBindings = AppBindings();

    _appBindings?.initAll();
    update();
  }
}
