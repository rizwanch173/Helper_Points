import '../../../exports.dart';

class OtpController extends GetxController {
  OtpRepository? _repo;

  OtpController() {
    this._repo = OtpRepository();
  }

  void activateOtp(String otp) async {
    LoginController _loginController = Get.find<LoginController>();
    bool response = await _repo?.activation(_loginController.token, otp);

    if (response == true) {
      Get.offAll(HomeScreen());
    } else {
      Get.snackbar('Error', 'Something went wrong !',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
    }
  }
}
