import '../../../exports.dart';
import 'dart:io';

class ProfileController extends GetxController {
  User? loggedUser;
  bool isLoading = false;
  ProfileRepository? _repo;

  ProfileController() {
    this._repo = ProfileRepository();
  }

  Future<void> getMe() async {
    LoginController _loginController = Get.find<LoginController>();
    waiting();
    var user = await _repo?.getLogedUser(_loginController.token);

    if (user != null) {
      this.loggedUser = user;
      update();
      finished();
      if (loggedUser?.verified == '0') {
        finished();
        Get.offAll(OtpScreen());
      }
    } else {
      finished();
    }
    finished();
  }

  Future<User?> getProfile(String id) async {
    LoginController _loginController = Get.find<LoginController>();
    waiting();
    var user = await _repo?.getUser(_loginController.token!, id);
    finished();
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  Future<bool> updateAvatar(File file) async {
    String fileName = basename(file.path);
    LoginController _loginController = Get.find<LoginController>();
    waiting();
    String? avatar = await this._repo?.updateAvatar(
        file: file, filename: fileName, token: _loginController.token!);
    finished();
    if (avatar != null) {
      this.loggedUser?.avatar = avatar;
      update();
      return true;
    }
    return false;
  }

  Future<void> updateName(String firstName, String lastName) async {
    LoginController _loginController = Get.find<LoginController>();
    waiting();
    User? user = await this._repo?.updateName(
          id: this.loggedUser?.id,
          firstname: firstName,
          lastname: lastName,
          token: _loginController.token,
        );
    finished();
    if (user != null) {
      this.loggedUser?.firstName = user.firstName;
      this.loggedUser?.lastName = user.lastName;
      update();
      Get.offAll(HomeScreen());
    }
  }

  Future<void> changePassword(String newPassword, currentPassword) async {
    LoginController _loginController = Get.find<LoginController>();
    waiting();
    bool? resp = await this._repo?.changePassword(newPassword, currentPassword);
    finished();
    if (resp == true) {
      update();
      await Future.delayed(const Duration(seconds: 5), () {
        _loginController.logout();
      });
    }
  }

  Future<void> getVerification() async {
    LoginController _loginController = Get.find<LoginController>();
    var verification =
        await this._repo?.getVerification(_loginController.token!);
    if (verification != null) {
      this.loggedUser?.identityVerification = verification;
      update();
    } else {}
  }

  Future<bool> frontId(File file) async {
    String fileName = basename(file.path);
    LoginController _loginController = Get.find<LoginController>();
    waiting();
    IdentityVerification? id = await this
        ._repo
        ?.front(file: file, filename: fileName, token: _loginController.token!);
    finished();
    if (id != null) {
      this.loggedUser?.identityVerification = id;
      update();
      return true;
    }
    return false;
  }

  Future<bool> backId(File file) async {
    String fileName = basename(file.path);
    LoginController _loginController = Get.find<LoginController>();
    waiting();
    IdentityVerification? id = await this
        ._repo
        ?.back(file: file, filename: fileName, token: _loginController.token!);
    finished();
    if (id != null) {
      this.loggedUser?.identityVerification = id;
      update();
      return true;
    }
    return false;
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
