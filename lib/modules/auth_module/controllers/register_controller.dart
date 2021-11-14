import '../../../exports.dart';

class RegisterController extends GetxController {
  AuthRepository? _authRepository;
  String phonePrefix = '+1';
  String countryCode = 'US';

  RegisterController() {
    _authRepository = AuthRepository();
  }

  void changePhonePrefix(String prefix) {
    phonePrefix = prefix;
    update();
  }

  void changeCountryCode(String code) {
    countryCode = code;
    update();
  }

  void register(
    name,
    email,
    password,
    repeatPassword,
    contryCode,
    phoneNumber,
  ) async {
    LoginController _loginController = Get.find<LoginController>();
    LoadingController _loadingController = Get.find<LoadingController>();
    _loadingController.waiting();
    _loginController.token = await _authRepository?.register(
        name, email, password, repeatPassword, contryCode, phoneNumber);
    _loadingController.finished();
    if (_loginController.token != null) {
      _loginController.isLoged.value = true;
    } else {
      // Get.snackbar('Error', 'Incorect Credentials',
      //     snackPosition: SnackPosition.BOTTOM,
      //     colorText: Colors.white,
      //     backgroundColor: Colors.grey[900]);
    }
    update();
  }
}
